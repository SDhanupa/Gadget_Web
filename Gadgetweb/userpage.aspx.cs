using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Gadgetweb
{
    public partial class userpage : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                PopulateUserProfile();
                DataBind(); 
            }
        }

        private void PopulateUserProfile()
        {
            string username = Session["Username"].ToString();
            lblUsername.Text = Server.HtmlEncode(username);

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (var conn = new SqlConnection(connStr))
            {
                const string sql = @"
                    SELECT 
                        CreatedAt,  -- Replace with your actual registration column name
                        (SELECT COUNT(*) FROM Orders WHERE Username = @Username) AS TotalOrders
                    FROM Users
                    WHERE Username = @Username";

                using (var cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    conn.Open();

                    using (var reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            if (!reader.IsDBNull(reader.GetOrdinal("CreatedAt")))
                            {
                                DateTime regDate = reader.GetDateTime(reader.GetOrdinal("CreatedAt"));
                                lblMemberSince.Text = regDate.ToString("MMMM dd, yyyy");
                            }
                            else
                            {
                                lblMemberSince.Text = "N/A";
                            }

                            int totalOrders = reader.GetInt32(reader.GetOrdinal("TotalOrders"));
                            lblTotalOrders.Text = totalOrders.ToString();
                        }
                        else
                        {
                            Session.Clear();
                            Response.Redirect("Login.aspx");
                        }
                    }
                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear session and sign out properly
            Session.Clear();
            Session.Abandon();

            // Optional: Clear authentication cookie if using Forms Authentication
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var c = new System.Web.HttpCookie(".ASPXAUTH")
                {
                    Expires = DateTime.Now.AddDays(-1)
                };
                Response.Cookies.Add(c);
            }

            Response.Redirect("Login.aspx");
        }
    }
}
