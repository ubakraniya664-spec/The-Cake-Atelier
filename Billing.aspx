<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Billing.aspx.cs" Inherits="The_Cake_Atelier.Billing" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Order Invoice &amp; Bill - The Cake Atelier</title>
    <link href="Style.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        @media print {
            .no-print, .header-bar, .footer-container {
                display: none !important;
            }
        }
    </style>
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
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx">Dashboard</asp:HyperLink>

                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Invoice Container -->
        <div class="main-container" style="max-width: 920px;">
            <div class="alert-box alert-success no-print" style="text-align: center; font-weight: bold;">
                &#10004; Thank you! Your cake order has been placed successfully.
            </div>

            <div class="edit-box">
                <table style="width: 100%; border-bottom: 2px solid #c45b4c; padding-bottom: 12px; margin-bottom: 20px;">
                    <tr>
                        <td>
                            <h1 style="margin: 0; color: #4a2c1b; font-size: 26px;">INVOICE &amp; BILL</h1>
                            <div style="color: #7d5e4b; font-size: 13px;">The Cake Atelier - Official Order Receipt</div>
                        </td>
                        <td style="text-align: right;">
                            <div style="font-size: 16px; font-weight: bold; color: #4a2c1b;">
                                Order ID: <asp:Label ID="lblOrderId" runat="server" ForeColor="#c45b4c"></asp:Label>
                            </div>
                            <div style="font-size: 13px; color: #7d5e4b; margin-top: 4px;">
                                Date: <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                            </div>
                        </td>
                    </tr>
                </table>

                <!-- Customer & Order Details -->
                <table style="width: 100%; margin-bottom: 22px; border-collapse: collapse;">
                    <tr>
                        <td style="width: 48%; vertical-align: top; background-color: #faf4ef; border: 1px solid #ebdcd3; border-radius: 8px; padding: 15px;">
                            <div class="edit-title">Customer &amp; Delivery Details</div>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Name:</strong> <asp:Label ID="lblCustName" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Email:</strong> <asp:Label ID="lblCustEmail" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Mobile:</strong> <asp:Label ID="lblCustMobile" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Address:</strong> <asp:Label ID="lblCustAddress" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>City:</strong> <asp:Label ID="lblCustCity" runat="server"></asp:Label></p>
                        </td>
                        <td style="width: 4%;"></td>
                        <td style="width: 48%; vertical-align: top; background-color: #faf4ef; border: 1px solid #ebdcd3; border-radius: 8px; padding: 15px;">
                            <div class="edit-title">Order Information</div>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Order No:</strong> <asp:Label ID="lblOrderNo" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Order Date:</strong> <asp:Label ID="lblDate" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Payment Method:</strong> <asp:Label ID="lblPaymentMethod" runat="server"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Payment Status:</strong> <asp:Label ID="lblPaymentStatus" runat="server" Font-Bold="true" ForeColor="#c45b4c"></asp:Label></p>
                            <p style="margin: 6px 0; font-size: 14px;"><strong>Customer Email ID:</strong> <asp:Label ID="lblUserId" runat="server"></asp:Label></p>
                        </td>
                    </tr>
                </table>

                <!-- Ordered Cakes Grid -->
                <div class="edit-title">Ordered Cakes</div>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" EmptyDataText="No item details found.">
                    <Columns>
                        <asp:TemplateField HeaderText="Photo">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server" ImageUrl='<%# Eval("prod_img") %>' CssClass="cake-thumb" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="prod_id" HeaderText="Cake ID" />
                        <asp:BoundField DataField="prod_name" HeaderText="Cake Name" />
                        <asp:TemplateField HeaderText="Unit Price">
                            <ItemTemplate>
                                ₹<%# Eval("price") %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="qunty" HeaderText="Quantity" />
                        <asp:TemplateField HeaderText="Total Price">
                            <ItemTemplate>
                                <strong>₹<%# Eval("item_total") %></strong>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>

                <!-- Bill Summary -->
                <table style="width: 320px; margin-left: auto; margin-top: 20px; background-color: #faf4ef; border: 1px solid #ebdcd3; border-radius: 8px; padding: 14px;">
                    <tr>
                        <td style="padding: 6px; font-size: 14px;">Cakes Subtotal:</td>
                        <td style="padding: 6px; font-size: 14px; text-align: right; font-weight: bold;">₹<asp:Label ID="lblSubtotal" runat="server" Text="0"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 6px; font-size: 14px;">Delivery Charge:</td>
                        <td style="padding: 6px; font-size: 14px; text-align: right; font-weight: bold;">₹<asp:Label ID="lblDeliveryCharge" runat="server" Text="60"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="padding: 10px 6px 4px 6px; border-top: 2px solid #c45b4c; font-size: 18px; font-weight: bold; color: #4a2c1b;">Grand Total:</td>
                        <td style="padding: 10px 6px 4px 6px; border-top: 2px solid #c45b4c; font-size: 18px; font-weight: bold; color: #c45b4c; text-align: right;">₹<asp:Label ID="lblGrandTotal" runat="server" Text="0"></asp:Label></td>
                    </tr>
                </table>

                <!-- Action Buttons -->
                <div class="no-print" style="margin-top: 25px; display: flex; justify-content: space-between; align-items: center;">
                    <asp:HyperLink ID="lnkShopping" runat="server" NavigateUrl="Cakes.aspx" CssClass="action-btn" Style="background-color: #4a2c1b;">&larr; Continue Shopping</asp:HyperLink>
                    <button type="button" onclick="window.print();" class="btn-update">&#128424; Print Bill</button>
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