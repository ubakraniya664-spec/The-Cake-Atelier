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
    public partial class register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string img;
        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label8.Visible = false;
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void imageupload()
        {
            if (FileUpload1.HasFile)
            {
                img = "images/" + FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath(img));
            }
            else
            {
                img = "images/chef.jpg";
            }
        }

        void clear()
        {
            txtname.Text = "";
            txtemail.Text = "";
            txtpwd.Text = "";
            txtaddress.Text = "";
            txtmobile.Text = "";
            rblg.SelectedIndex = 0;
            DropDownList1.SelectedIndex = 0;
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (txtname.Text == "" || txtemail.Text == "" || txtpwd.Text == "")
            {
                Label8.Text = "Please fill in Name, Email, and Password.";
                Label8.CssClass = "alert-box alert-error";
                Label8.Visible = true;
                return;
            }

            getCon();

            // 1. Check if user already exists
            cmd = new SqlCommand("select count(*) from tbl_users where Email='" + txtemail.Text + "'", con);
            int count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count > 0)
            {
                Label8.Text = "An account with this email already exists! <a href='login.aspx' style='color:#c45b4c; font-weight:bold; text-decoration:underline;'>Login Here &rarr;</a>";
                Label8.CssClass = "alert-box alert-error";
                Label8.Visible = true;
                con.Close();
                return;
            }

            // 2. Upload photo
            imageupload();

            // 3. Simple Insert Query (Exactly like Reference Code)
            cmd = new SqlCommand("insert into tbl_users(Name, Gender, Email, Password, City, Address, Mobile, Image) values('" + txtname.Text + "', '" + rblg.SelectedItem.Text + "', '" + txtemail.Text + "', '" + txtpwd.Text + "', '" + DropDownList1.SelectedItem.Text + "', '" + txtaddress.Text + "', '" + txtmobile.Text + "', '" + img + "')", con);
            cmd.ExecuteNonQuery();
            con.Close();

            clear();
            Label8.Text = "&#10004; Account successfully created! You may now <a href='login.aspx' style='color:#155724; font-weight:bold; text-decoration:underline;'>Login Here &rarr;</a>";
            Label8.CssClass = "alert-box";
            Label8.Visible = true;
        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {
            Response.Redirect("login.aspx");
        }
    }
}
