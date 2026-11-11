<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="The_Cake_Atelier.Cart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>My Shopping Cart - The Cake Atelier</title>
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
        <div class="cart-container" style="max-width: 950px; margin: 40px auto; padding: 30px;">
            <center>
                <h1 style="color: #4a2c1b; margin-bottom: 5px;">My Shopping Cart</h1>
                <p style="color: #7d5e4b; font-size: 14px; margin-bottom: 25px;">Review items in your basket. Click Edit to update quantity or delete an item.</p>

                <!-- Status Message -->
                <asp:Label ID="lblMsg" runat="server" Visible="false" Font-Bold="true"></asp:Label>

                <!-- Shopping Cart GridView -->
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="cart_id"
                    CssClass="grid-view-table" Width="100%"
                    OnRowEditing="GridView1_RowEditing"
                    OnRowCancelingEdit="GridView1_RowCancelingEdit"
                    OnRowUpdating="GridView1_RowUpdating"
                    OnRowDeleting="GridView1_RowDeleting">
                    <Columns>
                        <asp:TemplateField HeaderText="Cake Photo" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Image ID="imgProd" runat="server" Height="70px" Width="70px" CssClass="cake-thumb" ImageUrl='<%# Eval("Cake_Image") %>' />
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Cake Name">
                            <ItemTemplate>
                                <asp:Label ID="lblProdName" runat="server" Text='<%# Eval("Cake_Name") %>' Font-Bold="true" ForeColor="#4a2c1b"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Price (₹)" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblPrice" runat="server" Text='<%# "₹" + Eval("total") %>' Font-Bold="true" ForeColor="#c45b4c"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Quantity" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblQunty" runat="server" Text='<%# Eval("qunty") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlQunty" runat="server" SelectedValue='<%# Eval("qunty") %>' Style="padding: 4px 8px; border-radius: 4px;">
                                    <asp:ListItem Value="1">1</asp:ListItem>
                                    <asp:ListItem Value="2">2</asp:ListItem>
                                    <asp:ListItem Value="3">3</asp:ListItem>
                                    <asp:ListItem Value="4">4</asp:ListItem>
                                    <asp:ListItem Value="5">5</asp:ListItem>
                                    <asp:ListItem Value="6">6</asp:ListItem>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Added Date" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:Label ID="lblDate" runat="server" Text='<%# Eval("addeddate") %>' ForeColor="#7d5e4b"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Action" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:LinkButton ID="lnkEdit" runat="server" CssClass="link-edit" CommandName="Edit">Edit</asp:LinkButton>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:LinkButton ID="lnkUpdate" runat="server" CssClass="link-edit" CommandName="Update">Update</asp:LinkButton>
                                &nbsp;
                                <asp:LinkButton ID="lnkDelete" runat="server" CssClass="link-delete" CommandName="Delete">Delete</asp:LinkButton>
                                &nbsp;
                                <asp:LinkButton ID="lnkCancel" runat="server" CssClass="link-edit" CommandName="Cancel">Cancel</asp:LinkButton>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div style="padding: 35px 20px; text-align: center;">
                            <div style="font-size: 36px; margin-bottom: 8px;">🛒</div>
                            <div style="color: #4a2c1b; font-size: 16px; font-weight: bold; margin-bottom: 6px;">Your cart is currently empty!</div>
                            <p style="color: #7d5e4b; font-size: 13px; margin-bottom: 15px;">Explore our cake catalog to pick your favorite confection.</p>
                            <a href="Cakes.aspx" class="action-btn">Browse Cakes Menu &rarr;</a>
                        </div>
                    </EmptyDataTemplate>
                </asp:GridView>

                <div style="margin-top: 25px; padding: 18px 24px; background-color: #faf4ef; border: 1px solid #ebdcd3; border-radius: 8px; display: flex; justify-content: space-between; align-items: center;">
                    <div style="font-size: 18px; font-weight: bold; color: #4a2c1b;">
                        Grand Total: <span style="color: #c45b4c; font-size: 24px;">₹<asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></span>
                    </div>
                    <div>
                        <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout &rarr;" CssClass="action-btn" OnClick="btnCheckout_Click" />
                        <br />
                    </div>
                </div>
                <asp:HyperLink ID="lnkContinue" runat="server" NavigateUrl="Cakes.aspx" CssClass="action-btn" Style="background-color: #4a2c1b; margin-right: 12px;">
                    &larr; Continue Shopping
                </asp:HyperLink>
            </center>
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
