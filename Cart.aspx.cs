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
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        void getcon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();

            if (!IsPostBack)
            {
                if (Request.QueryString["pid"] != null)
                {
                    int pid = Convert.ToInt32(Request.QueryString["pid"]);
                    addToCart(pid);
                    Response.Redirect("Cart.aspx");
                    return;
                }

                fillCartGrid();
            }
        }

        // Add selected cake to cart
        void addToCart(int pid)
        {
            string user = Session["user"].ToString();

            getcon();
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

                string price = "0";
                if (dsCake.Tables[0].Rows.Count > 0)
                {
                    price = dsCake.Tables[0].Rows[0]["Cake_Price"].ToString();
                }

                string addedDate = DateTime.Now.ToString("dd-MM-yyyy");
                cmd = new SqlCommand("insert into tbl_cart(cart_prod_id, cart_user_id, qunty, total, addeddate) values('" + pid + "', '" + user + "', 1, '" + price + "', '" + addedDate + "')", con);
                cmd.ExecuteNonQuery();
            }
            con.Close();
        }

        // Fetch user cart items from database
        void fillCartGrid()
        {
            getcon();
            string user = "Guest";
            if (Session["user"] != null)
            {
                user = Session["user"].ToString();
            }

            da = new SqlDataAdapter("select c.cart_id, c.cart_prod_id, c.qunty, c.total, c.addeddate, p.Cake_Name, p.Cake_Image from tbl_cart c inner join tbl_cakes p on c.cart_prod_id = p.Cake_Id where c.cart_user_id='" + user + "'", con);
            ds = new DataSet();
            da.Fill(ds);
            GridView1.DataSource = ds;
            GridView1.DataBind();
            con.Close();

            // Calculate total cart value
            int grandTotal = 0;
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                int q = Convert.ToInt32(ds.Tables[0].Rows[i]["qunty"]);
                int price = Convert.ToInt32(ds.Tables[0].Rows[i]["total"]);
                grandTotal += (q * price);
            }
            lblTotal.Text = grandTotal.ToString();
        }

        // Set row in edit mode
        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            fillCartGrid();
        }

        // Cancel row edit
        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            fillCartGrid();
        }

        // Update item quantity in cart
        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int cartId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            DropDownList ddl = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlQunty");
            if (ddl != null)
            {
                int newQty = Convert.ToInt32(ddl.SelectedValue);
                getcon();
                cmd = new SqlCommand("update tbl_cart set qunty=" + newQty + " where cart_id=" + cartId, con);
                cmd.ExecuteNonQuery();
                con.Close();
            }

            GridView1.EditIndex = -1;
            fillCartGrid();
        }

        // Remove item from cart
        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            getcon();
            cmd = new SqlCommand("delete from tbl_cart where cart_id=" + cartId, con);
            cmd.ExecuteNonQuery();
            con.Close();

            GridView1.EditIndex = -1;
            fillCartGrid();
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (GridView1.Rows.Count == 0)
            {
                lblMsg.Text = "Your cart is currently empty!";
                lblMsg.CssClass = "alert-box alert-error";
                lblMsg.Visible = true;
                return;
            }

            Response.Redirect("Order.aspx");
        }
    }
}