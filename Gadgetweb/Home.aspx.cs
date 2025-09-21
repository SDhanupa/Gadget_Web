using System;
using System.Text.RegularExpressions;
using System.Web.UI;

namespace GadgetHub
{
    public partial class Home : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Needed for the data binding expression for current year
            Page.DataBind();
        }

        protected void btnSubscribe_Click(object sender, EventArgs e)
        {
            string email = txtNewsletterEmail.Text?.Trim();

            if (string.IsNullOrWhiteSpace(email) || !IsValidEmail(email))
            {
                lblNewsletterMessage.CssClass = "text-danger";
                lblNewsletterMessage.Text = "Please enter a valid email address.";
                return;
            }

            // Normally, you'd save the email to a database or mailing list here.
            // For now, just show a success message.
            lblNewsletterMessage.CssClass = "text-success";
            lblNewsletterMessage.Text = "Thank you for subscribing!";
            txtNewsletterEmail.Text = "";
        }

        private bool IsValidEmail(string email)
        {
            // Simple RFC 5322 email regex pattern
            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";

            return Regex.IsMatch(email, pattern, RegexOptions.IgnoreCase);
        }
    }
}
