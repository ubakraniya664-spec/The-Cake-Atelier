<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Login.aspx.cs" Inherits="The_Cake_Atelier.Admin.Admin_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Bakery Staff Portal - The Cake Atelier</title>
    <link href="../Style.css" rel="stylesheet" type="text/css" />
</head>
<body class="admin-auth-body">
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="portal-icon">&#128274;</div>
            <h1 class="portal-title">The Cake Atelier</h1>
            <div class="portal-subtitle">Bakery Administration Portal</div>

            <!-- Error message label -->
            <asp:Label ID="lblMsg" runat="server" CssClass="alert-error" Visible="false"></asp:Label>

            <table class="login-table">
                <tr>
                    <td>
                        <span class="form-label">Admin Email:</span>
                        <asp:TextBox ID="txtadminemail" runat="server" placeholder="Enter admin email" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Admin Password:</span>
                        <asp:TextBox ID="txtadminpwd" runat="server" TextMode="Password" placeholder="Enter password" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnLogin" runat="server" Text="Sign In to Dashboard" CssClass="btn-login" OnClick="btnLogin_Click" />
                    </td>
                </tr>
            </table>
            <div style="margin-top: 15px; font-size: 13px; color: #7d5e4b;">
                Need a new admin account? 
    <a href="Admin_Register.aspx" style="color: #c45b4c; font-weight: bold; text-decoration: none;">Register Here &rarr;</a>
            </div>

            <a href="../Default.aspx" class="back-link">&larr; Return to Customer Storefront</a>
        </div>
    </form>
</body>
</html>
