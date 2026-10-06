using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace The_Cake_Atelier
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check session to update sticky navigation bar greeting and links
            if (Session["user"] != null)
            {
                lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();
                lblUserGreeting.Visible = true;
                lnkLogout.Visible = true;
                lnkDashboard.Visible = true;
                lnkLogin.Visible = false;
                lnkRegister.Visible = false;

                // Pre-fill email if user is logged in
                if (!IsPostBack && string.IsNullOrWhiteSpace(txtEmail.Text))
                {
                    txtEmail.Text = Session["user"].ToString();
                }
            }
            else
            {
                lblUserGreeting.Visible = false;
                lnkLogout.Visible = false;
                lnkDashboard.Visible = false;
                lnkLogin.Visible = true;
                lnkRegister.Visible = true;
            }

            if (!IsPostBack)
            {
                lblContactMessage.Visible = false;
            }
        }

        // Handles custom order consultation submission
        protected void btnSendMessage_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtName.Text) || string.IsNullOrWhiteSpace(txtEmail.Text) || string.IsNullOrWhiteSpace(txtPhone.Text))
            {
                lblContactMessage.Text = "Please provide your Name, Email, and Phone number so we can contact you.";
                lblContactMessage.CssClass = "alert-box alert-error";
                lblContactMessage.Visible = true;
                return;
            }

            lblContactMessage.Text = "&#10004; Thank you, <strong>" + txtName.Text + "</strong>! Your custom cake consultation request for <em>" +
                ddlInquiryType.SelectedItem.Text + "</em> has been received. Our head pastry chef will contact you shortly!";
            lblContactMessage.CssClass = "alert-box";
            lblContactMessage.Visible = true;

            // Clear input fields
            txtName.Text = string.Empty;
            if (Session["user"] == null) txtEmail.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtMessage.Text = string.Empty;
        }

        // Handles user logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
