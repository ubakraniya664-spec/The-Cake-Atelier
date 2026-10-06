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
    public partial class login : System.Web.UI.Page
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

        // Authenticate and store Name in Session["user"]
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txtemail.Text != "" && txtpwd.Text != "")
            {
                getCon();
                da = new SqlDataAdapter("select * from tbl_users where Email='" + txtemail.Text + "' and Password='" + txtpwd.Text + "'", con);
                ds = new DataSet();
                da.Fill(ds);
                con.Close();

                if (ds.Tables[0].Rows.Count > 0)
                {
                    // Store Customer Name for the header greeting (e.g. "Welcome, Trusha")
                    Session["user"] = ds.Tables[0].Rows[0]["Name"].ToString();

                    // Store Customer Email for database orders
                    Session["user_email"] = ds.Tables[0].Rows[0]["Email"].ToString();

                    if (Session["cart_cake_id"] != null)
                    {
                        Response.Redirect("Cart.aspx");
                    }
                    else
                    {
                        Response.Redirect("User_Dashboard.aspx");
                    }
                }
                else
                {
                    lblMsg.Text = "Invalid Email or Password! Please try again.";
                    lblMsg.Visible = true;
                }
            }
            else
            {
                lblMsg.Text = "Please enter both Email and Password!";
                lblMsg.Visible = true;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }
    }
}
