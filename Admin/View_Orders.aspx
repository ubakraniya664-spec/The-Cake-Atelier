<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="View_Orders.aspx.cs" Inherits="The_Cake_Atelier.Admin.View_Orders" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Customer Orders - Bakery Admin</title>
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
                        <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="View_Orders.aspx" CssClass="active">Customer Orders</asp:HyperLink>
                        <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="View_Users.aspx">Registered Users</asp:HyperLink>
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
                        <h1 class="page-title">&#128230; Customer Orders</h1>
                        <div class="page-subtitle">View all customer orders, and update payment/delivery status</div>
                    </td>
                    <td style="text-align: right;">
                        <asp:Label ID="lblOrderCount" runat="server" CssClass="user-count-badge"></asp:Label>
                    </td>
                </tr>
            </table>

            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

            <!-- Orders GridView with In-Place Status Editing -->
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                DataKeyNames="order_id"
                CssClass="grid-view-table"
                OnRowEditing="GridView1_RowEditing"
                OnRowCancelingEdit="GridView1_RowCancelingEdit"
                OnRowUpdating="GridView1_RowUpdating"
                OnRowDeleting="GridView1_RowDeleting"
                EmptyDataText="No customer orders placed yet.">
                <Columns>
                    <asp:TemplateField HeaderText="Order ID" ItemStyle-Width="80px">
                        <ItemTemplate>
                            <strong>#<%# Eval("order_id") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Customer Email">
                        <ItemTemplate>
                            <span style="color: #c45b4c; font-weight: 500;"><%# Eval("order_user_id") %></span>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Order Date">
                        <ItemTemplate>
                            <%# Eval("date") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Total Amount">
                        <ItemTemplate>
                            <strong style="color: #4a2c1b;">₹<%# Eval("total_amount") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Payment Method">
                        <ItemTemplate>
                            <%# Eval("payment_method") %>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Status" ItemStyle-Width="150px">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("payment_status") %>' Font-Bold="true"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" SelectedValue='<%# Eval("payment_status") %>' Style="padding: 5px 8px; border: 1px solid #d4c3b7; border-radius: 4px; font-size: 13px; width: 140px;">
                                <asp:ListItem Value="Pending">Pending</asp:ListItem>
                                <asp:ListItem Value="Paid">Paid</asp:ListItem>
                                <asp:ListItem Value="Preparing">Preparing</asp:ListItem>
                                <asp:ListItem Value="Out for Delivery">Out for Delivery</asp:ListItem>
                                <asp:ListItem Value="Delivered">Delivered</asp:ListItem>
                                <asp:ListItem Value="Cancelled">Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="230px" ItemStyle-Wrap="false">
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
            </asp:GridView>
        </div>
    </form>
</body>
</html>
