<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cakes.aspx.cs" Inherits="The_Cake_Atelier.Cakes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Cakes &amp; Menu - The Cake Atelier</title>
    <link href="Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <div class="top-ribbon">
            &#127856; All cakes baked fresh to order &bull; 100% Eggless options available &bull; Handcrafted daily
        </div>

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
                        <asp:HyperLink ID="lnkCakes" runat="server" NavigateUrl="Cakes.aspx" CssClass="active">Cakes &amp; Menu</asp:HyperLink>
                        <asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="About.aspx">About Us</asp:HyperLink>
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>

                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx">Register</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx" Visible="false">Dashboard</asp:HyperLink>
                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting" Visible="false"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn" Visible="false">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Content -->
        <div class="main-container">

            <h1 class="section-heading">Our Artisanal Cake Collection</h1>
            <div class="section-subheading">Handcrafted signature cakes dynamically loaded from our database</div>

            <!-- Filter Controls Bar -->
            <div class="filter-box">
                <table class="filter-table">
                    <tr>
                        <td style="font-weight:bold; width:12%;">Filter Menu:</td>
                        <td style="width:32%;">
                            Category:
                            <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_Changed" style="padding:6px 10px; border-radius:4px; border:1px solid #d4c3b7;">
                                <asp:ListItem Value="All">All Categories</asp:ListItem>
                                <asp:ListItem Value="Chocolate">Chocolate Delights</asp:ListItem>
                                <asp:ListItem Value="Fruit">Fruit &amp; Berries</asp:ListItem>
                                <asp:ListItem Value="Pastries">Cupcakes &amp; Pastries</asp:ListItem>
                                <asp:ListItem Value="Wedding">Wedding &amp; Designer</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="width:32%;">
                            Dietary:
                            <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilter_Changed" style="padding:6px 10px; border-radius:4px; border:1px solid #d4c3b7;">
                                <asp:ListItem Value="All">All Types</asp:ListItem>
                                <asp:ListItem Value="Eggless">100% Eggless</asp:ListItem>
                                <asp:ListItem Value="Regular">Classic with Egg</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="text-align:right;">
                            <asp:Label ID="lblFilterStatus" runat="server" Text="Loading confections..." ForeColor="#7d5e4b" Font-Size="13px"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Dynamic Catalog DataList (Zero dummy values) -->
            <asp:DataList ID="DataListCakes" runat="server" RepeatDirection="Horizontal" RepeatColumns="3" Width="100%" OnItemCommand="DataListCakes_ItemCommand">
                <ItemTemplate>
                    <div class="cake-card">
                        <asp:Image ID="imgCake" runat="server" ImageUrl='<%# Eval("Cake_Image") %>' CssClass="cake-img" AlternateText='<%# Eval("Cake_Name") %>' />
                        <div class="cake-title"><%# Eval("Cake_Name") %></div>
                        <div class="cake-desc"><%# Eval("Cake_Desc") %></div>
                        <div class="cake-price">&#8377;<%# Eval("Cake_Price") %></div>
                        <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn-order" CommandName="AddToCart" CommandArgument='<%# Eval("Cake_Id") %>' />
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
