using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace GadgetWeb
{
    public partial class Seller : Page
    {
        public string SalesLabelsJson { get; private set; } = "[]";
        public string SalesDataJson { get; private set; } = "[]";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null || Session["Username"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                lblUsername.Text = Server.HtmlEncode(Session["Username"].ToString());

                try
                {
                    LoadSellerProducts();
                    LoadSalesData();
                }
                catch (Exception ex)
                {
                    
                }
            }
        }

        private void LoadSellerProducts()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            DataTable dt = new DataTable();

            string sql = @"
                SELECT p.Id, p.ProductName, p.Description, p.Price, p.ImageUrl,
                       ISNULL(SUM(oi.Quantity), 0) AS TotalQuantitySold,
                       ISNULL(SUM(oi.Quantity * oi.Price), 0) AS TotalSalesAmount
                FROM Products p
                LEFT JOIN OrderItems oi ON p.Id = oi.ProductId
                WHERE p.UserId = @UserId
                GROUP BY p.Id, p.ProductName, p.Description, p.Price, p.ImageUrl
                ORDER BY TotalQuantitySold DESC";

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }

            rptProducts.DataSource = dt;
            rptProducts.DataBind();
        }

        private void LoadSalesData()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            DataTable dt = new DataTable();

            string sql = @"
                SELECT p.ProductName, ISNULL(SUM(oi.Quantity), 0) AS TotalSold
                FROM Products p
                LEFT JOIN OrderItems oi ON p.Id = oi.ProductId
                WHERE p.UserId = @UserId
                GROUP BY p.ProductName
                ORDER BY TotalSold DESC";

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(sql, conn))
            {
                cmd.Parameters.AddWithValue("@UserId", userId);
                conn.Open();
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }

            List<string> labels = new List<string>();
            List<int> data = new List<int>();

            foreach (DataRow row in dt.Rows)
            {
                labels.Add(row["ProductName"].ToString());
                data.Add(Convert.ToInt32(row["TotalSold"]));
            }

            SalesLabelsJson = new JavaScriptSerializer().Serialize(labels);
            SalesDataJson = new JavaScriptSerializer().Serialize(data);
        }

        protected void Logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
