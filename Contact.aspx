<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="The_Cake_Atelier.Contact" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Contact &amp; Custom Orders - The Cake Atelier</title>
    <link href="Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Sticky Navigation Bar -->
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
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx" CssClass="active">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>

                        <!-- Dynamic Authentication Links -->
                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx">Register</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx" Visible="false">Dashboard</asp:HyperLink>
                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting" Visible="false"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn" Visible="false">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Content Area -->
        <div class="main-container">

            <h1 class="section-heading">Contact &amp; Custom Cake Consultation</h1>
            <div class="section-subheading">Inquire about customized wedding centerpieces, corporate events, or bakery showroom visits</div>

            <!-- Confirmation Message Alert -->
            <asp:Label ID="lblContactMessage" runat="server" Visible="false" CssClass="alert-box"></asp:Label>

            <table class="contact-layout">
                <tr>
                    <!-- Left: Custom Cake Consultation Form -->
                    <td class="contact-form-cell">
                        <div class="contact-card">
                            <h2>Send Us a Message / Custom Order Request</h2>
                            <p style="color:#7d5e4b; font-size:14px; margin-bottom:15px;">
                                Tell us about your upcoming event, theme colors, and guest count. Our head pastry chef will get in touch with you.
                            </p>

                            <table class="form-table">
                                <tr>
                                    <th>Your Name :</th>
                                    <td><asp:TextBox ID="txtName" runat="server" placeholder="Enter your full name" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <th>Email Address :</th>
                                    <td><asp:TextBox ID="txtEmail" runat="server" placeholder="name@example.com" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <th>Mobile Number :</th>
                                    <td><asp:TextBox ID="txtPhone" runat="server" placeholder="10-digit mobile number" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <th>Occasion / Type :</th>
                                    <td>
                                        <asp:DropDownList ID="ddlInquiryType" runat="server" Width="95%" style="padding:8px 10px; border:1px solid #d4c3b7; border-radius:4px;">
                                            <asp:ListItem>Custom Designer Birthday Cake</asp:ListItem>
                                            <asp:ListItem>Multi-Tier Wedding Cake Consultation</asp:ListItem>
                                            <asp:ListItem>Anniversary / Engagement Celebration</asp:ListItem>
                                            <asp:ListItem>Corporate Event / Bulk Cupcake Pack</asp:ListItem>
                                            <asp:ListItem>General Customer Feedback</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Event Date :</th>
                                    <td><asp:TextBox ID="txtEventDate" runat="server" TextMode="Date" CssClass="form-input"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <th>Estimated Weight :</th>
                                    <td>
                                        <asp:DropDownList ID="ddlWeight" runat="server" Width="95%" style="padding:8px 10px; border:1px solid #d4c3b7; border-radius:4px;">
                                            <asp:ListItem>1.0 Kg (Serves 8-10 Guests)</asp:ListItem>
                                            <asp:ListItem>1.5 Kg (Serves 12-15 Guests)</asp:ListItem>
                                            <asp:ListItem>2.0 Kg - 2 Tier (Serves 18-20 Guests)</asp:ListItem>
                                            <asp:ListItem>3.0+ Kg Grand Multi-Tier Masterpiece</asp:ListItem>
                                            <asp:ListItem>Cupcakes &amp; Pastry Box (12+ Pieces)</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Reference Image :</th>
                                    <td>
                                        <asp:FileUpload ID="FileUploadDesign" runat="server" style="font-size:13px;" />
                                        <div style="font-size:11px; color:#8c6d58; margin-top:3px;">Upload sketch, color palette, or sample photo</div>
                                    </td>
                                </tr>
                                <tr>
                                    <th>Design Details :</th>
                                    <td>
                                        <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="3" placeholder="Describe your dream cake flavors, message on cake, or dietary requirements..." CssClass="form-input" style="font-family:inherit;"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td>
                                        <asp:Button ID="btnSendMessage" runat="server" Text="Submit Consultation Request &rarr;" OnClick="btnSendMessage_Click" CssClass="btn-submit" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>

                    <!-- Right: Atelier Details & Hours -->
                    <td class="contact-info-cell">
                        <div class="info-card">
                            <h3>Bakery Atelier Location</h3>
                            <div class="info-item">
                                <span class="info-label">&#128205; Workshop &amp; Boutique:</span>
                                The Cake Atelier, 124 Confectionery Lane, Sweetville<br />
                                Landmark: Near Floral Fountain Plaza
                            </div>
                            <div class="info-item">
                                <span class="info-label">&#9742; Order &amp; Custom Hotline:</span>
                                Primary: +91 98765 43210<br />
                                WhatsApp: +91 98765 43211
                            </div>
                            <div class="info-item">
                                <span class="info-label">&#9993; Official Emails:</span>
                                General: hello@thecakeatelier.com<br />
                                Custom Orders: customcakes@thecakeatelier.com
                            </div>
                        </div>

                        <div class="info-card">
                            <h3>Baking &amp; Visiting Hours</h3>
                            <table style="width:100%; font-size:13px; color:#5c3d2e;">
                                <tr>
                                    <td style="padding:6px 0;"><strong>Monday &ndash; Friday:</strong></td>
                                    <td style="text-align:right;">8:30 AM &ndash; 10:30 PM</td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0;"><strong>Saturday:</strong></td>
                                    <td style="text-align:right;">8:30 AM &ndash; 11:00 PM</td>
                                </tr>
                                <tr>
                                    <td style="padding:6px 0;"><strong>Sunday:</strong></td>
                                    <td style="text-align:right;">9:00 AM &ndash; 11:00 PM</td>
                                </tr>
                            </table>
                            <div style="margin-top:12px; font-size:12px; color:#8c6d58; border-top:1px dashed #ebdcd3; padding-top:8px;">
                                &#10004; In-person cake tasting consultations available by prior booking.
                            </div>
                        </div>
                    </td>
                </tr>
            </table>

        </div>

        <!-- Footer Section -->
        <div class="footer-container">
            <table class="footer-table">
                <tr>
                    <td class="footer-col">
                        <h3>The Cake Atelier</h3>
                        <p>Artisanal bakery and pâtisserie dedicated to making every celebration extraordinary with freshly baked, premium cakes.</p>
                        <p style="color:#d4a373;">&#9742; Phone: +91 98765 43210</p>
                        <p style="color:#d4a373;">&#9993; Email: orders@thecakeatelier.com</p>
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
                        <a href="login.aspx">Customer Login</a>
                        <a href="register.aspx">Register New Account</a>
                        <a href="Cart.aspx">Checkout &amp; Track Order</a>
                        <a href="Contact.aspx">Franchise Inquiries</a>
                    </td>
                    <td class="footer-col">
                        <h3>Bakery Hours</h3>
                        <p><strong>Monday - Saturday:</strong><br />8:30 AM &ndash; 10:30 PM</p>
                        <p><strong>Sunday:</strong><br />9:00 AM &ndash; 11:00 PM</p>
                        <p><strong>Store Address:</strong><br />124 Confectionery Lane, Sweetville</p>
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
