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
    public partial class Default : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter da;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Check user login session
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
                fillFeaturedCakes();
                fillReviews();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Fetch featured cakes from database
        void fillFeaturedCakes()
        {
            getCon();
            da = new SqlDataAdapter("select top 6 * from tbl_cakes", con);
            ds = new DataSet();
            da.Fill(ds);
            DataListFeaturedCakes.DataSource = ds;
            DataListFeaturedCakes.DataBind();
            con.Close();
        }

        // Load customer reviews from database
        void fillReviews()
        {
            getCon();
            da = new SqlDataAdapter("select r.*, c.Cake_Name from tbl_reviews r left join tbl_cakes c on r.Cake_Id = c.Cake_Id order by r.Review_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataListReviews.DataSource = ds;
                DataListReviews.DataBind();
                lblNoReviews.Visible = false;
            }
            else
            {
                lblNoReviews.Visible = true;
            }
            con.Close();
        }

        // Display star rating
        public string GetStars(object rating)
        {
            int r = 5;
            if (rating != null && int.TryParse(rating.ToString(), out r))
            {
                string stars = "";
                for (int i = 0; i < r; i++) stars += "&#9733;";
                for (int i = r; i < 5; i++) stars += "&#9734;";
                return stars;
            }
            return "&#9733;&#9733;&#9733;&#9733;&#9733;";
        }

        // Handles Logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
