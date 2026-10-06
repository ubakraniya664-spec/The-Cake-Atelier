<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View_Users.aspx.cs" Inherits="The_Cake_Atelier.Admin.View_Users" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registered Users - Bakery Admin</title>
    <link href="../Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Admin Header -->
        <div class="admin-header">
            <table class="nav-table">
                <tr>
                    <td style="width: 35%;">
                        <asp:HyperLink ID="lnkBrand" runat="server" NavigateUrl="Dashboard.aspx" CssClass="brand-title">The Cake Atelier</asp:HyperLink>
                        <span class="brand-badge">ADMIN</span>
                    </td>
                    <td class="admin-nav-links">
                        <asp:HyperLink ID="lnkDash" runat="server" NavigateUrl="Dashboard.aspx">Dashboard</asp:HyperLink>
                        <asp:HyperLink ID="lnkAddCake" runat="server" NavigateUrl="Add_Cake.aspx">Add Cake</asp:HyperLink>
                        <asp:HyperLink ID="lnkManageCakes" runat="server" NavigateUrl="Manage_Cakes.aspx">Manage Cakes</asp:HyperLink>
                        <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="View_Orders.aspx">Customer Orders</asp:HyperLink>
                        <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="View_Users.aspx" CssClass="active">Registered Users</asp:HyperLink>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Content -->
        <div class="container">
            <table class="page-header-table">
                <tr>
                    <td>
                        <h1 class="page-title">&#128101; Registered Customers</h1>
                        <div class="page-subtitle">View all registered customer accounts and delivery contact information</div>
                    </td>
                    <td style="text-align: right;">
                        <asp:Label ID="lblUserCount" runat="server" CssClass="user-count-badge"></asp:Label>
                    </td>
                </tr>
            </table>

            <!-- Status Alert Message -->
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

            <!-- ASP:GRIDVIEW - DISPLAYING ALL REGISTERED USERS -->
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="ID" ItemStyle-Width="40px">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("Id") %>' Font-Bold="true"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Photo" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:Image ID="imgUser" runat="server" ImageUrl='<%# "~/" + Eval("Image") %>' CssClass="user-avatar" />
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Customer Name">
                        <ItemTemplate>
                            <strong><%# Eval("Name") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Gender" ItemStyle-Width="80px">
                        <ItemTemplate>
                            <%# Eval("Gender") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <span style="color:#c45b4c; font-weight:500;"><%# Eval("Email") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="City" ItemStyle-Width="100px">
                        <ItemTemplate>
                            <%# Eval("City") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Mobile" ItemStyle-Width="110px">
                        <ItemTemplate>
                            <%# Eval("Mobile") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Delivery Address">
                        <ItemTemplate>
                            <div style="font-size:12px; color:#6d5444; max-width:260px;"><%# Eval("Address") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Action" ItemStyle-Width="80px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("Id") %>' CommandName="cmd_del" CssClass="link-delete" OnClientClick="return confirm('Are you sure you want to delete this customer account?');">Delete</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>

    </form>
</body>
</html>
