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
    public partial class Billing : System.Web.UI.Page
    {
        SqlConnection con;
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
            if (Session["user"] == null && Session["admin"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            if (Session["user"] != null)
            {
                lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();
            }
            else
            {
                lblUserGreeting.Text = "Welcome, Admin";
                lnkDashboard.Visible = false;
                lnkLogout.Visible = false;
            }

            if (!IsPostBack)
            {
                fetchBillDetails();
            }
        }

        // Load order invoice, customer details, and ordered cakes
        void fetchBillDetails()
        {
            getcon();
            int orderId = 0;

            if (Request.QueryString["order_id"] != null)
            {
                orderId = Convert.ToInt32(Request.QueryString["order_id"]);
            }
            else if (Session["user_email"] != null)
            {
                string userEmail = Session["user_email"].ToString();
                da = new SqlDataAdapter("select top 1 order_id from tbl_orders where order_user_id='" + userEmail + "' order by order_id desc", con);
                ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables[0].Rows.Count > 0)
                {
                    orderId = Convert.ToInt32(ds.Tables[0].Rows[0]["order_id"]);
                }
            }

            if (orderId == 0)
            {
                con.Close();
                Response.Redirect("Cakes.aspx");
                return;
            }

            // 1. Fetch order record
            da = new SqlDataAdapter("select * from tbl_orders where order_id=" + orderId, con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count == 0)
            {
                con.Close();
                Response.Redirect("Cakes.aspx");
                return;
            }

            DataRow orderRow = ds.Tables[0].Rows[0];
            lblOrderId.Text = "#" + orderRow["order_id"].ToString();
            lblOrderNo.Text = "#" + orderRow["order_id"].ToString();
            lblOrderDate.Text = orderRow["date"].ToString();
            lblDate.Text = orderRow["date"].ToString();
            lblPaymentMethod.Text = orderRow["payment_method"].ToString();
            lblPaymentStatus.Text = orderRow["payment_status"].ToString();
            lblUserId.Text = orderRow["order_user_id"].ToString();
            lblGrandTotal.Text = orderRow["total_amount"].ToString();

            string email = orderRow["order_user_id"].ToString();

            // 2. Fetch customer details from tbl_users
            SqlDataAdapter daUser = new SqlDataAdapter("select * from tbl_users where Email='" + email + "'", con);
            DataSet dsUser = new DataSet();
            daUser.Fill(dsUser);

            if (dsUser.Tables[0].Rows.Count > 0)
            {
                lblCustName.Text = dsUser.Tables[0].Rows[0]["Name"].ToString();
                lblCustEmail.Text = dsUser.Tables[0].Rows[0]["Email"].ToString();
                lblCustMobile.Text = dsUser.Tables[0].Rows[0]["Mobile"].ToString();
                lblCustAddress.Text = dsUser.Tables[0].Rows[0]["Address"].ToString();
                lblCustCity.Text = dsUser.Tables[0].Rows[0]["City"].ToString();
            }

            // 3. Fetch ordered cake items
            SqlDataAdapter daItems = new SqlDataAdapter("select * from tbl_order_items where order_id=" + orderId, con);
            DataSet dsItems = new DataSet();
            daItems.Fill(dsItems);

            int subtotal = 0;
            for (int i = 0; i < dsItems.Tables[0].Rows.Count; i++)
            {
                subtotal += Convert.ToInt32(dsItems.Tables[0].Rows[i]["item_total"]);
            }

            GridView1.DataSource = dsItems;
            GridView1.DataBind();

            lblSubtotal.Text = subtotal.ToString();
            lblDeliveryCharge.Text = "60";
            con.Close();
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}