using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace GadgetHub
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["Role"] != null)
                {
                    RedirectUserByRole(Session["Role"].ToString());
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text;

            string passwordHash = ComputeSha256Hash(password);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    string sql = "SELECT Id, Role FROM Users WHERE Username = @Username AND PasswordHash = @PasswordHash";
                    using (SqlCommand cmd = new SqlCommand(sql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@PasswordHash", passwordHash);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                int userId = reader.GetInt32(reader.GetOrdinal("Id"));
                                string role = reader.GetString(reader.GetOrdinal("Role"));

                                Session["Username"] = username;
                                Session["UserId"] = userId;
                                Session["Role"] = role;

                                RedirectUserByRole(role);
                            }
                            else
                            {
                                ShowValidationError("Invalid username or password.");
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowValidationError("An unexpected error occurred. Please try again later.");
                // Consider logging 'ex' somewhere for troubleshooting
            }
        }

        private void ShowValidationError(string message)
        {
            ValidationSummary1.HeaderText = "";
            ValidationSummary1.ShowSummary = true;
            ValidationSummary1.Controls.Clear();
            ValidationSummary1.Controls.Add(new LiteralControl($"<ul><li>{message}</li></ul>"));
        }

        private static string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                return Convert.ToBase64String(bytes);
            }
        }

        private void RedirectUserByRole(string role)
        {
            switch (role.ToLowerInvariant())
            {
                case "seller":
                    Response.Redirect("Sellerpage.aspx");
                    break;
                case "buyer":
                    Response.Redirect("userpage.aspx");
                    break;
                default:
                    Response.Redirect("Home.aspx");
                    break;
            }
        }
    }
}
