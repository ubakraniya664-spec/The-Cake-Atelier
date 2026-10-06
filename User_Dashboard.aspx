<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="User_Dashboard.aspx.cs" Inherits="The_Cake_Atelier.User_Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Account Dashboard - The Cake Atelier</title>
    <link href="Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Sticky Navigation Header -->
        <div class="header-bar">
            <table class="nav-table">
                <tr>
                    <td style="width: 32%;">
                        <asp:HyperLink ID="lnkBrand" runat="server" NavigateUrl="Default.aspx" CssClass="brand-title">The Cake Atelier</asp:HyperLink>
                        <span class="brand-subtitle">Artisanal Bakery &amp; Pâtisserie</span>
                    </td>
                    <td class="nav-links">
                        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="Default.aspx">Home</asp:HyperLink>
                        <asp:HyperLink ID="lnkCakes" runat="server" NavigateUrl="Cakes.aspx">Cakes &amp; Menu</asp:HyperLink>
                        <asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="About.aspx">About Us</asp:HyperLink>
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx" CssClass="active">My Account</asp:HyperLink>

                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Dashboard Main Container -->
        <div class="main-container">

            <!-- Profile Overview Header Card -->
            <div style="background-color: #ffffff; border: 1px solid #ebdcd3; border-radius: 12px; padding: 25px 30px; margin-bottom: 30px; box-shadow: 0 4px 16px rgba(74, 44, 27, 0.06);">
                <table style="width: 100%; border-collapse: collapse;">
                    <tr>
                        <td style="width: 90px; vertical-align: middle;">
                            <asp:Image ID="imgAvatar" runat="server" CssClass="user-avatar" Style="width: 80px; height: 80px;" />
                        </td>
                        <td style="vertical-align: middle; padding-left: 20px;">
                            <h1 style="margin: 0 0 5px 0; color: #4a2c1b; font-size: 26px;">Hello,
                                <asp:Label ID="lblGreetingName" runat="server" ForeColor="#c45b4c"></asp:Label>!
                            </h1>
                            <p style="margin: 0; color: #7d5e4b; font-size: 14px;">
                                Welcome to your personal sweet portal. Manage your profile, security, and leave reviews for your favorite cakes.
                            </p>
                        </td>
                        <td style="text-align: right; vertical-align: middle;">
                            <span style="background-color: #fcedea; color: #c45b4c; padding: 6px 14px; border-radius: 20px; font-weight: bold; font-size: 13px;">&#11088; Valued Member
                            </span>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Two Column Layout: Left Column (Profile & Password) / Right Column (Cake Review & Orders) -->
            <table style="width: 100%; border-collapse: collapse;">
                <tr>
                    <!-- LEFT COLUMN: Profile Details & Password -->
                    <td style="width: 50%; vertical-align: top; padding-right: 18px;">

                        <!-- 1. Edit Profile Information Card -->
                        <div class="edit-box" style="margin-bottom: 25px;">
                            <div class="edit-title">&#128100; My Profile Information</div>

                            <asp:Label ID="lblProfileMsg" runat="server" Visible="false"></asp:Label>

                            <table class="form-table">
                                <tr>
                                    <td class="form-label" style="width: 32%;">Full Name:</td>
                                    <td>
                                        <asp:TextBox ID="txtname" runat="server" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form-label">Email Address:</td>
                                    <td>
                                        <asp:TextBox ID="txtemail" runat="server" ReadOnly="true" CssClass="form-input" Style="background-color: #f7f3ee; color: #7d5e4b;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-label">Gender:</td>
                                    <td>
                                        <asp:RadioButtonList ID="rblGender" runat="server" RepeatDirection="Horizontal" Style="font-size: 14px; color: #4a2c1b;">
                                            <asp:ListItem Value="Male">Male</asp:ListItem>
                                            <asp:ListItem Value="Female">Female</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-label">City:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlCity" runat="server" CssClass="form-dropdown">
                                            <asp:ListItem>-- Select City --</asp:ListItem>
                                            <asp:ListItem>Rajkot</asp:ListItem>
                                            <asp:ListItem>Ahmedabad</asp:ListItem>
                                            <asp:ListItem>Surat</asp:ListItem>
                                            <asp:ListItem>Vadodara</asp:ListItem>
                                            <asp:ListItem>Mumbai</asp:ListItem>
                                            <asp:ListItem>Pune</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-label">Mobile:</td>
                                    <td>
                                        <asp:TextBox ID="txtmobile" runat="server" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form-label">Delivery Address:</td>
                                    <td>
                                        <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-input" Style="font-family: inherit;"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="padding-top: 10px;">
                                        <asp:Button ID="btnUpdateProfile" runat="server" Text="Save Profile Changes" CssClass="btn-update" OnClick="btnUpdateProfile_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- 2. Change Password Card -->
                        <div class="edit-box">
                            <div class="edit-title">&#128272; Change Password</div>

                            <asp:Label ID="lblPasswordMsg" runat="server" Visible="false"></asp:Label>

                            <table class="form-table">
                                <tr>
                                    <td class="form-label" style="width: 38%;">Current Password:</td>
                                    <td>
                                        <asp:TextBox ID="txtOldPwd" runat="server" TextMode="Password" placeholder="Enter current password" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form-label">New Password:</td>
                                    <td>
                                        <asp:TextBox ID="txtNewPwd" runat="server" TextMode="Password" placeholder="Enter new password" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td class="form-label">Confirm Password:</td>
                                    <td>
                                        <asp:TextBox ID="txtConfirmPwd" runat="server" TextMode="Password" placeholder="Re-enter new password" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="padding-top: 10px;">
                                        <asp:Button ID="btnChangePassword" runat="server" Text="Update Password" CssClass="btn-update" OnClick="btnChangePassword_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </td>

                    <!-- RIGHT COLUMN: Cake Review & Recent Orders -->
                    <td style="width: 50%; vertical-align: top; padding-left: 18px;">

                        <!-- 3. Write a Cake Review Card -->
                        <div class="edit-box" style="margin-bottom: 25px;">
                            <div class="edit-title">&#9733; Share Your Cake Experience</div>
                            <p style="font-size: 13px; color: #6d5444; margin-top: 0; margin-bottom: 15px;">
                                Tasted one of our signature cakes? Let us and fellow dessert lovers know what you think!
                            </p>

                            <asp:Label ID="lblReviewMsg" runat="server" Visible="false"></asp:Label>

                            <table class="form-table">
                                <tr>
                                    <td class="form-label" style="width: 30%;">Select Cake:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlReviewCake" runat="server" CssClass="form-dropdown"></asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-label">Rating:</td>
                                    <td>
                                        <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-dropdown">
                                            <asp:ListItem Value="5">&#9733;&#9733;&#9733;&#9733;&#9733; (5/5 Exceptional)</asp:ListItem>
                                            <asp:ListItem Value="4">&#9733;&#9733;&#9733;&#9733;&#9734; (4/5 Very Good)</asp:ListItem>
                                            <asp:ListItem Value="3">&#9733;&#9733;&#9733;&#9734;&#9734; (3/5 Average)</asp:ListItem>
                                            <asp:ListItem Value="2">&#9733;&#9733;&#9734;&#9734;&#9734; (2/5 Below Average)</asp:ListItem>
                                            <asp:ListItem Value="1">&#9733;&#9734;&#9734;&#9734;&#9734; (1/5 Poor)</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="form-label">Your Review:</td>
                                    <td>
                                        <asp:TextBox ID="txtReviewComment" runat="server" TextMode="MultiLine" Rows="3" placeholder="Tell us about the flavor, texture, and presentation..." CssClass="form-input" Style="font-family: inherit;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td style="padding-top: 10px;">
                                        <asp:Button ID="btnSubmitReview" runat="server" Text="Post Review" CssClass="btn-update" OnClick="btnSubmitReview_Click" />
                                    </td>
                                </tr>
                            </table>
                        </div>

                        <!-- 4. My Past Orders Summary Card -->
                        <div class="edit-box">
                            <div class="edit-title">&#128230; My Past Orders</div>

                            <asp:Panel ID="pnlNoOrders" runat="server" Visible="false" Style="text-align: center; padding: 25px 10px;">
                                <div style="font-size: 32px; margin-bottom: 8px;">&#129382;</div>
                                <div style="color: #4a2c1b; font-weight: bold; font-size: 15px;">No orders placed yet!</div>
                                <p style="font-size: 13px; color: #7d5e4b; margin: 6px 0 15px 0;">Satisfy your sweet tooth with our freshly baked catalog.</p>
                                <a href="Cakes.aspx" class="action-btn" style="padding: 7px 18px; font-size: 13px;">Browse Cakes Menu &rarr;</a>
                            </asp:Panel>

                            <asp:GridView ID="GridViewOrders" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" Width="100%">
                                <Columns>
                                    <asp:BoundField DataField="Order_Id" HeaderText="Order #" ItemStyle-Width="65px" />
                                    <asp:BoundField DataField="Cake_Name" HeaderText="Cake Ordered" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Qty" ItemStyle-Width="45px" ItemStyle-HorizontalAlign="Center" />
                                    <asp:BoundField DataField="Total_Price" HeaderText="Total (₹)" ItemStyle-Width="75px" ItemStyle-Font-Bold="true" />
                                    <asp:BoundField DataField="Order_Date" HeaderText="Date" DataFormatString="{0:dd-MMM-yyyy}" ItemStyle-Width="95px" />
                                </Columns>
                            </asp:GridView>
                        </div>

                    </td>
                </tr>
            </table>

        </div>

        <!-- Storefront Footer -->
        <div class="footer-container">
            <table class="footer-table">
                <tr>
                    <td class="footer-col">
                        <h3>The Cake Atelier</h3>
                        <p>Artisanal bakery and pâtisserie dedicated to making every celebration extraordinary with freshly baked, premium cakes.</p>
                        <p style="color: #d4a373;">&#9742; Phone: +91 98765 43210</p>
                        <p style="color: #d4a373;">&#9993; Email: orders@thecakeatelier.com</p>
                    </td>
                    <td class="footer-col">
                        <h3>Quick Links</h3>
                        <a href="Default.aspx">Home</a>
                        <a href="Cakes.aspx">All Cakes &amp; Pastries</a>
                        <a href="About.aspx">About Our Bakery</a>
                        <a href="Cart.aspx">My Shopping Cart</a>
                        <a href="Contact.aspx">Contact &amp; Custom Orders</a>
                    </td>
                    <td class="footer-col">
                        <h3>Member Portal</h3>
                        <a href="User_Dashboard.aspx">My Account Dashboard</a>
                        <a href="Cart.aspx">Checkout &amp; Cart</a>
                        <a href="Contact.aspx">Custom Party Orders</a>
                    </td>
                    <td class="footer-col">
                        <h3>Bakery Hours</h3>
                        <p>
                            <strong>Monday - Saturday:</strong><br />
                            8:30 AM &ndash; 10:30 PM
                        </p>
                        <p>
                            <strong>Sunday:</strong><br />
                            9:00 AM &ndash; 11:00 PM
                        </p>
                        <p>
                            <strong>Store Address:</strong><br />
                            124 Confectionery Lane, Sweetville
                        </p>
                    </td>
                </tr>
            </table>

            <div class="footer-bottom">
                &copy; 2026 The Cake Atelier. All Rights Reserved. | College ASP.NET Web Forms Project.
            </div>
        </div>

    </form>
</body>
</html>
