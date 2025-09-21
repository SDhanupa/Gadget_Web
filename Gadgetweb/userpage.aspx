<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="userpage.aspx.cs" Inherits="Gadgetweb.userpage" MasterPageFile="~/Site1.Master" UnobtrusiveValidationMode="None" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Dashboard - Gadget Hub</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Georgia&display=swap" rel="stylesheet" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        *, *::before, *::after { box-sizing: border-box; }

        body {
            margin: 0;
            min-height: 100vh;
            background: linear-gradient(135deg, #bee6db 0%, #f0f7f4 100%);
            font-family: 'Georgia', serif;
            color: #1e5e58;
            line-height: 1.6;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            user-select: text;
        }

        a {
            text-decoration: none;
            color: #1fa7b8;
            transition: color 0.3s ease;
        }
        a:hover, a:focus {
            color: #16685f;
            outline: none;
        }

        nav.navbar-custom {
            position: fixed;
            width: 100%;
            top: 0;
            background: rgba(255, 255, 255, 0.95);
            padding: 0.6rem 2rem;
            box-shadow: 0 2px 16px rgba(30, 94, 88, 0.15);
            z-index: 1050;
            font-family: 'Georgia', serif;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 3px solid #24d490;
            color: #1e5e58;
        }

        nav.navbar-custom .brand-logo {
            color: #1fa7b8;
            font-size: 2.1rem;
            letter-spacing: 0.12em;
            user-select: none;
            cursor: pointer;
            font-weight: 900;
            text-transform: uppercase;
            transition: color 0.3s ease;
        }
        nav.navbar-custom .brand-logo:hover,
        nav.navbar-custom .brand-logo:focus {
            color: #16685f;
            outline: none;
            text-decoration: underline;
        }

        .navbar-nav-custom {
            list-style: none;
            display: flex;
            gap: 2rem;
            margin: 0;
            padding: 0;
            align-items: center;
            color: #24d490;
        }

        .navbar-nav-custom li a {
            color: #1e5e58;
            font-size: 1.1rem;
            padding: 0.4rem 0.8rem;
            border-radius: 8px;
            font-weight: 700;
            transition: background-color 0.3s ease, color 0.3s ease;
        }
        .navbar-nav-custom li a.active,
        .navbar-nav-custom li a:hover,
        .navbar-nav-custom li a:focus {
            background-color: #24d490;
            color: #ffffff;
            outline: none;
            font-weight: 900;
            text-decoration: none;
        }

        aside.sidebar {
            position: fixed;
            top: 60px;
            left: 0;
            width: 280px;
            height: calc(100vh - 60px);
            background: rgba(255, 255, 255, 0.85);
            backdrop-filter: blur(14px);
            box-shadow: 2px 0 20px rgba(36, 212, 144, 0.35);
            padding: 2rem 1.8rem;
            display: flex;
            flex-direction: column;
            gap: 1.8rem;
            z-index: 1020;
            border-radius: 0 24px 24px 0;
            font-family: 'Georgia', serif;
        }
        aside.sidebar nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        aside.sidebar nav ul li a {
            color: #16685f;
            font-weight: 700;
            font-size: 1.15rem;
            display: block;
            padding: 12px 20px;
            border-radius: 12px;
            transition: background-color 0.3s ease, color 0.3s ease;
            user-select: text;
        }
        aside.sidebar nav ul li a:hover,
        aside.sidebar nav ul li a:focus,
        aside.sidebar nav ul li a.active {
            background-color: #24d490;
            color: white;
            outline: none;
            box-shadow: 0 0 12px #24d490cc;
            font-weight: 900;
        }

        main.content-area {
            margin-left: 300px;
            padding: 4rem 3rem 5rem 3rem;
            max-width: 720px;
            min-height: calc(100vh - 60px);
            background: rgba(255, 255, 255, 0.92);
            border-radius: 28px;
            box-shadow: 0 14px 48px rgba(36, 212, 144, 0.2);
            display: flex;
            flex-direction: column;
            align-items: center;
            user-select: text;
            font-family: 'Georgia', serif;
            color: #166858;
        }

        main.content-area h1 {
            font-weight: 900;
            font-size: 3.2rem;
            margin-bottom: 1rem;
            color: #1fa7b8;
            letter-spacing: 0.12em;
            text-align: center;
            width: 100%;
            user-select: text;
        }

        main.content-area p.welcome-msg {
            font-size: 1.3rem;
            font-weight: 600;
            margin-bottom: 3rem;
            color: #3b9e86;
            font-style: italic;
            text-align: center;
            max-width: 92%;
            user-select: text;
        }

        section.user-profile-card {
            background: #d4f4ec;
            padding: 3rem 3.5rem;
            border-radius: 28px;
            box-shadow: 0 12px 36px rgba(36, 212, 144, 0.4);
            width: 100%;
            max-width: 480px;
            text-align: center;
            color: #124d43;
            user-select: text;
            font-family: 'Georgia', serif;
        }

        section.user-profile-card h2 {
            font-weight: 800;
            font-size: 2.4rem;
            margin-bottom: 1rem;
            color: #16927c;
            user-select: text;
        }

        section.user-profile-card .user-details {
            font-size: 1.18rem;
            line-height: 1.7;
            margin-bottom: 1rem;
            user-select: text;
        }

        section.user-profile-card .user-details strong {
            color: #117758;
        }

        section.user-profile-card .logout-button {
            margin-top: 2.25rem;
            padding: 1.1rem 2.6rem;
            font-size: 1.3rem;
            font-weight: 800;
            background: linear-gradient(120deg, #24d490 15%, #16ab7d 100%);
            border: none;
            border-radius: 36px;
            color: white;
            cursor: pointer;
            box-shadow: 0 10px 38px #16ab7d99;
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
            user-select: none;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        section.user-profile-card .logout-button:hover,
        section.user-profile-card .logout-button:focus {
            background: linear-gradient(120deg, #16ab7d 15%, #0f7053 100%);
            box-shadow: 0 14px 48px #0f705399;
            outline: none;
        }

        /* Responsive */
        @media (max-width: 992px) {
            aside.sidebar {
                display: none;
            }
            main.content-area {
                margin: 100px auto 3rem auto;
                width: 90%;
                padding: 3rem 1.5rem 4rem 1.5rem;
                border-radius: 22px;
                box-shadow: 0 8px 28px rgba(36, 212, 144, 0.3);
            }
            section.user-profile-card {
                max-width: 100%;
                padding: 2.4rem 2rem;
                border-radius: 22px;
            }
            main.content-area h1 {
                font-size: 2.6rem;
            }
            section.user-profile-card h2 {
                font-size: 2.0rem;
            }
            section.user-profile-card .user-details {
                font-size: 1.05rem;
            }
            section.user-profile-card .logout-button {
                font-size: 1.1rem;
                padding: 1rem 2rem;
                min-width: 140px;
            }
        }

        @media (max-width: 576px) {
            main.content-area h1 {
                font-size: 2.3rem;
            }
            section.user-profile-card h2 {
                font-size: 1.7rem;
            }
            section.user-profile-card .user-details {
                font-size: 1rem;
            }
            section.user-profile-card .logout-button {
                font-size: 1rem;
                padding: 0.9rem 1.8rem;
                min-width: 120px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <nav class="navbar-custom" role="navigation" aria-label="Primary navigation">
        <a href="Default.aspx" class="brand-logo" tabindex="0">GADGET HUB</a>
        <ul class="navbar-nav-custom">
            <li><a href="userpage.aspx" class="active" aria-current="page" tabindex="0">Dashboard</a></li>
            <li><a href="items.aspx" tabindex="0">Products</a></li>
            <li><a href="Cart.aspx" tabindex="0">Orders</a></li>
            <li><a href="profile.aspx" tabindex="0">Profile</a></li>
        </ul>
    </nav>

    <aside class="sidebar" aria-label="Secondary navigation">
        <nav>
            <ul>
                <li><a href="userpage.aspx" class="active" aria-current="page">Dashboard</a></li>
                <li><a href="items.aspx">Browse Items</a></li>
                <li><a href="tracker.aspx">Track Packages</a></li>
                <li><a href="support.aspx">Support</a></li>
                <li><a href="logout.aspx">Logout</a></li>
            </ul>
        </nav>
    </aside>

    <main class="content-area">

        <h1 id="welcomeHeader" tabindex="0">
            Welcome Back,
            <%# Server.HtmlEncode(Session["Username"] != null ? Session["Username"].ToString() : "Gadget Enthusiast") %>
        </h1>
        <p class="welcome-msg" tabindex="0">Discover the latest gear and manage your orders easily in Gadget Hub.</p>

        <section class="user-profile-card" aria-labelledby="userProfileTitle" role="region">
            <h2 id="userProfileTitle">Your Profile Overview</h2>
            <p class="user-details">Username: <strong><asp:Label ID="lblUsername" runat="server" /></strong></p>
            <p class="user-details">Member since: <asp:Label ID="lblMemberSince" runat="server" /></p>
            <p class="user-details">Total Orders: <asp:Label ID="lblTotalOrders" runat="server" /></p>
            <asp:Button ID="btnLogout" runat="server" CssClass="logout-button" Text="Sign Out" OnClick="btnLogout_Click" aria-label="Sign out of your account" />
        </section>

    </main>

</asp:Content>
