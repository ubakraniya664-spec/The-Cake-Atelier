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
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check admin session
            if (Session["admin"] == null)
            {
                Response.Redirect("Admin_Login.aspx");
                return;
            }

            lblAdminName.Text = Session["admin"].ToString();

            if (!IsPostBack)
            {
                loadDashboardStats();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Load dashboard statistics
        void loadDashboardStats()
        {
            getCon();

            // 1. Total Cakes in Menu
            cmd = new SqlCommand("select count(*) from tbl_cakes", con);
            lblTotalCakes.Text = cmd.ExecuteScalar().ToString();

            // 2. Total Customer Orders
            cmd = new SqlCommand("select count(*) from tbl_orders", con);
            lblTotalOrders.Text = cmd.ExecuteScalar().ToString();

            // 3. Total Registered Customers
            cmd = new SqlCommand("select count(*) from tbl_users", con);
            lblTotalUsers.Text = cmd.ExecuteScalar().ToString();

            // 4. Total Revenue from Orders
            SqlDataAdapter daRev = new SqlDataAdapter("select total_amount from tbl_orders where payment_status != 'Cancelled'", con);
            DataSet dsRev = new DataSet();
            daRev.Fill(dsRev);
            int revenue = 0;
            for (int i = 0; i < dsRev.Tables[0].Rows.Count; i++)
            {
                revenue += Convert.ToInt32(dsRev.Tables[0].Rows[i]["total_amount"]);
            }
            lblTotalRevenue.Text = revenue.ToString();

            con.Close();
        }

        // Admin Logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Admin_Login.aspx");
        }
    }
}
