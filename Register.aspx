<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="The_Cake_Atelier.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Registration - The Cake Atelier</title>
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
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>
                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx" CssClass="active">Register</asp:HyperLink>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Registration Form (Strictly Mimicking Reference_Code register.aspx) -->
        <div class="reg-card">
            <div style="text-align:center;">
                <div style="font-size:42px;">&#127856;</div>
                <h1 style="color:#4a2c1b; margin:0 0 6px 0; font-size:26px;">Customer Registration</h1>
                <p style="color:#7d5e4b; font-size:14px; margin-bottom:15px;">Create your member account to order fresh cakes</p>
                
                <!-- Status message label (mimicking Label8 in reference code) -->
                <asp:Label ID="Label8" runat="server" Visible="false" CssClass="alert-box"></asp:Label>
            </div>

            <table class="reg-table">
                <tr>
                    <th>Name :</th>
                    <td>
                        <asp:TextBox ID="txtname" runat="server" placeholder="Enter your full name" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>Gender :</th>
                    <td>
                        <asp:RadioButtonList ID="rblg" runat="server" RepeatDirection="Horizontal">
                            <asp:ListItem Selected="True">Male&nbsp;&nbsp;</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <th>Email :</th>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" placeholder="name@example.com" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>Password :</th>
                    <td>
                        <asp:TextBox ID="txtpwd" runat="server" TextMode="Password" placeholder="Create password" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>City :</th>
                    <td>
                        <asp:DropDownList ID="DropDownList1" runat="server" Width="92%" style="padding:8px 10px; border:1px solid #d4c3b7; border-radius:4px;">
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
                    <th>Address :</th>
                    <td>
                        <asp:TextBox ID="txtaddress" runat="server" TextMode="MultiLine" Rows="2" placeholder="Delivery street address..." CssClass="form-input" style="font-family:inherit;"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>Mobile :</th>
                    <td>
                        <asp:TextBox ID="txtmobile" runat="server" placeholder="10-digit mobile number" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>Image :</th>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" style="font-size:13px;" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding-top:12px;">
                        <asp:Button ID="Button1" runat="server" Text="Save" OnClick="Button1_Click" CssClass="btn-submit" />
                        &nbsp;&nbsp;&nbsp;Already have an account?
                        <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click" ForeColor="#c45b4c" Font-Bold="True">Login</asp:LinkButton>
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
