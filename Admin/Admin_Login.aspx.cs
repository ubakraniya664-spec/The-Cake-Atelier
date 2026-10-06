using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace The_Cake_Atelier.Admin
{
    public partial class Admin_Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMsg.Visible = false;
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Authenticates admin and stores Username in Session["admin"]
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (txtadminemail.Text != "" && txtadminpwd.Text != "")
            {
                getCon();
                da = new SqlDataAdapter("select * from tbl_admin where (Username='" + txtadminemail.Text + "' or Email='" + txtadminemail.Text + "') and Password='" + txtadminpwd.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    // Always store the Admin Username for the header
                    Session["admin"] = ds.Tables[0].Rows[0]["Username"].ToString();
                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Admin Username or Password!";
                    lblMsg.Visible = true;
                }
            }
            else
            {
                lblMsg.Text = "Please enter both Username and Password!";
                lblMsg.Visible = true;
            }
        }
    }
}
