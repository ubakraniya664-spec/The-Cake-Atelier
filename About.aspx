<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="The_Cake_Atelier.About" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>About Us - The Cake Atelier</title>
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
                        <asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="About.aspx" CssClass="active">About Us</asp:HyperLink>
                        <asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="Contact.aspx">Contact</asp:HyperLink>
                        <asp:HyperLink ID="lnkCart" runat="server" NavigateUrl="Cart.aspx">Cart</asp:HyperLink>

                        <!-- Dynamic Authentication Links -->
                        <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="login.aspx">Login</asp:HyperLink>
                        <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="register.aspx">Register</asp:HyperLink>
                        <asp:HyperLink ID="lnkDashboard" runat="server" NavigateUrl="User_Dashboard.aspx" Visible="false">Dashboard</asp:HyperLink>
                        <asp:Label ID="lblUserGreeting" runat="server" CssClass="user-greeting" Visible="false"></asp:Label>
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="asp-nav-btn" Visible="false">Logout</asp:LinkButton>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Main Content Area -->
        <div class="main-container">

            <h1 class="section-heading">Our Sweet Story</h1>
            <div class="section-subheading">Crafting unforgettable celebration memories, one handcrafted slice at a time</div>

            <!-- Story Section with Chef Image -->
            <table class="about-story-table">
                <tr>
                    <td class="about-story-text">
                        <h2>Welcome to The Cake Atelier</h2>
                        <p>
                            Founded in 2018 from a passionate workshop kitchen, <strong>The Cake Atelier</strong> was established with a singular mission: 
                            to elevate everyday gatherings and once-in-a-lifetime milestones into sweet culinary works of art.
                        </p>
                        <p>
                            We believe that true baking excellence cannot be rushed with commercial pre-mixes or chemical preservatives. 
                            Every sponge, berry reduction, and velvety chocolate ganache is prepared from scratch every morning by our dedicated 
                            team of passionate pastry artisans.
                        </p>
                        <p>
                            Whether it is a child's milestone 1st birthday, an elegant wedding anniversary, or simply an evening chocolate craving, 
                            our bakery ovens are fired warm to ensure you experience authentic bakery bliss.
                        </p>
                        <br />
                        <asp:HyperLink ID="btnBrowseMenu" runat="server" NavigateUrl="Cakes.aspx" CssClass="btn-primary">Browse Our Cake Collection &rarr;</asp:HyperLink>
                    </td>
                    <td class="about-img-box">
                        <img src="Admin/images/chef.jpg" alt="Master Pastry Chef Decorating Cake" />
                        <div style="font-size:12px; color:#8c6d58; margin-top:8px;">Executive Chef Claire hand-piping a 3-tier floral celebration cake</div>
                    </td>
                </tr>
            </table>

            <!-- Our Core Values -->
            <h2 class="section-heading">Our Core Baking Values</h2>
            <div class="section-subheading">The golden standards that define every confection we create</div>

            <table class="values-table">
                <tr>
                    <td class="value-card">
                        <span class="value-icon">&#129372;</span>
                        <div class="value-title">Pure Dairy Butter</div>
                        <div class="value-desc">We strictly use 100% farm-fresh dairy butter and pure cream. Never hydrogenated fats or margarine.</div>
                    </td>
                    <td class="value-card">
                        <span class="value-icon">&#127851;</span>
                        <div class="value-title">Belgian Couverture</div>
                        <div class="value-desc">Our chocolates are authentic Belgian single-origin cocoa, resulting in deep, decadent truffle flavor.</div>
                    </td>
                    <td class="value-card">
                        <span class="value-icon">&#127793;</span>
                        <div class="value-title">Certified Eggless Station</div>
                        <div class="value-desc">Dedicated certified eggless baking ovens guarantee zero cross-contamination for vegetarian patrons.</div>
                    </td>
                    <td class="value-card">
                        <span class="value-icon">&#128666;</span>
                        <div class="value-title">Pristine Delivery</div>
                        <div class="value-desc">Specialized refrigerated carriers and heavy-duty cake boards ensure every tier arrives intact.</div>
                    </td>
                </tr>
            </table>

            <!-- Meet Our Master Bakers -->
            <h2 class="section-heading">Meet Our Master Pastry Artisans</h2>
            <div class="section-subheading">The passionate hands and creative minds behind your favorite cakes</div>

            <table class="team-table">
                <tr>
                    <td class="team-card">
                        <div style="font-size:42px;">&#129489;&#8205;&#127859;</div>
                        <div class="team-name">Chef Claire Bennett</div>
                        <div class="team-role">Founder &amp; Executive Pastry Chef</div>
                        <div class="team-bio">Trained at European patisserie academies, Chef Claire brings 12+ years of classic French pastry technique and boundless creative vision.</div>
                    </td>
                    <td class="team-card">
                        <div style="font-size:42px;">&#129489;&#8205;&#127912;</div>
                        <div class="team-name">Chef Rahul Mehta</div>
                        <div class="team-role">Head Cake Sculptor &amp; Artist</div>
                        <div class="team-bio">Specialist in sugar-flower sculpting, hand-painted fondant murals, and architectural multi-tiered wedding showstoppers.</div>
                    </td>
                    <td class="team-card">
                        <div style="font-size:42px;">&#129489;&#8205;&#129382;</div>
                        <div class="team-name">Chef Sophie Laurent</div>
                        <div class="team-role">Flavor Specialist &amp; Cupcake Baker</div>
                        <div class="team-bio">Crafts our seasonal fruit compotes, delicate mousses, and signature melt-in-mouth buttercream frosting recipes.</div>
                    </td>
                </tr>
            </table>

            <!-- Store & Workshop Location Info -->
            <table class="info-table">
                <tr>
                    <td class="info-cell">
                        <span class="info-title">&#128205; Visit Our Showroom</span>
                        <span class="info-desc">124 Confectionery Lane, Sweetville, Landmark: Near Floral Fountain Plaza</span>
                    </td>
                    <td class="info-cell">
                        <span class="info-title">&#9200; Visiting &amp; Tasting Hours</span>
                        <span class="info-desc">Mon - Sat: 8:30 AM to 10:30 PM | Sun: 9:00 AM to 11:00 PM</span>
                    </td>
                    <td class="info-cell">
                        <span class="info-title">&#9742; Call or Book Tasting</span>
                        <span class="info-desc">+91 98765 43210 / +91 98765 43211 | tasting@thecakeatelier.com</span>
                    </td>
                </tr>
            </table>

        </div>

        <!-- Footer Section -->
        <div class="footer-container">
            <table class="footer-table">
                <tr>
                    <td class="footer-col">
                        <h3>The Cake Atelier</h3>
                        <p>Artisanal bakery and pâtisserie dedicated to making every celebration extraordinary with freshly baked, premium cakes.</p>
                        <p style="color:#d4a373;">&#9742; Phone: +91 98765 43210</p>
                        <p style="color:#d4a373;">&#9993; Email: orders@thecakeatelier.com</p>
                    </td>
                    <td class="footer-col">
                        <h3>Quick Links</h3>
                        <a href="Default.aspx">Home</a>
                        <a href="Cakes.aspx">All Cakes &amp; Pastries</a>
                        <a href="About.aspx">About Our Bakery</a>
                        <a href="Cart.aspx">My Shopping Cart</a>
                        <a href="Contact.aspx">Contact &amp; Custom Orders</a>
                    </td>
                    <td class="footer-col">
                        <h3>Member Portal</h3>
                        <a href="login.aspx">Customer Login</a>
                        <a href="register.aspx">Register New Account</a>
                        <a href="Cart.aspx">Checkout &amp; Track Order</a>
                        <a href="Contact.aspx">Franchise Inquiries</a>
                    </td>
                    <td class="footer-col">
                        <h3>Bakery Hours</h3>
                        <p><strong>Monday - Saturday:</strong><br />8:30 AM &ndash; 10:30 PM</p>
                        <p><strong>Sunday:</strong><br />9:00 AM &ndash; 11:00 PM</p>
                        <p><strong>Store Address:</strong><br />124 Confectionery Lane, Sweetville</p>
                    </td>
                </tr>
            </table>

            <div class="footer-bottom">
                &copy; 2026 The Cake Atelier. All Rights Reserved. | College ASP.NET Web Forms Project.
            </div>
        </div>

    </form>
</body>
</html>
