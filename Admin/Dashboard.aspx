<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="The_Cake_Atelier.Admin.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - The Cake Atelier</title>
    <link href="../Style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">

        <!-- Admin Sticky Navigation Bar -->
        <div class="admin-header">
            <table class="nav-table">
                <tr>
                    <td style="width: 35%;">
                        <asp:HyperLink ID="lnkBrand" runat="server" NavigateUrl="Dashboard.aspx" CssClass="brand-title">The Cake Atelier</asp:HyperLink>
                        <span class="brand-badge">ADMIN</span>
                    </td>
                    <td class="admin-nav-links">
                        <asp:HyperLink ID="lnkDash" runat="server" NavigateUrl="Dashboard.aspx" CssClass="active">Dashboard</asp:HyperLink>
                        <asp:HyperLink ID="lnkAddCake" runat="server" NavigateUrl="Add_Cake.aspx">Add Cake</asp:HyperLink>
                        <asp:HyperLink ID="lnkManageCakes" runat="server" NavigateUrl="Manage_Cakes.aspx">Manage Cakes</asp:HyperLink>
                        <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="View_Orders.aspx">Customer Orders</asp:HyperLink>
                        <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="View_Users.aspx">Registered Users</asp:HyperLink>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Dashboard Content -->
        <div class="container">
            <h1 class="welcome-title">Welcome, <asp:Label ID="lblAdminName" runat="server" ForeColor="#c45b4c"></asp:Label></h1>
            <div class="welcome-sub">Here is your live bakery overview and statistics</div>

            <!-- Live Summary Stats -->
            <table class="stats-table">
                <tr>
                    <td class="stat-card">
                        <div class="stat-icon">&#127874;</div>
                        <div class="stat-value"><asp:Label ID="lblTotalCakes" runat="server">0</asp:Label></div>
                        <div class="stat-label">Cakes in Menu</div>
                    </td>
                    <td style="width: 2%;"></td>
                    <td class="stat-card">
                        <div class="stat-icon">&#128230;</div>
                        <div class="stat-value"><asp:Label ID="lblTotalOrders" runat="server">0</asp:Label></div>
                        <div class="stat-label">Total Orders Placed</div>
                    </td>
                    <td style="width: 2%;"></td>
                    <td class="stat-card">
                        <div class="stat-icon">&#128101;</div>
                        <div class="stat-value"><asp:Label ID="lblTotalUsers" runat="server">0</asp:Label></div>
                        <div class="stat-label">Registered Customers</div>
                    </td>
                    <td style="width: 2%;"></td>
                    <td class="stat-card">
                        <div class="stat-icon">&#8377;</div>
                        <div class="stat-value">&#8377;<asp:Label ID="lblTotalRevenue" runat="server">0</asp:Label></div>
                        <div class="stat-label">Total Sales Revenue</div>
                    </td>
                </tr>
            </table>

            <!-- Quick Actions -->
            <h2 class="section-title">Quick Administration Actions</h2>
            <table class="actions-table">
                <tr>
                    <td class="action-card">
                        <div style="font-size:32px;">&#10010;</div>
                        <h3 style="margin:8px 0 4px 0; color:#4a2c1b;">Add New Cake</h3>
                        <p style="font-size:13px; color:#6d5444; margin:0 0 10px 0;">Add a new handcrafted cake recipe with price and photo to the storefront.</p>
                        <asp:HyperLink ID="btnQuickAdd" runat="server" NavigateUrl="Add_Cake.aspx" CssClass="action-btn">Open Add Cake Form &rarr;</asp:HyperLink>
                    </td>
                    <td style="width: 3%;"></td>
                    <td class="action-card">
                        <div style="font-size:32px;">&#128221;</div>
                        <h3 style="margin:8px 0 4px 0; color:#4a2c1b;">Manage Catalog</h3>
                        <p style="font-size:13px; color:#6d5444; margin:0 0 10px 0;">View all cakes currently on the menu, update prices, or remove confections.</p>
                        <asp:HyperLink ID="btnQuickManage" runat="server" NavigateUrl="Manage_Cakes.aspx" CssClass="action-btn">Manage Cake List &rarr;</asp:HyperLink>
                    </td>
                    <td style="width: 3%;"></td>
                    <td class="action-card">
                        <div style="font-size:32px;">&#128722;</div>
                        <h3 style="margin:8px 0 4px 0; color:#4a2c1b;">View Customer Orders</h3>
                        <p style="font-size:13px; color:#6d5444; margin:0 0 10px 0;">Check real orders placed by customers, delivery addresses, and phone numbers.</p>
                        <asp:HyperLink ID="btnQuickOrders" runat="server" NavigateUrl="View_Orders.aspx" CssClass="action-btn">View All Orders &rarr;</asp:HyperLink>
                    </td>
                </tr>
            </table>
        </div>

    </form>
</body>
</html>
