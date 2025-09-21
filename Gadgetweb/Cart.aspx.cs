using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gadgetweb
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCartData();
            }
        }

        private void LoadCartData()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            DataTable cartItems = FetchCartItems(userId);

            if (cartItems.Rows.Count == 0)
            {
                pnlCart.Visible = false;
                pnlEmptyCart.Visible = true;
                return;
            }

            decimal totalPrice = 0m;
            foreach (DataRow row in cartItems.Rows)
            {
                int quantity = Convert.ToInt32(row["Quantity"]);
                decimal price = Convert.ToDecimal(row["Price"]);
                decimal subtotal = quantity * price;
                row["Subtotal"] = subtotal;
                totalPrice += subtotal;
            }

            rptCartItems.DataSource = cartItems;
            rptCartItems.DataBind();

            lblTotalPrice.Text = totalPrice.ToString("F2");

            pnlCart.Visible = true;
            pnlEmptyCart.Visible = false;
        }

        private DataTable FetchCartItems(int userId)
        {
            DataTable dt = new DataTable();
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            string sql = @"
                SELECT ci.Id, ci.ProductId, p.ProductName, p.Description, p.ImageUrl, ci.Quantity, ci.Price
                FROM CartItems ci
                INNER JOIN Products p ON ci.ProductId = p.Id
                WHERE ci.UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    dt.Load(reader);
                }
            }

            if (!dt.Columns.Contains("Subtotal"))
                dt.Columns.Add("Subtotal", typeof(decimal));

            return dt;
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);

            if (e.CommandName == "RemoveItem")
            {
                int cartItemId = Convert.ToInt32(e.CommandArgument);
                RemoveCartItem(userId, cartItemId);
                LoadCartData();
            }
            else if (e.CommandName == "BuyItem")
            {
                int cartItemId = Convert.ToInt32(e.CommandArgument);
                CartItemDetail item = GetCartItem(userId, cartItemId);
                if (item != null)
                {
                    Session["BuyItem"] = item;
                    Response.Redirect("Pay.aspx?singleItem=true");
                }
            }
        }

        private void RemoveCartItem(int userId, int cartItemId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            string sql = "DELETE FROM CartItems WHERE Id = @Id AND UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Id", cartItemId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private CartItemDetail GetCartItem(int userId, int cartItemId)
        {
            CartItemDetail item = null;

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            string sql = @"
                SELECT ci.Id, ci.ProductId, p.ProductName, p.Description, p.ImageUrl, ci.Quantity, ci.Price
                FROM CartItems ci
                INNER JOIN Products p ON ci.ProductId = p.Id
                WHERE ci.Id = @Id AND ci.UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@Id", cartItemId);
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        item = new CartItemDetail
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                            ProductName = reader.GetString(reader.GetOrdinal("ProductName")),
                            Description = reader.GetString(reader.GetOrdinal("Description")),
                            ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                            Quantity = reader.GetInt32(reader.GetOrdinal("Quantity")),
                            Price = reader.GetDecimal(reader.GetOrdinal("Price"))
                        };
                    }
                }
            }

            return item;
        }

        protected void btnBuyAll_Click(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }
            int userId = Convert.ToInt32(Session["UserId"]);
            List<CartItemDetail> items = GetAllCartItems(userId);

            if (items.Count == 0)
            {
                // Optionally notify empty cart
                return;
            }

            Session["BuyItems"] = items;
            Response.Redirect("Pay.aspx?allItems=true");
        }

        private List<CartItemDetail> GetAllCartItems(int userId)
        {
            var list = new List<CartItemDetail>();

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            string sql = @"
                SELECT ci.Id, ci.ProductId, p.ProductName, p.Description, p.ImageUrl, ci.Quantity, ci.Price
                FROM CartItems ci
                INNER JOIN Products p ON ci.ProductId = p.Id
                WHERE ci.UserId = @UserId";

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        list.Add(new CartItemDetail
                        {
                            Id = reader.GetInt32(reader.GetOrdinal("Id")),
                            ProductId = reader.GetInt32(reader.GetOrdinal("ProductId")),
                            ProductName = reader.GetString(reader.GetOrdinal("ProductName")),
                            Description = reader.GetString(reader.GetOrdinal("Description")),
                            ImageUrl = reader.GetString(reader.GetOrdinal("ImageUrl")),
                            Quantity = reader.GetInt32(reader.GetOrdinal("Quantity")),
                            Price = reader.GetDecimal(reader.GetOrdinal("Price"))
                        });
                    }
                }
            }

            return list;
        }
    }

    [Serializable]
    public class CartItemDetail
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public string ProductName { get; set; } = "";
        public string Description { get; set; } = "";
        public string ImageUrl { get; set; } = "";
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
