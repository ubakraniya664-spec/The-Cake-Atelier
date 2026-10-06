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
    public partial class View_Users : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Session protection: Admin only
            if (Session["admin"] == null)
            {
                Response.Redirect("Admin_Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                fillgrid();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Binds all registered users from tbl_users to GridView1
        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_users order by Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();

            lblUserCount.Text = "Total Members: " + ds.Tables[0].Rows.Count.ToString();
            con.Close();
        }

        // Deletes user account from tbl_users
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_del")
            {
                getCon();
                cmd = new SqlCommand("delete from tbl_users where Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillgrid();

                lblMsg.Text = "&#10004; Customer account deleted successfully!";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Admin_Login.aspx");
        }
    }
}
