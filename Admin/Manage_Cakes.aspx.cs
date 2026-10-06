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

        // Fills the edit form with selected cake's existing data
        void filldata(string id)
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_cakes where Cake_Id='" + id + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                lblEditId.Text = id;
                txtname.Text = ds.Tables[0].Rows[0]["Cake_Name"].ToString();
                txtprice.Text = ds.Tables[0].Rows[0]["Cake_Price"].ToString();
                txtdesc.Text = ds.Tables[0].Rows[0]["Cake_Desc"].ToString();

                string cat = ds.Tables[0].Rows[0]["Cake_Category"].ToString();
                dropcategory.ClearSelection();
                if (dropcategory.Items.FindByText(cat) != null)
                {
                    dropcategory.Items.FindByText(cat).Selected = true;
                }

                string type = ds.Tables[0].Rows[0]["Cake_Type"].ToString();
                droptype.ClearSelection();
                if (droptype.Items.FindByText(type) != null)
                {
                    droptype.Items.FindByText(type).Selected = true;
                }
            }
            con.Close();
        }

        // Handles Edit & Delete commands (Strictly mimicking Reference_Code GridView1_RowCommand)
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "cmd_edt")
            {
                string id = e.CommandArgument.ToString();
                ViewState["Edit_Id"] = id;
                filldata(id);
                pnlEdit.Visible = true;
                lblMsg.Visible = false;
            }
            else if (e.CommandName == "cmd_del")
            {
                getCon();
                cmd = new SqlCommand("delete from tbl_cakes where Cake_Id='" + e.CommandArgument + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillgrid();

                lblMsg.Text = "&#10004; Cake deleted successfully!";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
                pnlEdit.Visible = false;
            }
        }

        // Saves updated cake details into tbl_cakes
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (txtname.Text != "" && txtprice.Text != "")
            {
                getCon();
                cmd = new SqlCommand("update tbl_cakes set Cake_Name='" + txtname.Text + "', Cake_Price=" + txtprice.Text + ", Cake_Desc='" + txtdesc.Text + "', Cake_Category='" + dropcategory.SelectedItem.Text + "', Cake_Type='" + droptype.SelectedItem.Text + "' where Cake_Id='" + ViewState["Edit_Id"] + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                fillgrid();
                pnlEdit.Visible = false;

                lblMsg.Text = "&#10004; Cake updated successfully!";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            pnlEdit.Visible = false;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Admin_Login.aspx");
        }
    }
}
