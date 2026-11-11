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
    public partial class Order : System.Web.UI.Page
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
            if (Session["user"] == null || Session["user_email"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();

            if (!IsPostBack)
            {
                fillOrderData();
            }
        }

        // Load cart items, user details, and bill summary
        void fillOrderData()
        {
            getcon();
            string cartUser = Session["user"].ToString();
            string userEmail = Session["user_email"].ToString();

            // 1. Cart items
            da = new SqlDataAdapter("select c.cart_id, c.cart_prod_id, c.qunty, c.total, p.Cake_Name, p.Cake_Image from tbl_cart c inner join tbl_cakes p on c.cart_prod_id = p.Cake_Id where c.cart_user_id='" + cartUser + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            int totalProdAmount = 0;

            if (ds.Tables[0].Rows.Count > 0)
            {
                ds.Tables[0].Columns.Add("item_total", typeof(int));

                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    int price = Convert.ToInt32(ds.Tables[0].Rows[i]["total"]);
                    int qty = Convert.ToInt32(ds.Tables[0].Rows[i]["qunty"]);
                    int lineTotal = price * qty;

                    ds.Tables[0].Rows[i]["item_total"] = lineTotal;
                    totalProdAmount += lineTotal;
                }

                GridView1.DataSource = ds;
                GridView1.DataBind();
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }

            // 2. Customer delivery details
            SqlDataAdapter daUser = new SqlDataAdapter("select Name, Email, Mobile, Address, City from tbl_users where Email='" + userEmail + "'", con);
            DataSet dsUser = new DataSet();
            daUser.Fill(dsUser);
            GridView2.DataSource = dsUser;
            GridView2.DataBind();

            // 3. Order bill summary with ₹60 delivery charge
            DataTable dtSummary = new DataTable();
            dtSummary.Columns.Add("ProductTotal", typeof(string));
            dtSummary.Columns.Add("DeliveryCharge", typeof(string));
            dtSummary.Columns.Add("GrandTotal", typeof(string));

            int deliveryCharge = 0;
            if (totalProdAmount > 0)
            {
                deliveryCharge = 60;
            }
            int grandTotal = totalProdAmount + deliveryCharge;

            DataRow dr = dtSummary.NewRow();
            dr["ProductTotal"] = "₹" + totalProdAmount.ToString();
            dr["DeliveryCharge"] = "₹" + deliveryCharge.ToString();
            dr["GrandTotal"] = "₹" + grandTotal.ToString();
            dtSummary.Rows.Add(dr);

            GridView3.DataSource = dtSummary;
            GridView3.DataBind();

            lblGrandTotal.Text = grandTotal.ToString();
            con.Close();
        }

        // Save order and order items into database
        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            if (Session["user"] == null || Session["user_email"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            getcon();
            string cartUser = Session["user"].ToString();
            string userEmail = Session["user_email"].ToString();

            da = new SqlDataAdapter("select c.cart_id, c.cart_prod_id, c.qunty, c.total, p.Cake_Name, p.Cake_Image from tbl_cart c inner join tbl_cakes p on c.cart_prod_id = p.Cake_Id where c.cart_user_id='" + cartUser + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                con.Close();
                lblMsg.Text = "Your cart is empty! Cannot place order.";
                lblMsg.CssClass = "alert-box alert-error";
                lblMsg.Visible = true;
                return;
            }

            int totalProdAmount = 0;
            string cartIdStr = "";

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                if (i > 0)
                {
                    cartIdStr += ",";
                }
                cartIdStr += ds.Tables[0].Rows[i]["cart_id"].ToString();

                int price = Convert.ToInt32(ds.Tables[0].Rows[i]["total"]);
                int qty = Convert.ToInt32(ds.Tables[0].Rows[i]["qunty"]);
                totalProdAmount += (price * qty);
            }

            int deliveryCharge = 60;
            int grandTotal = totalProdAmount + deliveryCharge;
            string orderDate = DateTime.Now.ToString("dd-MM-yyyy hh:mm tt");
            string paymentMethod = rblPayment.SelectedValue;
            string paymentStatus = "Pending";

            // Insert into tbl_orders
            cmd = new SqlCommand("insert into tbl_orders(order_user_id, cart_id, date, total_amount, payment_method, payment_status) values('" + userEmail + "', '" + cartIdStr + "', '" + orderDate + "', '" + grandTotal + "', '" + paymentMethod + "', '" + paymentStatus + "')", con);
            cmd.ExecuteNonQuery();

            // Fetch newly generated order_id
            SqlDataAdapter daOrder = new SqlDataAdapter("select top 1 order_id from tbl_orders where order_user_id='" + userEmail + "' order by order_id desc", con);
            DataSet dsOrder = new DataSet();
            daOrder.Fill(dsOrder);
            int newOrderId = Convert.ToInt32(dsOrder.Tables[0].Rows[0]["order_id"]);

            // Insert each item into tbl_order_items
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                int pid = Convert.ToInt32(ds.Tables[0].Rows[i]["cart_prod_id"]);
                string pName = ds.Tables[0].Rows[i]["Cake_Name"].ToString();
                string pImg = ds.Tables[0].Rows[i]["Cake_Image"].ToString();
                int price = Convert.ToInt32(ds.Tables[0].Rows[i]["total"]);
                int qty = Convert.ToInt32(ds.Tables[0].Rows[i]["qunty"]);
                int lineTotal = price * qty;

                SqlCommand cmdItem = new SqlCommand("insert into tbl_order_items(order_id, prod_id, prod_name, prod_img, price, qunty, item_total) values(" + newOrderId + ", " + pid + ", '" + pName + "', '" + pImg + "', '" + price + "', " + qty + ", '" + lineTotal + "')", con);
                cmdItem.ExecuteNonQuery();
            }

            // Clear user items from tbl_cart
            cmd = new SqlCommand("delete from tbl_cart where cart_user_id='" + cartUser + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();

            Response.Redirect("Billing.aspx?order_id=" + newOrderId);
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}