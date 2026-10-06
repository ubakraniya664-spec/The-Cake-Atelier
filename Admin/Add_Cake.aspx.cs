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
    public partial class Add_Cake : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string img;
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
                lblMsg.Visible = false;
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
                FileUpload1.SaveAs(Server.MapPath("~/images/" + FileUpload1.FileName));
            }
            else
            {
                img = "images/chocolate_truffle.jpg"; // Default fallback image
            }
        }

        void clear()
        {
            txtname.Text = "";
            txtprice.Text = "";
            txtdesc.Text = "";
            dropcategory.SelectedIndex = 0;
            droptype.SelectedIndex = 0;
        }

        // Inserts new cake record into tbl_cakes (mimicking Reference_Code Add_Product.aspx.cs)
        protected void btnAddCake_Click(object sender, EventArgs e)
        {
            if (txtname.Text == "" || txtprice.Text == "" || txtdesc.Text == "")
            {
                lblMsg.Text = "Please fill in Cake Name, Price, and Description.";
                lblMsg.CssClass = "alert-box alert-error";
                lblMsg.Visible = true;
                return;
            }

            getCon();
            imageupload();

            // Insert into tbl_cakes
            cmd = new SqlCommand("insert into tbl_cakes(Cake_Name, Cake_Price, Cake_Desc, Cake_Image, Cake_Category, Cake_Type) values('" + txtname.Text + "', " + txtprice.Text + ", '" + txtdesc.Text + "', '" + img + "', '" + dropcategory.SelectedItem.Text + "', '" + droptype.SelectedItem.Text + "')", con);
            cmd.ExecuteNonQuery();
            con.Close();

            clear();
            lblMsg.Text = "&#10004; Cake added successfully to the catalog! View it on <a href='../Cakes.aspx' target='_blank' style='color:#155724; font-weight:bold; text-decoration:underline;'>Cakes &amp; Menu &rarr;</a>";
            lblMsg.CssClass = "alert-box alert-success";
            lblMsg.Visible = true;
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            clear();
            lblMsg.Visible = false;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Admin_Login.aspx");
        }
    }
}
