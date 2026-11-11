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
    public partial class Manage_Cakes : System.Web.UI.Page
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

        // Binds all cakes from tbl_cakes to GridView1
        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_cakes order by Cake_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();
        }

        // Clear form inputs
        void clear()
        {
            lblEditId.Text = "";
            txtname.Text = "";
            txtprice.Text = "";
            txtdesc.Text = "";
            dropcategory.ClearSelection();
            droptype.ClearSelection();
            ViewState["Edit_Id"] = null;
        }

        // Populate edit form with cake details
        void filldata(string id)
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_cakes where Cake_Id='" + id + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblEditId.Text = "(Editing ID #" + id + ")";
                txtname.Text = ds.Tables[0].Rows[0]["Cake_Name"].ToString();
                txtprice.Text = ds.Tables[0].Rows[0]["Cake_Price"].ToString();
                txtdesc.Text = ds.Tables[0].Rows[0]["Cake_Desc"].ToString();

                dropcategory.ClearSelection();
                dropcategory.SelectedValue = ds.Tables[0].Rows[0]["Cake_Category"].ToString();

                droptype.ClearSelection();
                droptype.SelectedValue = ds.Tables[0].Rows[0]["Cake_Type"].ToString();
            }
            con.Close();
        }

        // Handle Edit and Delete commands from GridView
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                string id = e.CommandArgument.ToString();
                ViewState["Edit_Id"] = id;
                filldata(id); // Populates the form textboxes
                lblMsg.Visible = false;
            }
            else if (e.CommandName == "cmd_del")
            {
                getCon();
                cmd = new SqlCommand("delete from tbl_cakes where Cake_Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillgrid();
                clear();

                lblMsg.Text = "Cake deleted successfully!";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
            }
        }

        // Update cake details in database
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (ViewState["Edit_Id"] == null)
            {
                lblMsg.Text = "Please click 'Edit' on a cake from the table below first.";
                lblMsg.CssClass = "alert-box alert-danger";
                lblMsg.Visible = true;
                return;
            }

            if (txtname.Text != "" && txtprice.Text != "")
            {
                getCon();
                cmd = new SqlCommand("update tbl_cakes set Cake_Name='" + txtname.Text + "', Cake_Price=" + txtprice.Text + ", Cake_Desc='" + txtdesc.Text + "', Cake_Category='" + dropcategory.SelectedItem.Text + "', Cake_Type='" + droptype.SelectedItem.Text + "' where Cake_Id='" + ViewState["Edit_Id"] + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                clear();
                fillgrid();

                lblMsg.Text = "Cake updated successfully!";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
            }
        }

        // Resets the form fields
        protected void btnCancel_Click(object sender, EventArgs e)
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
