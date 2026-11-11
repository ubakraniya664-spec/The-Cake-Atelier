<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Order.aspx.cs" Inherits="The_Cake_Atelier.Order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Order Summary &amp; Checkout - The Cake Atelier</title>
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
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx" CssClass="active">Cart</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx">Dashboard</asp:HyperLink>

                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Order Summary Container -->
        <div class="main-container" style="max-width: 980px;">
            <div style="margin-bottom: 15px;">
                <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="Cart.aspx" CssClass="action-btn" Style="background-color: #4a2c1b;">&larr; Back to Cart</asp:HyperLink>
            </div>

            <h1 class="section-heading">Order Summary &amp; Checkout</h1>
            <div class="section-subheading">Confirm your cakes, delivery address, and payment method</div>

            <!-- 1. Ordered Cakes -->
            <div class="edit-box">
                <div class="edit-title">1. Selected Cakes</div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" EmptyDataText="Your cart is empty.">
                    <Columns>
                        <asp:TemplateField HeaderText="Photo">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server" ImageUrl='<%# Eval("Cake_Image") %>' CssClass="cake-thumb" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="cart_prod_id" HeaderText="Cake ID" />
                        <asp:BoundField DataField="Cake_Name" HeaderText="Cake Name" />
                        <asp:TemplateField HeaderText="Unit Price">
                            <ItemTemplate>
                                <span style="color: #c45b4c; font-weight: bold;">₹<%# Eval("total") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="qunty" HeaderText="Quantity" />
                        <asp:TemplateField HeaderText="Item Total">
                            <ItemTemplate>
                                <span style="font-weight: bold;">₹<%# Eval("item_total") %></span>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>

            <!-- 2. Customer & Delivery Details -->
            <div class="edit-box">
                <div class="edit-title">2. Delivery Details</div>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" EmptyDataText="Customer details not found.">
                    <Columns>
                        <asp:BoundField DataField="Name" HeaderText="Customer Name" />
                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="Mobile" HeaderText="Mobile Number" />
                        <asp:BoundField DataField="Address" HeaderText="Delivery Address" />
                        <asp:BoundField DataField="City" HeaderText="City" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- 3. Order Calculation Summary -->
            <div class="edit-box">
                <div class="edit-title">3. Bill Summary</div>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table">
                    <Columns>
                        <asp:BoundField DataField="ProductTotal" HeaderText="Cakes Subtotal" />
                        <asp:BoundField DataField="DeliveryCharge" HeaderText="Delivery Charge" />
                        <asp:BoundField DataField="GrandTotal" HeaderText="Grand Total" />
                    </Columns>
                </asp:GridView>
            </div>

            <!-- 4. Payment Method & Place Order -->
            <div class="edit-box" style="background-color: #faf4ef;">
                <div class="edit-title">4. Payment Method</div>

                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

                <asp:RadioButtonList ID="rblPayment" runat="server" RepeatDirection="Horizontal" CellPadding="10" Style="font-size: 15px; font-weight: bold; color: #4a2c1b;">
                    <asp:ListItem Text="Cash on Delivery (COD)" Value="COD" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="UPI Payment" Value="UPI"></asp:ListItem>
                </asp:RadioButtonList>

                <div style="text-align: right; margin-top: 15px;">
                    <div style="font-size: 20px; font-weight: bold; color: #4a2c1b; margin-bottom: 12px;">
                        Grand Total: <span style="color: #c45b4c; font-size: 26px;">₹<asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label></span>
                    </div>
                    <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order &amp; Generate Bill &rarr;" CssClass="btn-update" OnClick="btnPlaceOrder_Click" Style="font-size: 15px; padding: 12px 28px;" />
                </div>
            </div>
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