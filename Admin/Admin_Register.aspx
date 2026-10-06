<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin_Register.aspx.cs" Inherits="The_Cake_Atelier.Admin.Admin_Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Registration - The Cake Atelier</title>
    <link href="../Style.css" rel="stylesheet" type="text/css" />
</head>
<body class="admin-auth-body">
    <form id="form1" runat="server">
        <div class="reg-box">
            <div class="portal-icon">&#128100;</div>
            <h1 class="portal-title">The Cake Atelier</h1>
            <div class="portal-subtitle">Admin Registration</div>

            <!-- Status message label -->
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>

            <table class="reg-table">
                <tr>
                    <td>
                        <span class="form-label">Full Name:</span>
                        <asp:TextBox ID="txtfullname" runat="server" placeholder="Enter your full name" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Email:</span>
                        <asp:TextBox ID="txtemail" runat="server" placeholder="Enter your email" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Mobile:</span>
                        <asp:TextBox ID="txtmobile" runat="server" placeholder="Enter 10-digit mobile number" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Username:</span>
                        <asp:TextBox ID="txtuser" runat="server" placeholder="Enter username" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Password:</span>
                        <asp:TextBox ID="txtpwd" runat="server" TextMode="Password" placeholder="Enter password" CssClass="form-input"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span class="form-label">Admin Photo:</span>
                        <asp:FileUpload ID="FileUpload1" runat="server" style="font-size:13px;" />
                        <div style="font-size:12px; color:#7d5e4b; margin-top:3px;">Select photo (saved into Admin/Images/)</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-register" OnClick="btnRegister_Click" />
                    </td>
                </tr>
            </table>

            <div class="link-row">
                Already have an account? 
                <a href="Admin_Login.aspx">Sign In Here &rarr;</a>
            </div>

            <a href="../Default.aspx" class="back-link">&larr; Return to Customer Storefront</a>
        </div>
    </form>
</body>
</html>
