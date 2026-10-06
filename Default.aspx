<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="The_Cake_Atelier.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>The Cake Atelier - Artisanal Bakery & Cake Shop</title>
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
                        <asp:HyperLink ID="lnkHome" runat="server" NavigateUrl="Default.aspx" CssClass="active">Home</asp:HyperLink>
                        <asp:HyperLink ID="lnkCakes" runat="server" NavigateUrl="Cakes.aspx">Cakes &amp; Menu</asp:HyperLink>
                        <asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="About.aspx">About Us</asp:HyperLink>
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>

                        <!-- Dynamic Session-Based Authentication Links -->
                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx">Register</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx" Visible="false">Dashboard</asp:HyperLink>
                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting" Visible="false"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn" Visible="false">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Hero Section -->
        <div class="hero-banner">
            <h1 class="hero-title">The Cake Atelier</h1>
            <div class="hero-tagline">Freshly Baked Confections Crafted with Love &amp; Passion</div>
            <p class="hero-text">
                Welcome to The Cake Atelier, where sweet moments are handcrafted fresh daily. 
                Every cake is baked from scratch with pure butter and real ingredients.
            </p>
            <div>
                <asp:HyperLink ID="btnHeroMenu" runat="server" NavigateUrl="Cakes.aspx" CssClass="btn-primary">Browse Full Cake Menu &rarr;</asp:HyperLink>
                <asp:HyperLink ID="btnHeroAbout" runat="server" NavigateUrl="About.aspx" CssClass="btn-secondary">Our Bakery Story</asp:HyperLink>
            </div>
        </div>

        <!-- Main Content -->
        <div class="main-container">

            <!-- Dynamic Featured Cakes (From Database via DataList) -->
            <h2 class="section-heading">Our Featured Cakes</h2>
            <div class="section-subheading">Customer-favorite recipes fetched directly from our bakery database</div>

            <asp:DataList ID="DataListFeaturedCakes" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" Width="100%" OnItemCommand="DataListFeaturedCakes_ItemCommand">
                <ItemTemplate>
                    <div class="cake-card">
                        <asp:Image ID="imgCake" runat="server" ImageUrl='<%# Eval("Cake_Image") %>' CssClass="cake-img" AlternateText='<%# Eval("Cake_Name") %>' />
                        <div class="cake-title"><%# Eval("Cake_Name") %></div>
                        <div class="cake-desc"><%# Eval("Cake_Desc") %></div>
                        <div class="cake-price">&#8377;<%# Eval("Cake_Price") %></div>
                        <asp:Button ID="btnOrder" runat="server" Text="Order Now" CssClass="btn-order" CommandName="Order" CommandArgument='<%# Eval("Cake_Id") %>' />
                    </div>
                </ItemTemplate>
            </asp:DataList>

            <div style="text-align: center; margin-top: 25px;">
                <asp:HyperLink ID="lnkAllCakes" runat="server" NavigateUrl="Cakes.aspx" CssClass="btn-secondary" style="font-size: 15px; padding: 12px 28px;">
                    View All Cakes in Catalog &rarr;
                </asp:HyperLink>
            </div>

            <!-- Dynamic Verified Reviews Section (From Database via DataList) -->
            <h2 class="section-heading" style="margin-top: 60px;">Customer Reviews &amp; Experiences</h2>
            <div class="section-subheading">Live reviews left by real registered members</div>

            <div style="text-align:center;">
                <asp:Label ID="lblNoReviews" runat="server" Text="No customer reviews yet. Be the first to order and review!" ForeColor="#7d5e4b" Font-Size="14px" Visible="false"></asp:Label>
            </div>

            <asp:DataList ID="DataListReviews" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" Width="100%">
                <ItemTemplate>
                    <div class="review-card">
                        <div style="font-size: 11px; font-weight: bold; color: #c45b4c; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 5px;">
                            &#127874; <%# Eval("Cake_Name") %>
                        </div>
                        <div style="color: #ffb703; font-size: 15px; margin-bottom: 6px;">
                            <%# GetStars(Eval("Rating")) %>
                        </div>
                        <div style="font-size: 13px; color: #4a2c1b; margin-bottom: 8px; font-style: italic; line-height: 1.5;">
                            "<%# Eval("Comment") %>"
                        </div>
                        <div style="font-weight: bold; font-size: 13px; color: #7d5e4b;">
                            &mdash; <%# Eval("CustomerName") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:DataList>

        </div>

        <!-- Footer -->
        <div class="footer-container">
            <table class="footer-table">
                <tr>
                    <td class="footer-col">
                        <h3>The Cake Atelier</h3>
                        <p>Artisanal bakery and pâtisserie crafting bespoke confections and fresh daily baked cakes.</p>
                    </td>
                    <td class="footer-col">
                        <h3>Quick Links</h3>
                        <a href="Default.aspx">Home</a>
                        <a href="Cakes.aspx">All Cakes</a>
                        <a href="About.aspx">About Us</a>
                        <a href="Contact.aspx">Contact Us</a>
                    </td>
                    <td class="footer-col">
                        <h3>Customer Care</h3>
                        <a href="login.aspx">Member Login</a>
                        <a href="register.aspx">Register Account</a>
                        <a href="Cart.aspx">My Cart</a>
                    </td>
                    <td class="footer-col">
                        <h3>Bakery Hours</h3>
                        <p>Monday - Saturday: 8:00 AM - 10:00 PM</p>
                        <p>Sunday: 9:00 AM - 9:00 PM</p>
                    </td>
                </tr>
            </table>
            <div class="footer-bottom">
                &copy; 2026 The Cake Atelier. All Rights Reserved.
            </div>
        </div>

    </form>
</body>
</html>
