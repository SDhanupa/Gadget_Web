<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Seller.aspx.cs" Inherits="GadgetWeb.Seller" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <title>Seller Dashboard - Gadget Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        html, body {
            min-height: 100vh;
            margin: 0;
            background: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
            font-family: 'Georgia', serif;
            color: #134b46;
            user-select: text;
        }
        nav.navbar-custom {
            position: fixed;
            top: 0; left: 0; right: 0;
            background: rgba(255,255,255,0.97);
            box-shadow: 0 3px 22px rgba(41, 130, 122, 0.14);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1001;
        }
        nav.navbar-custom .navbar-brand {
            font-weight: 900;
            font-size: 2rem;
            color: #1fa7b8;
            letter-spacing: 0.12em;
            text-shadow: 0 2px 12px #1fa7b863;
            cursor: pointer;
            user-select: text;
            text-transform: uppercase;
        }
        nav.navbar-custom .navbar-brand:hover,
        nav.navbar-custom .navbar-brand:focus {
            color: #1e5e58;
            outline: none;
            text-decoration: underline;
        }
        nav.navbar-custom ul.navbar-nav {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 1.7rem;
            align-items: center;
        }
        nav.navbar-custom ul.navbar-nav li {
            font-weight: 700;
        }
        nav.navbar-custom ul.navbar-nav li a,
        nav.navbar-custom ul.navbar-nav li button {
            color: #187d72;
            background: none;
            border: none;
            font-size: 1rem;
            cursor: pointer;
            padding: 0.2rem 0.9rem;
            border-radius: 8px;
            transition: background-color 0.2s, color 0.22s;
            user-select: none;
        }
        nav.navbar-custom ul.navbar-nav li a.active,
        nav.navbar-custom ul.navbar-nav li a:hover,
        nav.navbar-custom ul.navbar-nav li a:focus,
        nav.navbar-custom ul.navbar-nav li button:hover,
        nav.navbar-custom ul.navbar-nav li button:focus {
            color: #fff;
            background: linear-gradient(90deg, #1fa7b8 65%, #24d490 100%);
            outline: none;
            text-decoration: none;
        }
        nav .user-label {
            color: #19a092;
            font-style: italic;
            user-select: text;
        }
        main {
            margin-top: 300px;
            max-width: 1170px;
            margin-left: auto;
            margin-right: auto;
            padding: 0 1rem;
        }
        h1.page-title {
            font-weight: 900;
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 2.4rem;
            color: #179989;
            letter-spacing: 0.13em;
            user-select: text;
            text-shadow: 0 0 14px #1fa7b841;
        }
        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px,1fr));
            gap: 2rem;
        }
        article.product-card {
            background: rgba(255,255,255,0.99);
            border-radius: 23px;
            box-shadow: 0 8px 30px #1799891f;
            display: flex;
            flex-direction: column;
            overflow: hidden;
            cursor: default;
            transition: box-shadow 0.28s, transform 0.16s;
            user-select: text;
        }
        article.product-card:hover,
        article.product-card:focus {
            box-shadow: 0 18px 46px #24d49045;
            transform: translateY(-7px) scale(1.015);
            outline: none;
            z-index: 2;
        }
        article.product-card img {
            width: 100%;
            height: 170px;
            object-fit: cover;
            background: #e1f6f9;
            user-select: none;
            pointer-events: none;
        }
        div.product-details {
            flex-grow: 1;
            padding: 1rem 1.3rem 1.5rem 1.3rem;
            display: flex;
            flex-direction: column;
        }
        h3.product-name {
            color: #24d490;
            margin: 0 0 0.5rem 0;
            font-weight: 800;
            font-size: 1.2rem;
            user-select: text;
        }
        p.product-description {
            flex-grow: 1;
            color: #208883;
            font-size: 1rem;
            margin: 0 0 1rem 0;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
            user-select: text;
        }
        p.product-meta {
            font-weight: 700;
            color: #29827a;
            font-size: 0.99rem;
            margin: 0 0 0.3rem 0;
            user-select: text;
        }
        p.product-price {
            font-weight: 900;
            font-size: 1.19rem;
            color: #17a092;
            user-select: text;
            text-shadow: 0 0 9px #17a0924d;
        }
        section#chart-container {
            margin-top: 3.5rem;
            background: rgba(255,255,255,0.98);
            border-radius: 22px;
            padding: 2.15rem 1.8rem;
            box-shadow: 0 4px 32px #20d49025;
            user-select: text;
        }
        section#chart-container h2 {
            color: #1fa7b8;
            font-weight: 900;
            font-size: 1.33rem;
            margin-bottom: 1.7rem;
            user-select: text;
            letter-spacing: 0.07em;
        }
        @media (max-width: 970px) {
            h1.page-title { font-size: 2rem; }
            article.product-card img {
                height: 135px;
            }
            h3.product-name { font-size: 1.08rem;}
            section#chart-container { padding:1.1rem 2vw;}
        }
        @media (max-width: 540px) {
            nav.navbar-custom { padding: 0.9rem 0.5rem; }
            .products-grid { grid-template-columns: 1fr; gap: 1.2rem;}
            .register-title, h1.page-title { font-size: 1.15rem;}
        }
    </style>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="navbar-custom" role="navigation" aria-label="Seller dashboard navigation">
        <a href="Seller.aspx" class="navbar-brand" tabindex="0" onkeypress="if(event.key==='Enter')location.href='Seller.aspx'">Gadget Hub Seller</a>
        <ul class="navbar-nav">
            <li class="user-label" aria-live="polite" aria-atomic="true">Hello, <asp:Label ID="lblUsername" runat="server" /></li>
            <li><a href="Manage.aspx" role="link">Manage Products</a></li>
            <li><a href="package.aspx" role="link">Orders</a></li>
            <li>
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-link nav-link" OnClick="Logout_Click" />
            </li>
        </ul>
    </nav>

    <main role="main">
        <h1 class="page-title" tabindex="0">Your Products Overview</h1>
        <asp:Repeater ID="rptProducts" runat="server" EnableViewState="false">
            <HeaderTemplate>
                <section class="products-grid" aria-label="List of seller products" role="list">
            </HeaderTemplate>
            <ItemTemplate>
                <article class="product-card" tabindex="0" role="listitem" aria-label='<%# "Product: " + Eval("ProductName") %>'>
                    <img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %>' loading="lazy" />
                    <div class="product-details">
                        <h3 class="product-name"><%# Eval("ProductName") %></h3>
                        <p class="product-description"><%# Eval("Description") %></p>
                        <p class="product-meta">Units sold: <%# Eval("TotalQuantitySold") %></p>
                        <p class="product-price">$<%# Eval("Price", "{0:N2}") %></p>
                        <p class="product-meta">Total sales: $<%# Eval("TotalSalesAmount", "{0:N2}") %></p>
                    </div>
                </article>
            </ItemTemplate>
            <FooterTemplate>
                </section>
            </FooterTemplate>
        </asp:Repeater>

        <section id="chart-container" aria-label="Sales trends chart" role="region" tabindex="0">
            <h2>Sales Trends</h2>
            <canvas id="salesChart" width="940" height="390" aria-describedby="chartDesc"></canvas>
            <p id="chartDesc" class="visually-hidden">Line chart showing product sales trends over time</p>
        </section>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        (function () {
            var ctx = document.getElementById('salesChart').getContext('2d');
            var labels = <%= SalesLabelsJson ?? "[]" %>;
            var data = <%= SalesDataJson ?? "[]" %>;
            if (labels.length > 0 && data.length > 0) {
                new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: 'Units Sold',
                            data: data,
                            backgroundColor: 'rgba(41,130,122,0.18)',
                            borderColor: 'rgba(30,94,88,1)',
                            borderWidth: 3,
                            tension: 0.4,
                            fill: true,
                            pointRadius: 6,
                            pointHoverRadius: 8,
                            pointBackgroundColor: 'rgba(30,94,88,1)',
                            pointBorderColor: '#fff',
                            pointHoverBorderColor: '#fff'
                        }]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                labels: { color: '#179989' }
                            },
                            tooltip: {
                                backgroundColor: '#1fa7b8',
                                titleColor: '#fff',
                                bodyColor: '#fff',
                            }
                        },
                        scales: {
                            x: {
                                ticks: { color: '#179989' },
                                grid: { display: false }
                            },
                            y: {
                                beginAtZero: true,
                                ticks: { color: '#179989', stepSize: 1 },
                                grid: {
                                    color: '#b3ede5',
                                    borderDash: [5]
                                },
                                title: {
                                    display: true,
                                    text: 'Units Sold',
                                    color: '#17a092',
                                    font: { weight: 'bold' }
                                }
                            }
                        },
                        interaction: { mode: 'nearest', intersect: false }
                    }
                });
            }
        })();
    </script>
</asp:Content>
