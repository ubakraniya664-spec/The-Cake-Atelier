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
    public partial class Admin_Register : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        int count;

        string img;
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

        // Saves admin photo directly inside Admin/Images/
        void imageupload()
        {
            if (FileUpload1.HasFile)
            {
                img = "Images/" + FileUpload1.FileName;
                FileUpload1.SaveAs(Server.MapPath("~/Admin/Images/" + FileUpload1.FileName));
            }
            else
            {
                img = "";
            }
        }

        void clear()
        {
            txtfullname.Text = "";
            txtemail.Text = "";
            txtmobile.Text = "";
            txtuser.Text = "";
            txtpwd.Text = "";
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (txtfullname.Text == "" || txtemail.Text == "" || txtuser.Text == "" || txtpwd.Text == "")
            {
                lblMsg.Text = "Please fill in all required fields (Name, Email, Username, and Password).";
                lblMsg.CssClass = "alert-box alert-error";
                lblMsg.Visible = true;
                return;
            }

            getCon();

            // 1. Check if username or email already exists
            cmd = new SqlCommand("select count(*) from tbl_admin where Username='" + txtuser.Text + "' or Email='" + txtemail.Text + "'", con);
            count = Convert.ToInt32(cmd.ExecuteScalar());

            if (count > 0)
            {
                lblMsg.Text = "An admin with this Username or Email already exists!";
                lblMsg.CssClass = "alert-box alert-error";
                lblMsg.Visible = true;
                con.Close();
                return;
            }

            // 2. Upload photo into Admin/Images/
            imageupload();

            // 3. Insert new admin record
            cmd = new SqlCommand("insert into tbl_admin(FullName, Username, Email, Password, Mobile, Image) values('" + txtfullname.Text + "', '" + txtuser.Text + "', '" + txtemail.Text + "', '" + txtpwd.Text + "', '" + txtmobile.Text + "', '" + img + "')", con);
            cmd.ExecuteNonQuery();
            con.Close();

            // 4. Clear form and show success
            clear();
            lblMsg.Text = "&#10004; Admin account created successfully! You may now <a href='Admin_Login.aspx' style='color:#155724; font-weight:bold; text-decoration:underline;'>Login Here &rarr;</a>";
            lblMsg.CssClass = "alert-box alert-success";
            lblMsg.Visible = true;
        }
    }
}
