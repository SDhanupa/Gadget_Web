<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" 
    CodeBehind="items.aspx.cs" Inherits="Gadgetweb.items" UnobtrusiveValidationMode="None" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Explore Gadgets - Gadget Hub</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;700&display=swap" rel="stylesheet" />
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        /* ==== BASE RESET & GLOBALS ==== */
        *, *::before, *::after { box-sizing: border-box; }
        body {
            margin: 0;
            padding-top: 76px;
            background: linear-gradient(120deg,#e1f6f9 0,#f0f7f4 100%);
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            color: #263143;
            min-height: 100vh;
        }
        a, button { user-select: auto; }

        /* ===== NAVBAR ===== */
        nav.navbar-custom {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 76px;
            background: rgba(255,255,255,0.96);
            box-shadow: 0 2px 20px #17c1cf18;
            display: flex;
            align-items: center;
            z-index: 1050;
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
        }
        nav.navbar-custom .brand {
            font-size: 2rem;
            color: #23c7bb;
            font-weight: 900;
            letter-spacing: 0.07em;
            margin-left: 3vw;
            text-transform: uppercase;
            cursor: pointer;
            user-select: none;
            transition: color 0.3s;
            text-shadow: 0 2px 7px #12cab38f;
        }
        nav.navbar-custom .brand:hover,
        nav.navbar-custom .brand:focus {
            color: #106e68;
            outline: none;
        }
        nav.navbar-custom .nav-links {
            list-style: none;
            display: flex;
            gap: 2.4rem;
            margin: 0 3vw 0 auto;
            padding: 0;
        }
        nav.navbar-custom .nav-links li {
            display: flex;
            align-items: center;
        }
        nav.navbar-custom .nav-links a {
            color: #22585e;
            font-weight: 700;
            font-size: 1.04rem;
            padding: 6px 16px;
            border-radius: 7px;
            transition: background 0.18s, color 0.18s;
            text-decoration: none;
        }
        nav.navbar-custom .nav-links a.active, 
        nav.navbar-custom .nav-links a:hover, 
        nav.navbar-custom .nav-links a:focus {
            background: linear-gradient(90deg, #1fa7b8 80%, #38efb2 100%);
            color: #fff;
            outline: none;
        }
        /* User Info & Logout */
        .user-info {
            color: #1fa7b8;
            font-weight: 700;
            font-size: 1rem;
        }
        .btn-logout {
            background: none;
            border: none;
            color: #1fa7b8;
            text-transform: uppercase;
            font-size: 0.98rem;
            font-weight: 700;
            padding: 4px 13px;
            border-radius: 8px;
            transition: background 0.2s;
        }
        .btn-logout:hover, .btn-logout:focus {
            background: #b5f6e7;
            color: #043d3a;
            outline: none;
        }
        /* ==== Page Title ==== */
        .page-title {
            margin: 2.5rem auto 2.1rem auto;
            text-align: center;
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            font-weight: 900;
            font-size: 2.8rem;
            letter-spacing: 0.07rem;
            color: #189889;
            user-select: text;
            text-shadow: 0 4px 18px #39d2b357;
        }

        /* ==== Product Grid ==== */
        .products-container {
            width: 94vw;
            max-width: 1230px;
            margin: 0 auto 68px auto;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(270px,1fr));
            gap: 2.2rem;
        }
        .product-card {
            background: rgba(255,255,255, 0.96);
            border-radius: 22px;
            box-shadow: 0 18px 44px #21f5ec1a;
            display: flex;
            flex-direction: column;
            height: 100%;
            cursor: pointer;
            transition: box-shadow 0.28s, transform 0.2s;
            outline-offset: 3px;
        }
        .product-card:hover, .product-card:focus {
            box-shadow: 0 30px 62px #24d4902c;
            transform: translateY(-8px) scale(1.017);
            outline: none;
            z-index: 12;
        }
        .product-img {
            width: 100%;
            height: 184px;
            border-top-left-radius: 22px;
            border-top-right-radius: 22px;
            object-fit: cover;
            filter: saturate(1.11) brightness(0.98);
            user-select: none;
            background: #e3f6fb;
        }
        .product-info {
            padding: 1.5rem 1.45rem 2.1rem 1.45rem;
            display: flex;
            flex-direction: column;
            min-height: 190px;
        }
        .product-title {
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            font-weight: 800;
            font-size: 1.23rem;
            color: #1fa7b8;
            margin-bottom: .65rem;
            user-select: text;
        }
        .product-desc {
            flex-grow: 1;
            font-size: 1rem;
            color: #2f374b;
            margin-bottom: 1rem;
            line-height: 1.4;
            overflow: hidden;
            text-overflow: ellipsis;
            -webkit-line-clamp: 3;
            display: -webkit-box;
            -webkit-box-orient: vertical;
            user-select: text;
            white-space: break-spaces;
        }
        .product-price {
            font-weight: 700;
            font-size: 1.19rem;
            color: #1fe797;
            margin-bottom: 1.2rem;
        }

        .btn-add-to-cart {
            align-self: flex-end;
            background: linear-gradient(90deg, #1fa7b8 68%, #26e174 100%);
            color: #fff;
            border: none;
            padding: 11px 29px;
            border-radius: 30px;
            font-weight: 800;
            font-size: 1.09rem;
            box-shadow: 0 4px 18px #1fa7b842;
            cursor: pointer;
            transition: background 0.22s, box-shadow 0.27s, transform 0.16s;
        }
        .btn-add-to-cart:hover, .btn-add-to-cart:focus {
            background: linear-gradient(90deg, #025f67 48%, #2aeabb 100%);
            color: #fff;
            box-shadow: 0 10px 32px #21ff4033;
            outline: none;
            transform: translateY(-3px) scale(1.035);
        }

        /* ==== Floating Cart Summary ==== */
        #pnlCartSummary {
            position: fixed;
            bottom: 32px;
            right: 38px;
            background: linear-gradient(90deg, #1fa7b8 65%, #26e174 100%);
            color: #fff;
            padding: 18px 35px;
            border-radius: 45px;
            font-weight: 800;
            font-size: 1.17rem;
            box-shadow: 0 12px 44px #26dfb75a;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 15px;
            z-index: 1100;
            transition: background 0.28s, box-shadow 0.28s;
            outline-offset: 3px;
        }
        #pnlCartSummary:hover, #pnlCartSummary:focus {
            background: linear-gradient(90deg,#139cba 50%,#1fdcc3 100%);
            box-shadow: 0 21px 44px #1beaea79;
            outline: none;
        }
        #cartIcon { font-size: 1.83rem; }
        .cart-summary-label { color: #fff; font-weight: 600; font-size: 1.14rem; margin-left: 4px; }

        /* ==== ACCESSIBILITY ==== */
        .product-card:focus-visible,
        .btn-add-to-cart:focus-visible,
        #pnlCartSummary:focus-visible,
        .btn-logout:focus-visible,
        nav.navbar-custom .nav-links a:focus-visible {
            outline: 3px solid #56e4c6;
            outline-offset: 2.5px;
        }

        /* ==== RESPONSIVE ==== */
        @media (max-width: 1150px){
            .products-container {
                grid-template-columns: repeat(auto-fill, minmax(220px,1fr));
                gap: 1.4rem;
            }
            nav.navbar-custom .brand { margin-left: 1vw; }
            nav.navbar-custom .nav-links { margin-right: 1vw; }
        }
        @media (max-width: 768px){
            .page-title { font-size: 2.05rem;}
            .products-container { gap: 1rem; }
            .btn-add-to-cart { padding:10px 0; width:100%; }
            .product-info { padding: 1.15rem 0.7rem 1.4rem 0.7rem; }
            #pnlCartSummary { padding: 11px 19px; font-size: 1rem; right: 12px; bottom: 14px;}
        }
        @media (max-width: 550px){
            nav.navbar-custom, nav.navbar-custom .brand{
                font-size:1.3rem; padding:10px 6px; height: auto;
            }
            .page-title { font-size: 1.3rem; }
            .products-container { grid-template-columns: 1fr; gap: 0.7rem; }
            .product-card { border-radius: 14px;}
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Navbar -->
    <nav class="navbar-custom" role="navigation" aria-label="Main Navigation">
        <div class="brand" tabindex="0" onclick="location.href='Home.aspx'" onkeypress="if(event.key==='Enter'){location.href='Home.aspx'}">Gadget Hub</div>
        <ul class="nav-links" role="menubar" aria-label="Main navigation">
            <li role="none"><a href="Home.aspx" role="menuitem">Home</a></li>
            <li role="none"><a href="items.aspx" class="active" role="menuitem" aria-current="page">Products</a></li>
            <asp:PlaceHolder ID="phUserLinks" runat="server" Visible="false">
                <li class="user-info" aria-label="Logged in user">
                    <span>Hello, <asp:Label ID="lblUsername" runat="server" /></span>
                </li>
                <li role="none"><a href="Cart.aspx" role="menuitem">My Cart</a></li>
                <li role="none">
                    <asp:LinkButton ID="lnkLogout" runat="server" CssClass="btn-logout" OnClick="lnkLogout_Click" aria-label="Logout">Logout</asp:LinkButton>
                </li>
            </asp:PlaceHolder>
            <asp:PlaceHolder ID="phGuestLinks" runat="server" Visible="true">
                <li role="none"><a href="Login.aspx" role="menuitem">Login</a></li>
                <li role="none"><a href="Register.aspx" role="menuitem">Register</a></li>
            </asp:PlaceHolder>
        </ul>
    </nav>

    <h1 class="page-title" tabindex="0">
        Explore Our Featured Gadgets
    </h1>

    <!-- Products Grid -->
    <asp:Repeater ID="rptProducts" runat="server">
        <HeaderTemplate>
            <section class="products-container" role="list">
        </HeaderTemplate>
        <ItemTemplate>
            <article class="product-card" tabindex="0" role="listitem button"
                onclick="location.href='itemDetails.aspx?productId=<%# Eval("Id") %>'"
                onkeypress="if(event.key==='Enter'||event.key===' '){location.href='itemDetails.aspx?productId=<%# Eval("Id") %>'}"
                aria-label='<%# Eval("ProductName") + " product card" %>'>
                <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %> image' class="product-img" loading="lazy" />
                <div class="product-info">
                    <h2 class="product-title"><%# Eval("ProductName") %></h2>
                    <p class="product-desc"><%# Eval("Description") %></p>
                    <p class="product-price">$<%# Eval("Price", "{0:F2}") %></p>
                    <asp:Button ID="btnAddToCart" runat="server" Text="Add to Cart" CssClass="btn-add-to-cart"
                        CommandArgument='<%# Eval("Id") %>' OnClick="btnAddToCart_Click" />
                </div>
            </article>
        </ItemTemplate>
        <FooterTemplate>
            </section>
        </FooterTemplate>
    </asp:Repeater>

    <!-- Cart Summary Button -->
    <asp:Panel ID="pnlCartSummary" runat="server" Visible="false" tabindex="0" role="button" aria-label="View cart summary" OnClick="pnlCartSummary_Click">
        <span id="cartIcon" aria-hidden="true">&#128722;</span>
        <asp:Label ID="lblCartSummary" runat="server" CssClass="cart-summary-label" />
    </asp:Panel>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
