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
    public partial class About : System.Web.UI.Page
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
            }
            else
            {
                lblUserGreeting.Visible = false;
                lnkLogout.Visible = false;
                lnkDashboard.Visible = false;
                lnkLogin.Visible = true;
                lnkRegister.Visible = true;
            }
        }

        // Handles user logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
