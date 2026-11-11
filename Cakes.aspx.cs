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
        SqlCommand cmd;
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

        // Filter cakes by category and type
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

        // Add cake to cart
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
                    int pid = Convert.ToInt32(e.CommandArgument);
                    string user = Session["user"].ToString();

                    getCon();
                    da = new SqlDataAdapter("select * from tbl_cart where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
                    ds = new DataSet();
                    da.Fill(ds);

                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        cmd = new SqlCommand("update tbl_cart set qunty = qunty + 1 where cart_prod_id='" + pid + "' and cart_user_id='" + user + "'", con);
                        cmd.ExecuteNonQuery();
                    }
                    else
                    {
                        SqlDataAdapter daCake = new SqlDataAdapter("select * from tbl_cakes where Cake_Id='" + pid + "'", con);
                        DataSet dsCake = new DataSet();
                        daCake.Fill(dsCake);
                        string price = dsCake.Tables[0].Rows.Count > 0 ? dsCake.Tables[0].Rows[0]["Cake_Price"].ToString() : "0";
                        string addedDate = DateTime.Now.ToString("dd-MM-yyyy");

                        cmd = new SqlCommand("insert into tbl_cart(cart_prod_id, cart_user_id, qunty, total, addeddate) values('" + pid + "', '" + user + "', 1, '" + price + "', '" + addedDate + "')", con);
                        cmd.ExecuteNonQuery();
                    }
                    con.Close();

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
