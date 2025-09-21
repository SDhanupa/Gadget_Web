using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gadgetweb
{
    public partial class items : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitializeUserProfile();
                LoadAllProducts();
                RefreshCartSummary();
            }
        }

        private void InitializeUserProfile()
        {
            if (Session["Username"] != null)
            {
                lblUsername.Text = Server.HtmlEncode(Session["Username"].ToString());
                phUserLinks.Visible = true;
                phGuestLinks.Visible = false;
            }
            else
            {
                phUserLinks.Visible = false;
                phGuestLinks.Visible = true;
            }
        }

        private void LoadAllProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Id, ProductName, Description, Price, ImageUrl FROM Products ORDER BY ProductName ASC";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();
                    dt.Load(reader);
                }
            }

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            Button btn = (Button)sender;
            if (!int.TryParse(btn.CommandArgument, out int productId))
                return;

            int userId = (int)Session["UserId"];
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                decimal price = 0;
                using (SqlCommand cmdPrice = new SqlCommand("SELECT Price FROM Products WHERE Id = @ProductId", conn))
                {
                    cmdPrice.Parameters.AddWithValue("@ProductId", productId);
                    object res = cmdPrice.ExecuteScalar();
                    if (res == null)
                        return;
                    price = Convert.ToDecimal(res);
                }

                int count;
                using (SqlCommand cmdCount = new SqlCommand("SELECT COUNT(*) FROM CartItems WHERE UserId = @UserId AND ProductId = @ProductId", conn))
                {
                    cmdCount.Parameters.AddWithValue("@UserId", userId);
                    cmdCount.Parameters.AddWithValue("@ProductId", productId);
                    count = (int)cmdCount.ExecuteScalar();
                }

                if (count > 0)
                {
                    using (SqlCommand cmdUpdate = new SqlCommand("UPDATE CartItems SET Quantity = Quantity + 1, Price = @Price WHERE UserId = @UserId AND ProductId = @ProductId", conn))
                    {
                        cmdUpdate.Parameters.AddWithValue("@Price", price);
                        cmdUpdate.Parameters.AddWithValue("@UserId", userId);
                        cmdUpdate.Parameters.AddWithValue("@ProductId", productId);
                        cmdUpdate.ExecuteNonQuery();
                    }
                }
                else
                {
                    using (SqlCommand cmdInsert = new SqlCommand("INSERT INTO CartItems (UserId, ProductId, Quantity, Price) VALUES (@UserId, @ProductId, 1, @Price)", conn))
                    {
                        cmdInsert.Parameters.AddWithValue("@UserId", userId);
                        cmdInsert.Parameters.AddWithValue("@ProductId", productId);
                        cmdInsert.Parameters.AddWithValue("@Price", price);
                        cmdInsert.ExecuteNonQuery();
                    }
                }
            }

            RefreshCartSummary();
        }

        private void RefreshCartSummary()
        {
            if (Session["UserId"] == null)
            {
                pnlCartSummary.Visible = false;
                return;
            }

            int userId = (int)Session["UserId"];
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT SUM(Quantity) FROM CartItems WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    object result = cmd.ExecuteScalar();

                    if (result != DBNull.Value && result != null)
                    {
                        int totalItems = Convert.ToInt32(result);
                        pnlCartSummary.Visible = totalItems > 0;
                        lblCartSummary.Text = $"Cart: {totalItems} item{(totalItems > 1 ? "s" : "")}";
                    }
                    else
                    {
                        pnlCartSummary.Visible = false;
                    }
                }
            }
        }

        protected void pnlCartSummary_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();

            // Clear authentication cookie if used
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var authCookie = new System.Web.HttpCookie(".ASPXAUTH")
                {
                    Expires = DateTime.Now.AddDays(-1),
                    HttpOnly = true,
                    Secure = Request.IsSecureConnection
                };
                Response.Cookies.Add(authCookie);
            }

            Response.Redirect("Home.aspx");
        }
    }
}
