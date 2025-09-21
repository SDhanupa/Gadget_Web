using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;

namespace GadgetWeb
{
    public partial class Manage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                lblUsername.Text = Server.HtmlEncode(Session["Username"]?.ToString() ?? "User");
                LoadProducts();
            }
        }

        private void LoadProducts()
        {
            int userId = (int)Session["UserId"];
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            DataTable dt = new DataTable();

            string sql = "SELECT Id, ProductName, Description, Price, ImageUrl, Quantity FROM Products WHERE UserId=@UserId ORDER BY Id DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                using (var adapter = new SqlDataAdapter(cmd))
                {
                    adapter.Fill(dt);
                }
            }

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            int userId = (int)Session["UserId"];
            string name = txtName.Text.Trim();
            string desc = txtDescription.Text.Trim();

            if (!decimal.TryParse(txtPrice.Text.Trim(), out decimal price) || price < 0)
            {
                ShowFeedback("Please enter a valid positive price.", true);
                return;
            }

            if (!int.TryParse(txtQuantity.Text.Trim(), out int quantity) || quantity < 0)
            {
                ShowFeedback("Please enter a valid non-negative quantity.", true);
                return;
            }

            string imageUrl = null;
            if (fuImage.HasFile)
            {
                var ext = Path.GetExtension(fuImage.FileName).ToLowerInvariant();
                if (ext != ".jpg" && ext != ".jpeg" && ext != ".png" && ext != ".gif")
                {
                    ShowFeedback("Image must be JPG, JPEG, PNG, or GIF format.", true);
                    return;
                }

                string filename = Path.GetFileNameWithoutExtension(fuImage.FileName);
                string newName = $"{filename}_{DateTime.Now:yyyyMMddHHmmss}{ext}";

                string saveDir = Server.MapPath("~/Images/Products/");
                if (!Directory.Exists(saveDir))
                    Directory.CreateDirectory(saveDir);

                string savePath = Path.Combine(saveDir, newName);
                fuImage.SaveAs(savePath);

                imageUrl = "images/products/" + newName.Replace('\\', '/');
            }

            int productId = 0;
            int.TryParse(hfProductId.Value, out productId);

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                if (productId == 0)
                {
                    string insertSql = @"INSERT INTO Products (ProductName, Description, Price, ImageUrl, UserId, Quantity)
                                         VALUES (@Name, @Desc, @Price, @Img, @UserId, @Qty)";
                    using (SqlCommand cmd = new SqlCommand(insertSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Img", (object)imageUrl ?? DBNull.Value);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Qty", quantity);
                        cmd.ExecuteNonQuery();
                    }
                    ShowFeedback("Product added successfully.");
                }
                else
                {
                    string updateSql = @"UPDATE Products SET ProductName = @Name, Description = @Desc, Price = @Price, Quantity = @Qty {0} 
                                         WHERE Id = @Id AND UserId = @UserId";
                    string imageClause = imageUrl != null ? ", ImageUrl = @Img" : "";
                    updateSql = string.Format(updateSql, imageClause);

                    using (SqlCommand cmd = new SqlCommand(updateSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Desc", desc);
                        cmd.Parameters.AddWithValue("@Price", price);
                        cmd.Parameters.AddWithValue("@Qty", quantity);
                        cmd.Parameters.AddWithValue("@Id", productId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        if (imageUrl != null)
                            cmd.Parameters.AddWithValue("@Img", imageUrl);

                        int updated = cmd.ExecuteNonQuery();
                        if (updated > 0)
                            ShowFeedback("Product updated successfully.");
                        else
                            ShowFeedback("Product was not found or update failed.", true);
                    }
                }
            }

            ClearForm();
            LoadProducts();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        protected void rptProducts_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int userId = (int)Session["UserId"];

            if (e.CommandName == "EditProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument);

                string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products WHERE Id = @Id AND UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@Id", productId);
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            hfProductId.Value = productId.ToString();
                            txtName.Text = reader["ProductName"].ToString();
                            txtDescription.Text = reader["Description"].ToString();
                            txtPrice.Text = reader["Price"].ToString();
                            txtQuantity.Text = reader["Quantity"].ToString();

                            string img = reader["ImageUrl"] as string;
                            if (!string.IsNullOrWhiteSpace(img))
                            {
                                imgPreview.ImageUrl = "~/" + img.Replace('\\', '/');
                                imgPreview.Visible = true;
                            }
                            else
                            {
                                imgPreview.ImageUrl = "";
                                imgPreview.Visible = false;
                            }
                        }
                        else
                        {
                            ShowFeedback("Product not found or you do not have permission.", true);
                        }
                    }
                }
            }
            else if (e.CommandName == "DeleteProduct")
            {
                int productId = Convert.ToInt32(e.CommandArgument);

                string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM OrderItems WHERE ProductId = @ProductId", conn))
                {
                    checkCmd.Parameters.AddWithValue("@ProductId", productId);
                    conn.Open();

                    int count = (int)checkCmd.ExecuteScalar();
                    if (count > 0)
                    {
                        ShowFeedback("Cannot delete product. It has associated orders.", true);
                        return;
                    }
                }

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmdDelete = new SqlCommand("DELETE FROM Products WHERE Id = @Id AND UserId = @UserId", conn))
                {
                    cmdDelete.Parameters.AddWithValue("@Id", productId);
                    cmdDelete.Parameters.AddWithValue("@UserId", userId);
                    conn.Open();

                    int deleted = cmdDelete.ExecuteNonQuery();
                    if (deleted > 0)
                        ShowFeedback("Product deleted successfully.");
                    else
                        ShowFeedback("Product not found or deletion failed.", true);
                }

                LoadProducts();
            }
        }

        private void ShowFeedback(string message, bool error = false)
        {
            pnlFeedback.CssClass = error ? "feedback-message alert-danger show-feedback" : "feedback-message alert-success show-feedback";
            lblFeedback.Text = message;
            pnlFeedback.Visible = true;
        }

        private void ClearForm()
        {
            hfProductId.Value = "";
            txtName.Text = "";
            txtDescription.Text = "";
            txtPrice.Text = "";
            txtQuantity.Text = "";
            imgPreview.Visible = false;
            imgPreview.ImageUrl = "";
            fuImage.Attributes.Clear();
            pnlFeedback.Visible = false;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
