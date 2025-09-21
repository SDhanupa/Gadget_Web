using System;
using System.Web;
using System.Web.UI;

namespace Gadgetweb
{
    public partial class logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear the session
            Session.Clear();
            Session.Abandon();

            // Clear authentication cookie if any (for Forms Authentication)
            if (Request.Cookies[".ASPXAUTH"] != null)
            {
                var authCookie = new HttpCookie(".ASPXAUTH")
                {
                    Expires = DateTime.Now.AddDays(-1),
                    HttpOnly = true,
                    Secure = Request.IsSecureConnection
                };
                Response.Cookies.Add(authCookie);
            }

            // Optional: clear session cookie
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                var sessionCookie = new HttpCookie("ASP.NET_SessionId")
                {
                    Expires = DateTime.Now.AddDays(-1),
                    HttpOnly = true,
                    Secure = Request.IsSecureConnection
                };
                Response.Cookies.Add(sessionCookie);
            }

            // Redirect immediately (alternative to using meta refresh)
            // Response.Redirect("Login.aspx");
        }
    }
}
