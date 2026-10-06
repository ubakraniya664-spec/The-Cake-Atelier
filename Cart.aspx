<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="The_Cake_Atelier.Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Shopping Cart &amp; Checkout - The Cake Atelier</title>
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

        <!-- Cart Container -->
        <div class="cart-container">
            <h2 class="page-title">Your Shopping Cart &amp; Checkout</h2>

            <!-- Empty Cart Notice -->
            <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" style="text-align:center; padding: 40px 10px;">
                <div style="font-size: 40px; margin-bottom: 10px;">&#129382;</div>
                <div style="font-size: 18px; color: #4a2c1b; font-weight: bold; margin-bottom: 8px;">Your cart is currently empty!</div>
                <p style="color: #7d5e4b; font-size: 14px; margin-bottom: 20px;">Choose a handcrafted cake from our catalog to get started.</p>
                <asp:HyperLink ID="btnBrowse" runat="server" NavigateUrl="Cakes.aspx" style="background-color:#4a2c1b; color:#ffffff; padding:10px 22px; text-decoration:none; border-radius:5px; font-weight:bold;">Explore Cake Menu &rarr;</asp:HyperLink>
            </asp:Panel>

            <!-- Order Success Confirmation (Real Database Order ID) -->
            <asp:Panel ID="pnlOrderSuccess" runat="server" Visible="false" CssClass="order-success-box">
                <div style="font-size: 32px; margin-bottom: 8px;">&#10004;</div>
                <h3 style="margin: 0 0 10px 0; color: #155724;">Thank You! Your Order has been Placed.</h3>
                <p>
                    <asp:Label ID="lblConfirmedOrderId" runat="server" Font-Bold="true" Font-Size="19px"></asp:Label>
                </p>
                <p style="font-size: 14px; color: #1e7e34; margin-bottom: 20px;">
                    Your fresh cake order has been saved in the database!
                </p>
                <asp:HyperLink ID="lnkBackHome" runat="server" NavigateUrl="Default.aspx" style="color: #155724; font-weight: bold; text-decoration: underline;">Return to Home Page</asp:HyperLink>
            </asp:Panel>

            <!-- Active Cart Panel -->
            <asp:Panel ID="pnlActiveCart" runat="server">
                
                <div class="form-section-title">Selected Cake Details</div>

                <!-- ASP:DATALIST CONTROL FOR CART ITEM -->
                <asp:DataList ID="DataListCart" runat="server" Width="100%">
                    <ItemTemplate>
                        <div class="cart-item-box">
                            <table style="width: 100%; border-collapse: collapse;">
                                <tr>
                                    <td style="width: 130px; vertical-align: middle;">
                                        <asp:Image ID="imgItem" runat="server" ImageUrl='<%# Eval("Cake_Image") %>' CssClass="cart-item-img" />
                                    </td>
                                    <td style="vertical-align: top; padding-left: 15px;">
                                        <h3 style="margin: 0 0 6px 0; color: #4a2c1b; font-size: 20px;">
                                            <%# Eval("Cake_Name") %>
                                        </h3>
                                        <p style="margin: 0 0 10px 0; color: #6d5444; font-size: 13px; line-height: 1.5;">
                                            <%# Eval("Cake_Desc") %>
                                        </p>
                                        <div style="font-size: 15px; color: #7d5e4b;">
                                            Category: <strong><%# Eval("Cake_Category") %></strong> | Type: <strong><%# Eval("Cake_Type") %></strong>
                                        </div>
                                        <div style="font-size: 18px; font-weight: bold; color: #c45b4c; margin-top: 8px;">
                                            Price: &#8377;<%# Eval("Cake_Price") %>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </ItemTemplate>
                </asp:DataList>

                <!-- Order Billing & Delivery Details -->
                <div class="form-section-title">Billing &amp; Delivery Information</div>
                <table class="checkout-table">
                    <tr>
                        <td style="width: 25%;"><strong>Select Quantity:</strong></td>
                        <td>
                            <asp:DropDownList ID="ddlQuantity" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlQuantity_SelectedIndexChanged" style="padding: 6px 12px; border-radius: 4px; border: 1px solid #d4c3b7;">
                                <asp:ListItem Value="1">1</asp:ListItem>
                                <asp:ListItem Value="2">2</asp:ListItem>
                                <asp:ListItem Value="3">3</asp:ListItem>
                                <asp:ListItem Value="4">4</asp:ListItem>
                                <asp:ListItem Value="5">5</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Total Amount:</strong></td>
                        <td>
                            <span style="font-size: 20px; font-weight: bold; color: #c45b4c;">
                                &#8377;<asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                            </span>
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Recipient Name:</strong></td>
                        <td><asp:TextBox ID="txtRecipient" runat="server" CssClass="txt-input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><strong>Contact Phone:</strong></td>
                        <td><asp:TextBox ID="txtPhone" runat="server" CssClass="txt-input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><strong>Delivery Address:</strong></td>
                        <td><asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine" Rows="2" CssClass="txt-input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><strong>Message on Cake (Optional):</strong></td>
                        <td><asp:TextBox ID="txtMessage" runat="server" placeholder="e.g., Happy 25th Birthday Rhea!" CssClass="txt-input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Label ID="lblCartError" runat="server" ForeColor="#c45b4c" Font-Bold="true" Visible="false"></asp:Label>
                            <br />
                            <asp:Button ID="btnConfirmOrder" runat="server" Text="Confirm &amp; Place Order" CssClass="btn-confirm" OnClick="btnConfirmOrder_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </div>

    </form>
</body>
</html>
