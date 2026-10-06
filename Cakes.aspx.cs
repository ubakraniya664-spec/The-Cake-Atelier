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
    public partial class Cakes : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Session Greeting & Nav Toggles
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

            if (!IsPostBack)
            {
                fillDataList();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Binds cakes dynamically based on SQL filter query
        void fillDataList()
        {
            getCon();
            string query = "select * from tbl_cakes where 1=1";

            if (ddlCategory.SelectedValue != "All")
            {
                query += " and Cake_Category='" + ddlCategory.SelectedValue + "'";
            }

            if (ddlType.SelectedValue != "All")
            {
                query += " and Cake_Type='" + ddlType.SelectedValue + "'";
            }

            da = new SqlDataAdapter(query, con);
            ds = new DataSet();
            da.Fill(ds);

            DataListCakes.DataSource = ds;
            DataListCakes.DataBind();

            lblFilterStatus.Text = "Showing " + ds.Tables[0].Rows.Count + " confections";
            con.Close();
        }

        protected void ddlFilter_Changed(object sender, EventArgs e)
        {
            fillDataList();
        }

        // Add to Cart handles authentication & passes cake id
        protected void DataListCakes_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AddToCart")
            {
                if (Session["user"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    Session["cart_cake_id"] = e.CommandArgument.ToString();
                    Response.Redirect("Cart.aspx");
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
