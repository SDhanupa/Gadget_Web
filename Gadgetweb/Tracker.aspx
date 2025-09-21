<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Tracker.aspx.cs" Inherits="Gadgetweb.Tracker" UnobtrusiveValidationMode="None" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Track My Packages • Gadget Hub</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Georgia&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        :root {
            --main-bg-gradient: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
            --glass-bg: rgba(255, 255, 255, 0.85);
            --accent-primary: #1fa7b8;
            --accent-secondary: #24d490;
            --card-radius: 32px;
        }

        html, body {
            min-height: 100vh;
            margin: 0; padding: 0;
            font-family: 'Georgia', serif;
            background: var(--main-bg-gradient);
            color: #166858;
            user-select: text;
        }

        body {
            padding-top: 85px;
        }

        nav.navbar-custom {
            position: fixed;
            top: 0; left: 0; right: 0;
            height: 60px;
            background: var(--glass-bg);
            backdrop-filter: blur(14px);
            box-shadow: 0 4px 20px rgba(30, 94, 88, 0.15);
            display: flex;
            align-items: center;
            padding: 0 2rem;
            z-index: 1100;
            font-family: 'Inter', sans-serif;
        }

        nav.navbar-custom .navbar-brand {
            font-weight: 700;
            color: var(--accent-primary);
            font-size: 1.7rem;
            cursor: pointer;
            user-select: text;
            text-transform: uppercase;
            transition: color 0.3s ease;
        }

        nav.navbar-custom .navbar-brand:hover,
        nav.navbar-custom .navbar-brand:focus {
            color: var(--accent-secondary);
            outline: none;
            text-decoration: underline;
        }

        nav.navbar-custom .nav-links {
            margin-left: auto;
            display: flex;
            gap: 1.6rem;
            align-items: center;
        }

        nav.navbar-custom .nav-links a,
        nav.navbar-custom .nav-links button {
            color: var(--accent-primary);
            font-weight: 600;
            background: none;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            padding: 0.3rem 0.8rem;
            border-radius: 8px;
            user-select: none;
            text-decoration: none;
            transition: background-color 0.25s ease, color 0.25s ease;
        }

        nav.navbar-custom .nav-links a.active,
        nav.navbar-custom .nav-links a:hover,
        nav.navbar-custom .nav-links a:focus,
        nav.navbar-custom .nav-links button:hover,
        nav.navbar-custom .nav-links button:focus {
            color: white;
            background-color: var(--accent-primary);
            outline: none;
        }

        nav.navbar-custom .username-label {
            font-style: italic;
            white-space: nowrap;
            user-select: text;
            color: var(--accent-secondary);
        }

        nav.navbar-custom .btn-logout {
            border: 1px solid transparent;
            transition: border-color 0.3s ease, background-color 0.3s ease;
        }

        nav.navbar-custom .btn-logout:hover,
        nav.navbar-custom .btn-logout:focus {
            background-color: var(--accent-secondary);
            border-color: #13564a;
            outline: none;
            color: white;
        }

        .tracker-section {
            max-width: 1040px;
            margin: 0 auto 3rem auto;
            padding: 1rem 2vw;
            user-select: text;
        }

        h2.tracker-page-title {
            font-family: 'Georgia', serif;
            font-weight: 900;
            font-size: 2.8rem;
            color: var(--accent-primary);
            text-align: center;
            margin-bottom: 2.6rem;
            letter-spacing: 0.1em;
            text-shadow: 0 0 18px var(--accent-primary);
            user-select: text;
            line-height: 1.15;
        }

        .glass-card {
            background: var(--glass-bg);
            border-radius: var(--card-radius);
            box-shadow:
                0 10px 38px rgba(36, 212, 144, 0.25),
                0 3px 14px rgba(31, 164, 135, 0.3);
            padding: 2.2rem 2.4rem 2.6rem 2.4rem;
            margin-bottom: 3rem;
            border: 1.8px solid var(--accent-secondary);
            position: relative;
            user-select: text;
            transition: box-shadow 0.3s ease, border-color 0.3s ease;
        }

        .glass-card:hover,
        .glass-card:focus-within {
            box-shadow:
                0 0 50px var(--accent-secondary),
                0 5px 20px var(--accent-primary);
            border-color: var(--accent-primary);
            outline: none;
        }

        .order-header-wrap {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 1rem 1.5rem;
            margin-bottom: 1.6rem;
            font-weight: 700;
            color: var(--accent-primary);
            font-size: 1.3rem;
            user-select: text;
            padding: 0.85rem 1.4rem;
            background: linear-gradient(90deg, #d2f7f1 20%, #b0f0e5 85%);
            border-radius: 1.6em;
            border: 1.5px solid #a4eadf;
            box-shadow: 0 3px 14px #94d2ceaa inset;
        }

        .order-header-wrap span {
            color: #0e6353;
            font-weight: 600;
            font-size: 1.05rem;
        }

        .tracking-items-list {
            padding-left: 1.5rem;
            border-left: 4px solid var(--accent-secondary);
        }

        .tracking-product-block {
            margin-bottom: 2.2rem;
        }

        .tracking-product-title {
            font-weight: 700;
            font-size: 1.24rem;
            color: var(--accent-secondary);
            margin-bottom: 0.35em;
            user-select: text;
        }

        .tracking-meta {
            font-family: 'Georgia', serif;
            color: #346e63;
            font-weight: 600;
            font-size: 1rem;
            margin-bottom: 0.75em;
            letter-spacing: 0.03em;
            user-select: text;
        }

        .tracker-progress-bar {
            display: flex;
            align-items: center;
            gap: 0.3rem;
            margin-top: 0.5em;
            margin-bottom: 1.3em;
        }

        .step-dot {
            width: 38px;
            height: 38px;
            border-radius: 50%;
            border: 3px solid var(--accent-primary);
            background: #d4f4f0;
            color: var(--accent-primary);
            font-weight: 800;
            font-size: 1.22rem;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            box-shadow: 0 3px 16px var(--accent-secondary);
            user-select: none;
            transition: all 0.3s ease;
            outline-offset: 4px;
        }

        .step-dot.completed {
            background-color: var(--accent-primary);
            color: white;
            border-color: #139f8b;
            box-shadow: 0 0 18px var(--accent-primary);
        }

        .step-dot.active {
            background-color: #ffe274;
            color: #16141d;
            border-color: #facc15;
            box-shadow: 0 0 50px #ffdb5d;
            animation: pulse 1.2s infinite alternate;
        }

        @keyframes pulse {
          50% { box-shadow: 0 0 48px #fffde0cc; }
        }

        .step-label {
            color: #28796e;
            font-size: 0.87rem;
            font-weight: 600;
            text-align: center;
            margin-top: 0.3em;
            min-width: 72px;
            user-select: text;
            white-space: nowrap;
        }

        .step-label.active {
            color: #f3b94f;
            font-weight: 800;
            text-shadow: 0 0 7px #f3b94f9e;
        }

        .track-bar-sep {
            flex: 1;
            height: 5px;
            background: linear-gradient(90deg, #24d490 30%, #ffe274 100%);
            border-radius: 4px;
            opacity: 0.4;
        }

        .empty-orders-message {
            max-width: 600px;
            margin: 8rem auto 0;
            background: rgba(36, 212, 144, 0.14);
            padding: 2rem 2vw;
            border-radius: 28px;
            box-shadow: 0 4px 32px #24d49066;
            color: #24664b;
            font-size: 1.4rem;
            text-align: center;
            user-select: text;
        }
        .empty-orders-message a {
            color: var(--accent-secondary);
            font-weight: 700;
            text-decoration: underline;
            letter-spacing: 0.03em;
            transition: color 0.2s;
        }
        .empty-orders-message a:hover,
        .empty-orders-message a:focus {
            color: #f3b94f;
            text-decoration: none;
            outline: none;
        }

        /* Responsive adjustments */
        @media (max-width: 760px) {
            .tracker-section { padding: 0 1.5vw; }
            .glass-card { padding: 1.8rem 1.2rem; }
            .order-header-wrap { padding: 0.7rem 0.9rem; }
        }
        @media (max-width: 500px) {
            .glass-card { padding: 1.5rem 1rem; border-radius: 24px; }
            .order-header-wrap {
                gap: 0.3rem;
                padding: 0.7rem 0.75rem;
                flex-direction: column;
                align-items: flex-start;
            }
            .tracker-page-title { font-size: 2.2rem; }
            .tracking-product-title { font-size: 1rem; }
            .step-label { font-size: 0.79rem; min-width: 60px; }
            .step-dot { width: 34px; height: 34px; font-size: 1.1rem; }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar navbar-expand-md navbar-custom fixed-top" role="navigation" aria-label="Primary navigation">
        <div class="container">
            <a href="Seller.aspx" class="navbar-brand" tabindex="0">Gadget Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navMenu" aria-controls="navMenu" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navMenu">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item username-label" tabindex="0" aria-live="polite" aria-atomic="true">Hello, <asp:Label ID="lblUsername" runat="server" /></li>
                    <li class="nav-item"><a class="nav-link" href="Sellerpage.aspx">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="items.aspx">Manage Products</a></li>
                    <li class="nav-item"><a class="nav-link active" href="Tracker.aspx" aria-current="page">Tracker</a></li>
                    <li class="nav-item"><a class="nav-link" href="Package.aspx">Package Tracking</a></li>
                    <li class="nav-item"><asp:LinkButton ID="lnkLogout" runat="server" CssClass="btn-logout" OnClick="lnkLogout_Click" aria-label="Logout">Logout</asp:LinkButton></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="tracker-section" role="main">
        <h2 class="tracker-page-title" tabindex="0">Track My Packages</h2>

        <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
            <ItemTemplate>
                <section class="glass-card" tabindex="0" role="region" aria-label='<%# "Tracking for Order " + Eval("OrderId") %>'>
                    <div class="order-header-wrap">
                        <span class="order-label">Order #<%# Eval("OrderId") %></span>
                        <span class="order-meta"><%# Eval("OrderDate", "{0:yyyy-MM-dd HH:mm}") %></span>
                        <span class="order-total">Total: $<%# Eval("TotalPrice", "{0:N2}") %></span>
                    </div>

                    <div class="tracking-items-list">
                        <asp:Repeater ID="rptOrderItems" runat="server" OnItemDataBound="rptOrderItems_ItemDataBound">
                            <ItemTemplate>
                                <article class="tracking-product-block" role="group" aria-labelledby='<%# "productLabel" + Eval("ProductId") %>'>
                                    <h3 class="tracking-product-title" id='<%# "productLabel" + Eval("ProductId") %>'><%# Eval("ProductName") %></h3>
                                    <div class="tracking-meta">Qty: <%# Eval("Quantity") %> @ $<%# Eval("Price", "{0:N2}") %> each</div>
                                    <asp:Literal ID="litTrackerSteps" runat="server" />
                                </article>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </section>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlEmptyOrders" runat="server" Visible="false" CssClass="empty-orders-message">
            <span>No orders found yet.<br />Go ahead and <a href="items.aspx">shop our gadgets</a>!</span>
        </asp:Panel>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
