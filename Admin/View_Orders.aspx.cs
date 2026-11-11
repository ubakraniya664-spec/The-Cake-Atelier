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
    public partial class View_Orders : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
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

        // Load all customer orders
        void fillgrid()
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_orders order by order_id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            GridView1.DataSource = ds;
            GridView1.DataBind();

            lblOrderCount.Text = "Total Orders: " + ds.Tables[0].Rows.Count.ToString();
            con.Close();
        }

        // Set row in edit mode
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            fillgrid();
        }

        // Cancel row edit
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            fillgrid();
        }

        // Update order status in database
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int orderId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            DropDownList ddl = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlStatus");
            if (ddl != null)
            {
                string newStatus = ddl.SelectedValue;
                getCon();
                cmd = new SqlCommand("update tbl_orders set payment_status='" + newStatus + "' where order_id=" + orderId, con);
                cmd.ExecuteNonQuery();
                con.Close();

                lblMsg.Text = "&#10004; Order #" + orderId + " status updated to " + newStatus + ".";
                lblMsg.CssClass = "alert-box alert-success";
                lblMsg.Visible = true;
            }

            GridView1.EditIndex = -1;
            fillgrid();
        }

        // Delete order and its items
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            getCon();
            cmd = new SqlCommand("delete from tbl_order_items where order_id=" + orderId, con);
            cmd.ExecuteNonQuery();

            cmd = new SqlCommand("delete from tbl_orders where order_id=" + orderId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            GridView1.EditIndex = -1;
            fillgrid();

            lblMsg.Text = "&#10004; Order deleted successfully!";
            lblMsg.CssClass = "alert-box alert-success";
            lblMsg.Visible = true;
        }
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Admin_Login.aspx");
        }
    }
}