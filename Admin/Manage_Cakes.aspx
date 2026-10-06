<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Manage_Cakes.aspx.cs" Inherits="The_Cake_Atelier.Admin.Manage_Cakes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Cakes Catalog - Bakery Admin</title>
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
                        <asp:HyperLink ID="lnkManageCakes" runat="server" NavigateUrl="Manage_Cakes.aspx" CssClass="active">Manage Cakes</asp:HyperLink>
                        <asp:HyperLink ID="lnkOrders" runat="server" NavigateUrl="View_Orders.aspx">Customer Orders</asp:HyperLink>
                        <asp:HyperLink ID="lnkUsers" runat="server" NavigateUrl="View_Users.aspx">Registered Users</asp:HyperLink>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-btn">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Content -->
        <div class="container">
            <h1 class="page-title">&#128221; Manage Cakes Catalog</h1>
            <div class="page-subtitle">View all confections, update prices, or remove cakes from your live menu</div>

            <!-- Status alert label -->
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

            <!-- Edit Cake Form Panel (Visible when Admin clicks "Edit") -->
            <asp:Panel ID="pnlEdit" runat="server" Visible="false" CssClass="edit-box">
                <div class="edit-title">&#9998; Edit Cake Details (ID: <asp:Label ID="lblEditId" runat="server"></asp:Label>)</div>
                <table class="form-table">
                    <tr>
                        <td style="width: 15%;" class="form-label">Cake Name:</td>
                        <td style="width: 35%;"><asp:TextBox ID="txtname" runat="server" CssClass="form-input"></asp:TextBox></td>
                        <td style="width: 15%;" class="form-label">Price (&#8377;):</td>
                        <td style="width: 35%;"><asp:TextBox ID="txtprice" runat="server" CssClass="form-input"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="form-label">Category:</td>
                        <td>
                            <asp:DropDownList ID="dropcategory" runat="server" CssClass="form-input">
                                <asp:ListItem>Chocolate</asp:ListItem>
                                <asp:ListItem>Fruit</asp:ListItem>
                                <asp:ListItem>Pastries</asp:ListItem>
                                <asp:ListItem>Wedding</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="form-label">Dietary Type:</td>
                        <td>
                            <asp:DropDownList ID="droptype" runat="server" CssClass="form-input">
                                <asp:ListItem>Eggless</asp:ListItem>
                                <asp:ListItem>Regular</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="form-label">Description:</td>
                        <td colspan="3">
                            <asp:TextBox ID="txtdesc" runat="server" TextMode="MultiLine" Rows="2" CssClass="form-input" style="font-family:inherit;"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="3" style="padding-top: 10px;">
                            <asp:Button ID="btnUpdate" runat="server" Text="Save Changes" CssClass="btn-update" OnClick="btnUpdate_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn-cancel" OnClick="btnCancel_Click" />
                        </td>
                    </tr>
                </table>
            </asp:Panel>

            <!-- ASP:GRIDVIEW - DISPLAYING ALL CAKES -->
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="grid-view-table" OnRowCommand="GridView1_RowCommand">
                <Columns>
                    <asp:TemplateField HeaderText="ID" ItemStyle-Width="50px">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text='<%# Eval("Cake_Id") %>' Font-Bold="true"></asp:Label>
                        </ItemTemplate>

<ItemStyle Width="50px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Photo" ItemStyle-Width="80px">
                        <ItemTemplate>
                            <asp:Image ID="imgCake" runat="server" ImageUrl='<%# ("~/" + Eval("Cake_Image")) %>' CssClass="cake-thumb" />
                        </ItemTemplate>

<ItemStyle Width="80px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Cake Name">
                        <ItemTemplate>
                            <strong><%# Eval("Cake_Name") %></strong>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Category" ItemStyle-Width="110px">
                        <ItemTemplate>
                            <%# Eval("Cake_Category") %>
                        </ItemTemplate>

<ItemStyle Width="110px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Type" ItemStyle-Width="90px">
                        <ItemTemplate>
                            <%# Eval("Cake_Type") %>
                        </ItemTemplate>

<ItemStyle Width="90px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Price" ItemStyle-Width="90px">
                        <ItemTemplate>
                            <span style="color:#c45b4c; font-weight:bold;">&#8377;<%# Eval("Cake_Price") %></span>
                        </ItemTemplate>

<ItemStyle Width="90px"></ItemStyle>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Description">
                        <ItemTemplate>
                            <div style="font-size:12px; color:#6d5444; max-width:320px;"><%# Eval("Cake_Desc") %></div>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Actions" ItemStyle-Width="140px">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandArgument='<%# Eval("Cake_Id") %>' CommandName="cmd_edt" CssClass="link-edit">Edit</asp:LinkButton>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandArgument='<%# Eval("Cake_Id") %>' CommandName="cmd_del" CssClass="link-delete" OnClientClick="return confirm('Are you sure you want to delete this cake?');">Delete</asp:LinkButton>
                        </ItemTemplate>

<ItemStyle Width="140px"></ItemStyle>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>

    </form>
</body>
</html>
