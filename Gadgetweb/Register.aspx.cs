using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace Gadgetweb
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No code needed for initial load.
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;
            string role = rbSeller.Checked ? "Seller" : "Buyer";

            string passwordHash = ComputeSha256Hash(password);

            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
               
                    string checkSql = "SELECT COUNT(*) FROM Users WHERE Username=@Username OR Email=@Email";
                    using (SqlCommand cmd = new SqlCommand(checkSql, conn))
                    {
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);

                        int exists = (int)cmd.ExecuteScalar();
                        if (exists > 0)
                        {
                            vsSummary.HeaderText = "";
                            vsSummary.ShowSummary = true;
                            vsSummary.Controls.Clear();
                            vsSummary.Controls.Add(new LiteralControl("<ul><li>Username or email already exists. Please choose another.</li></ul>"));
                            return;
                        }
                    }
                    
                    string insertSql = @"INSERT INTO Users (Username, Email, PasswordHash, Role, CreatedAt)
                                         VALUES (@Username, @Email, @PasswordHash, @Role, GETDATE())";
                    using (SqlCommand cmdInsert = new SqlCommand(insertSql, conn))
                    {
                        cmdInsert.Parameters.AddWithValue("@Username", username);
                        cmdInsert.Parameters.AddWithValue("@Email", email);
                        cmdInsert.Parameters.AddWithValue("@PasswordHash", passwordHash);
                        cmdInsert.Parameters.AddWithValue("@Role", role);
                        cmdInsert.ExecuteNonQuery();
                    }
                }
                
                Response.Redirect("Login.aspx?registered=1");
            }
            catch (Exception ex)
            {
                vsSummary.ShowSummary = true;
                vsSummary.Controls.Clear();
                vsSummary.Controls.Add(new LiteralControl($"<ul><li>Registration error: {ex.Message}</li></ul>"));
            }
        }

        private static string ComputeSha256Hash(string rawData)
        {
            using (SHA256 sha256Hash = SHA256.Create())
            {
                byte[] bytes = sha256Hash.ComputeHash(Encoding.UTF8.GetBytes(rawData));
                return Convert.ToBase64String(bytes);
            }
        }
    }
}
