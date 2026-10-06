<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="The_Cake_Atelier.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Login - The Cake Atelier</title>
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
                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx" CssClass="active">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx">Register</asp:HyperLink>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Login Content Form (Strictly Mimicking Reference_Code login.aspx) -->
        <div class="login-card">
            <div style="font-size:42px; margin-bottom:10px;">&#129473;</div>
            <h1 style="color:#4a2c1b; margin:0 0 6px 0; font-size:26px;">Member Login</h1>
            <p style="color:#7d5e4b; font-size:14px; margin-bottom:15px;">Please sign in to order your favorite cakes</p>

            <!-- Error message label -->
            <asp:Label ID="lblMsg" runat="server" ForeColor="#c45b4c" Font-Bold="True" Visible="false"></asp:Label>

            <table class="login-table">
                <tr>
                    <th>Email : </th>
                    <td>
                        <asp:TextBox ID="txtemail" runat="server" placeholder="Enter your email" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>Password : </th>
                    <td>
                        <asp:TextBox ID="txtpwd" runat="server" TextMode="Password" placeholder="Enter password" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="Button1" runat="server" Text="Login" OnClick="Button1_Click" CssClass="btn-submit" />
                    </td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align:center; padding-top:15px; border-top:1px solid #f0e6df; color:#6d5444; font-size:14px;">
                        Don't have an account? 
                        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click" ForeColor="#c45b4c" Font-Bold="True">Register Here</asp:LinkButton>
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
