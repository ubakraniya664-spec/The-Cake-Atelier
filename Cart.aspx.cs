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
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["user"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            // Shows user's name in greeting
            lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();

            if (!IsPostBack)
            {
                if (Session["cart_cake_id"] != null)
                {
                    fillCartDataList(Session["cart_cake_id"].ToString());
                    pnlActiveCart.Visible = true;
                    pnlEmptyCart.Visible = false;
                }
                else
                {
                    pnlActiveCart.Visible = false;
                    pnlEmptyCart.Visible = true;
                }
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        void fillCartDataList(string cakeId)
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_cakes where Cake_Id='" + cakeId + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListCart.DataSource = ds;
                DataListCart.DataBind();

                ViewState["Cake_Id"] = ds.Tables[0].Rows[0]["Cake_Id"].ToString();
                ViewState["Cake_Name"] = ds.Tables[0].Rows[0]["Cake_Name"].ToString();
                ViewState["Cake_Price"] = Convert.ToInt32(ds.Tables[0].Rows[0]["Cake_Price"]);

                updateTotal();
            }
            con.Close();
        }

        void updateTotal()
        {
            int price = Convert.ToInt32(ViewState["Cake_Price"]);
            int qty = Convert.ToInt32(ddlQuantity.SelectedValue);
            int total = price * qty;
            ViewState["Total_Price"] = total;
            lblTotalPrice.Text = total.ToString();
        }

        protected void ddlQuantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            updateTotal();
        }

        protected void btnConfirmOrder_Click(object sender, EventArgs e)
        {
            if (txtRecipient.Text == "" || txtPhone.Text == "" || txtAddress.Text == "")
            {
                lblCartError.Text = "Please fill in recipient name, contact phone, and delivery address.";
                lblCartError.Visible = true;
                return;
            }

            getCon();

            // Uses user's email for database record
            string userEmail = Session["user_email"] != null ? Session["user_email"].ToString() : Session["user"].ToString();
            int cakeId = Convert.ToInt32(ViewState["Cake_Id"]);
            string cakeName = ViewState["Cake_Name"].ToString();
            int cakePrice = Convert.ToInt32(ViewState["Cake_Price"]);
            int quantity = Convert.ToInt32(ddlQuantity.SelectedValue);
            int totalPrice = Convert.ToInt32(ViewState["Total_Price"]);
            string recipient = txtRecipient.Text;
            string phone = txtPhone.Text;
            string address = txtAddress.Text;
            string message = txtMessage.Text;

            string query = "INSERT INTO tbl_orders (User_Email, Cake_Id, Cake_Name, Cake_Price, Quantity, Total_Price, Recipient_Name, Phone, Address, Message_On_Cake) " +
                           "VALUES ('" + userEmail + "', " + cakeId + ", '" + cakeName + "', " + cakePrice + ", " + quantity + ", " + totalPrice + ", '" + recipient + "', '" + phone + "', '" + address + "', '" + message + "'); " +
                           "SELECT SCOPE_IDENTITY();";

            cmd = new SqlCommand(query, con);
            object identityVal = cmd.ExecuteScalar();
            con.Close();

            string realOrderId = identityVal.ToString();

            Session["cart_cake_id"] = null;

            pnlActiveCart.Visible = false;
            pnlOrderSuccess.Visible = true;
            lblConfirmedOrderId.Text = "Database Order ID: #" + realOrderId;
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
