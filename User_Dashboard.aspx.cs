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
    public partial class User_Dashboard : System.Web.UI.Page
    {
        SqlConnection con;
        SqlDataAdapter da;
        SqlCommand cmd;
        DataSet ds;

        string s = ConfigurationManager.ConnectionStrings["dbcon"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Session Protection: Must be a logged-in customer
            if (Session["user"] == null || Session["user_email"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            lblUserGreeting.Text = "Welcome, " + Session["user"].ToString();

            if (!IsPostBack)
            {
                loadUserProfile();
                loadCakesDropdown();
                loadUserOrders();
            }
        }

        void getCon()
        {
            con = new SqlConnection(s);
            con.Open();
        }

        // Fetches customer record from tbl_users using their logged-in email
        void loadUserProfile()
        {
            getCon();
            da = new SqlDataAdapter("select * from tbl_users where Email='" + Session["user_email"] + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                string name = ds.Tables[0].Rows[0]["Name"].ToString();
                string email = ds.Tables[0].Rows[0]["Email"].ToString();
                string gender = ds.Tables[0].Rows[0]["Gender"].ToString();
                string city = ds.Tables[0].Rows[0]["City"].ToString();
                string address = ds.Tables[0].Rows[0]["Address"].ToString();
                string mobile = ds.Tables[0].Rows[0]["Mobile"].ToString();
                string img = ds.Tables[0].Rows[0]["Image"].ToString();

                lblGreetingName.Text = name;
                txtname.Text = name;
                txtemail.Text = email;
                txtmobile.Text = mobile;
                txtaddress.Text = address;

                // Load User Avatar
                if (img != "")
                {
                    imgAvatar.ImageUrl = "~/" + img;
                }
                else
                {
                    imgAvatar.ImageUrl = "~/images/chef.jpg";
                }

                // Gender radio button
                rblGender.ClearSelection();
                if (rblGender.Items.FindByValue(gender) != null)
                {
                    rblGender.Items.FindByValue(gender).Selected = true;
                }

                // City dropdown
                ddlCity.ClearSelection();
                if (ddlCity.Items.FindByText(city) != null)
                {
                    ddlCity.Items.FindByText(city).Selected = true;
                }
            }
            con.Close();
        }

        // Populates the review dropdown with all available cakes
        void loadCakesDropdown()
        {
            getCon();
            da = new SqlDataAdapter("select Cake_Id, Cake_Name from tbl_cakes order by Cake_Name asc", con);
            ds = new DataSet();
            da.Fill(ds);

            ddlReviewCake.DataSource = ds;
            ddlReviewCake.DataTextField = "Cake_Name";
            ddlReviewCake.DataValueField = "Cake_Id";
            ddlReviewCake.DataBind();

            con.Close();
        }

        // Loads orders placed by this customer from tbl_orders
        void loadUserOrders()
        {
            getCon();
            da = new SqlDataAdapter("select Order_Id, Cake_Name, Quantity, Total_Price, Order_Date from tbl_orders where User_Email='" + Session["user_email"] + "' order by Order_Id desc", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                GridViewOrders.DataSource = ds;
                GridViewOrders.DataBind();
                pnlNoOrders.Visible = false;
                GridViewOrders.Visible = true;
            }
            else
            {
                pnlNoOrders.Visible = true;
                GridViewOrders.Visible = false;
            }
            con.Close();
        }

        // Saves updated user profile details
        protected void btnUpdateProfile_Click(object sender, EventArgs e)
        {
            if (txtname.Text == "")
            {
                lblProfileMsg.Text = "Please enter your name.";
                lblProfileMsg.CssClass = "alert-box alert-error";
                lblProfileMsg.Visible = true;
                return;
            }

            getCon();
            string selectedGender = rblGender.SelectedItem != null ? rblGender.SelectedItem.Text : "Male";
            string selectedCity = ddlCity.SelectedItem != null ? ddlCity.SelectedItem.Text : "Mumbai";

            cmd = new SqlCommand("update tbl_users set Name='" + txtname.Text + "', Gender='" + selectedGender + "', City='" + selectedCity + "', Mobile='" + txtmobile.Text + "', Address='" + txtaddress.Text + "' where Email='" + Session["user_email"] + "'", con);
            cmd.ExecuteNonQuery();
            con.Close();

            // Update session greeting name
            Session["user"] = txtname.Text;
            lblUserGreeting.Text = "Welcome, " + txtname.Text;
            lblGreetingName.Text = txtname.Text;

            lblProfileMsg.Text = "&#10004; Profile updated successfully!";
            lblProfileMsg.CssClass = "alert-box alert-success";
            lblProfileMsg.Visible = true;
        }

        // Changes user password after verifying the old password
        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if (txtOldPwd.Text == "" || txtNewPwd.Text == "" || txtConfirmPwd.Text == "")
            {
                lblPasswordMsg.Text = "All password fields are required.";
                lblPasswordMsg.CssClass = "alert-box alert-error";
                lblPasswordMsg.Visible = true;
                return;
            }

            if (txtNewPwd.Text != txtConfirmPwd.Text)
            {
                lblPasswordMsg.Text = "New Password and Confirm Password do not match.";
                lblPasswordMsg.CssClass = "alert-box alert-error";
                lblPasswordMsg.Visible = true;
                return;
            }

            getCon();
            // Verify current password
            da = new SqlDataAdapter("select * from tbl_users where Email='" + Session["user_email"] + "' and Password='" + txtOldPwd.Text + "'", con);
            ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables[0].Rows.Count > 0)
            {
                // Update to new password
                cmd = new SqlCommand("update tbl_users set Password='" + txtNewPwd.Text + "' where Email='" + Session["user_email"] + "'", con);
                cmd.ExecuteNonQuery();
                con.Close();

                txtOldPwd.Text = "";
                txtNewPwd.Text = "";
                txtConfirmPwd.Text = "";

                lblPasswordMsg.Text = "&#10004; Password changed successfully!";
                lblPasswordMsg.CssClass = "alert-box alert-success";
                lblPasswordMsg.Visible = true;
            }
            else
            {
                con.Close();
                lblPasswordMsg.Text = "Current password is incorrect.";
                lblPasswordMsg.CssClass = "alert-box alert-error";
                lblPasswordMsg.Visible = true;
            }
        }

        // Inserts a customer review into tbl_reviews
        protected void btnSubmitReview_Click(object sender, EventArgs e)
        {
            if (txtReviewComment.Text == "")
            {
                lblReviewMsg.Text = "Please write a few words about your experience.";
                lblReviewMsg.CssClass = "alert-box alert-error";
                lblReviewMsg.Visible = true;
                return;
            }

            getCon();
            int cakeId = Convert.ToInt32(ddlReviewCake.SelectedValue);
            int rating = Convert.ToInt32(ddlRating.SelectedValue);
            string customerName = Session["user"].ToString();

            cmd = new SqlCommand("insert into tbl_reviews(Cake_Id, CustomerName, Rating, Comment, ReviewDate) values(" + cakeId + ", '" + customerName + "', " + rating + ", '" + txtReviewComment.Text + "', GETDATE())", con);
            cmd.ExecuteNonQuery();
            con.Close();

            txtReviewComment.Text = "";
            lblReviewMsg.Text = "&#10004; Thank you! Your review has been submitted.";
            lblReviewMsg.CssClass = "alert-box alert-success";
            lblReviewMsg.Visible = true;
        }

        // Customer Logout
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Default.aspx");
        }
    }
}
