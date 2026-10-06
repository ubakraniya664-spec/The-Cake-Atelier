<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Add_Cake.aspx.cs" Inherits="The_Cake_Atelier.Admin.Add_Cake" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Cake - Bakery Admin</title>
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
                        <asp:HyperLink ID="lnkAddCake" runat="server" NavigateUrl="Add_Cake.aspx" CssClass="active">Add Cake</asp:HyperLink>
                        <asp:HyperLink ID="lnkManageCakes" runat="server" NavigateUrl="Manage_Cakes.aspx">Manage Cakes</asp:HyperLink>
                        <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="View_Orders.aspx">Customer Orders</asp:HyperLink>
                        <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="View_Users.aspx">Registered Users</asp:HyperLink>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Add Cake Form Container -->
        <div class="container">
            <h1 class="page-title">&#10010; Add New Cake to Menu</h1>
            <div class="page-subtitle">Fill in the details below to publish a new cake to the customer catalog</div>

            <!-- Status alert label -->
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

            <table class="form-table">
                <tr>
                    <td class="form-label">Cake Name:</td>
                    <td>
                        <asp:TextBox ID="txtname" runat="server" placeholder="e.g. Belgian Truffle Gateau" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Category:</td>
                    <td>
                        <asp:DropDownList ID="dropcategory" runat="server" CssClass="form-dropdown">
                            <asp:ListItem>Chocolate</asp:ListItem>
                            <asp:ListItem>Fruit</asp:ListItem>
                            <asp:ListItem>Pastries</asp:ListItem>
                            <asp:ListItem>Wedding</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Dietary Type:</td>
                    <td>
                        <asp:DropDownList ID="droptype" runat="server" CssClass="form-dropdown">
                            <asp:ListItem>Eggless</asp:ListItem>
                            <asp:ListItem>Regular</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Price (&#8377;):</td>
                    <td>
                        <asp:TextBox ID="txtprice" runat="server" placeholder="e.g. 550" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Description:</td>
                    <td>
                        <asp:TextBox ID="txtdesc" runat="server" TextMode="MultiLine" Rows="3" placeholder="Fluffy dark cocoa sponge with sour cherries..." CssClass="form-input" style="font-family:inherit;"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="form-label">Cake Image:</td>
                    <td>
                        <asp:FileUpload ID="FileUpload1" runat="server" style="font-size:13px;" />
                        <div style="font-size:12px; color:#7d5e4b; margin-top:4px;">Upload JPG or PNG photo of the cake</div>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="padding-top:15px;">
                        <asp:Button ID="btnAddCake" runat="server" Text="Add Cake to Menu" CssClass="btn-submit" OnClick="btnAddCake_Click" />
                        <asp:Button ID="btnReset" runat="server" Text="Reset Form" CssClass="btn-reset" OnClick="btnReset_Click" />
                    </td>
                </tr>
            </table>
        </div>

    </form>
</body>
</html>
