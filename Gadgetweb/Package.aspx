<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Package.aspx.cs" Inherits="GadgetWeb.Package" MasterPageFile="~/Site1.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
  <title>Project Tracking Dashboard - Gadget Hub</title>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Montserrat:wght@700&display=swap" rel="stylesheet" />

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>
    body, html {
      margin: 0; padding: 0;
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
      color: #1e5e58;
      min-height: 100vh;
      user-select: text;
    }

    nav.navbar-custom {
      position: fixed;
      top: 0; left: 0; right: 0;
      height: 60px;
      background: rgba(255, 255, 255, 0.95);
      box-shadow: 0 4px 20px rgba(41, 130, 122, 0.18);
      display: flex;
      align-items: center;
      padding: 0 2rem;
      z-index: 1100;
      font-family: 'Montserrat', sans-serif;
    }

    nav.navbar-custom .navbar-brand {
      font-weight: 700;
      color: #1fa7b8;
      font-size: 1.6rem;
      cursor: pointer;
      user-select: text;
      text-transform: uppercase;
      transition: color 0.3s;
    }
    nav.navbar-custom .navbar-brand:hover,
    nav.navbar-custom .navbar-brand:focus {
      color: #16685f;
      outline: none;
      text-decoration: underline;
    }

    nav.navbar-custom .nav-links {
      margin-left: auto;
      display: flex;
      gap: 1.5rem;
      align-items: center;
    }
    nav.navbar-custom .nav-links a,
    nav.navbar-custom .nav-links button {
      color: #1e5e58;
      font-weight: 600;
      background: none;
      border: none;
      cursor: pointer;
      font-size: 1rem;
      padding: 0.3rem 0.8rem;
      border-radius: 8px;
      user-select: none;
      transition: background-color 0.25s, color 0.25s;
      text-decoration: none;
    }
    nav.navbar-custom .nav-links a.active,
    nav.navbar-custom .nav-links a:hover,
    nav.navbar-custom .nav-links a:focus,
    nav.navbar-custom .nav-links button:hover,
    nav.navbar-custom .nav-links button:focus {
      color: #fff;
      background: #1fa7b8;
      outline: none;
    }
    nav.navbar-custom .username-label {
      font-style: italic;
      white-space: nowrap;
      user-select: text;
      color: #24d490;
    }
    nav.navbar-custom .btn-logout {
      border: 1px solid transparent;
      transition: border-color 0.3s, background-color 0.3s;
    }
    nav.navbar-custom .btn-logout:hover,
    nav.navbar-custom .btn-logout:focus {
      background: #24d490cc;
      border-color: #1e5e58;
      outline: none;
      color: white;
    }

    .container-tracking {
      max-width: 960px;
      margin: 110px auto 3rem;
      padding: 1.5rem 2rem;
      user-select: text;
      background: rgba(255, 255, 255, 0.95);
      border-radius: 28px;
      box-shadow: 0 8px 36px rgba(36, 212, 144, 0.3);
      color: #166858;
      font-family: 'Georgia', serif;
    }

    h2.page-title {
      font-weight: 900;
      color: #24d490;
      text-align: center;
      font-size: 2.8rem;
      letter-spacing: 0.12em;
      margin-bottom: 3rem;
      text-shadow: 0 0 15px #16927d;
      user-select: text;
    }

    .order-card {
      background: #e6f8f3;
      border-radius: 20px;
      padding: 1.8rem 2rem;
      margin-bottom: 2.4rem;
      box-shadow: 0 6px 22px rgba(36, 212, 144, 0.24);
      border: 1px solid #1fa7b8aa;
      outline-offset: 2px;
      transition: box-shadow 0.3s ease;
    }
    .order-card:focus-within,
    .order-card:hover {
      box-shadow: 0 0 28px #24d490ee;
      border-color: #24d490dd;
      outline: none;
    }

    .order-header {
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      font-weight: 700;
      font-size: 1.25rem;
      color: #1fa7b8;
      margin-bottom: 1rem;
      gap: 0.6rem 1.2rem;
      user-select: text;
    }
    .order-header span {
      font-weight: 500;
      color: #4aa890;
      font-size: 1rem;
    }

    .items-list {
      border-left: 4px solid #24d490;
      padding-left: 1.6rem;
    }

    .item-entry {
      padding-bottom: 1.8rem;
      margin-bottom: 1.8rem;
      border-bottom: 1px solid #a3d8c6;
      outline-offset: 2px;
    }
    .item-entry:last-child {
      margin-bottom: 0;
      border-bottom: none;
      padding-bottom: 0;
    }

    .product-name {
      font-weight: 700;
      font-size: 1.22rem;
      color: #13836a;
      margin-bottom: 0.5rem;
      user-select: text;
    }
    .product-meta {
      font-size: 1rem;
      color: #3b9e85;
      margin-bottom: 0.7rem;
      user-select: text;
    }

    .btn-status {
      background-color: #24d490;
      color: #064b3b;
      border: none;
      padding: 0.52rem 1.2rem;
      font-weight: 700;
      border-radius: 10px;
      cursor: pointer;
      user-select: none;
      transition: background-color 0.3s;
    }
    .btn-status[disabled] {
      background-color: #9cd9c9;
      cursor: not-allowed;
      color: #385d55;
    }
    .btn-status:not([disabled]):hover,
    .btn-status:not([disabled]):focus {
      background-color: #1ab278;
      outline: none;
      color: white;
    }

    .tracker {
      display: flex;
      justify-content: space-between;
      margin-top: 1.3rem;
      user-select: none;
    }
    .tracker-step {
      flex: 1;
      text-align: center;
      position: relative;
      padding: 0 6px;
      user-select: none;
    }
    .tracker-step:not(:last-child)::after {
      content: "";
      position: absolute;
      top: 21px;
      right: 0;
      width: 100%;
      height: 4px;
      background: #24d490;
      border-radius: 2px;
      z-index: 0;
      transform: translateX(50%);
    }
    .circle {
      width: 38px;
      height: 38px;
      margin: 0 auto 6px;
      border-radius: 50%;
      border: 3px solid #24d490;
      background: #d8f3ea;
      color: #13836a;
      font-weight: 700;
      font-size: 1.3rem;
      line-height: 38px;
      position: relative;
      z-index: 1;
      transition: all 0.3s ease;
      user-select: none;
    }
    .circle.completed {
      background-color: #24d490;
      color: #fff;
      border-color: #178d66;
      box-shadow: 0 0 14px #24d490cc;
    }

    .tick {
      font-weight: 900;
      font-size: 1.5rem;
      color: #d1fae5;
      user-select: none;
    }

    .step-label {
      font-size: 0.9rem;
      font-weight: 600;
      color: #3b9e85;
      user-select: text;
      white-space: nowrap;
    }
    .step-label.current {
      color: #13836a;
      font-weight: 700;
    }

    /* Responsive */
    @media (max-width: 600px) {
      .order-header {
        flex-direction: column;
        font-size: 1.1rem;
      }
      nav.navbar-custom {
        height: 56px;
        padding: 0 1rem;
      }
      .container-tracking {
        margin: 90px 1rem 2rem;
        padding: 0 1rem;
      }
      .tracker-step:not(:last-child)::after {
        width: 70%;
        transform: translateX(35%);
      }
    }
  </style>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
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
          <li class="nav-item"><a class="nav-link active" href="Package.aspx" aria-current="page">Package Tracking</a></li>
          <li class="nav-item"><a class="nav-link" href="Tracker.aspx">Tracker</a></li>
          <li class="nav-item"><asp:LinkButton ID="lnkLogout" runat="server" CssClass="btn-logout" OnClick="lnkLogout_Click" aria-label="Logout">Logout</asp:LinkButton></li>
        </ul>
      </div>
    </div>
  </nav>

  <main class="container-tracking" role="main" aria-labelledby="pageTitle">
    <h2 id="pageTitle" class="page-title">Project Tracking Dashboard</h2>

    <asp:Repeater ID="rptOrders" runat="server" OnItemDataBound="rptOrders_ItemDataBound">
      <ItemTemplate>
        <section class="order-card" tabindex="0" aria-labelledby="orderLabel_<%# Eval("OrderId") %>">
          <header class="order-header" id="orderLabel_<%# Eval("OrderId") %>">
            <span>Order #: <strong><%# Eval("OrderId") %></strong></span>
            <span>Date: <%# Eval("OrderDate", "{0:yyyy-MM-dd HH:mm}") %></span>
            <span>Total: $<%# Eval("TotalPrice", "{0:N2}") %></span>
          </header>

          <div class="items-list" aria-label="Order items">
            <asp:Repeater ID="rptOrderItems" runat="server" OnItemDataBound="rptOrderItems_ItemDataBound" OnItemCommand="rptOrderItems_ItemCommand">
              <ItemTemplate>
                <article class="item-entry" role="group" aria-labelledby="productLabel_<%# Eval("OrderItemId") %>">
                  <h3 class="product-name" id="productLabel_<%# Eval("OrderItemId") %>"><%# Eval("ProductName") %></h3>
                  <p class="product-meta">Quantity: <%# Eval("Quantity") %>, Price: $<%# Eval("Price", "{0:N2}") %> each</p>

                  <asp:Button ID="btnChangeStatus" runat="server"
                    CommandName="ChangeStatus"
                    CommandArgument='<%# Eval("OrderItemId") + "|" + Eval("Status") %>'
                    CssClass="btn-status"
                    Text='<%# Eval("Status").ToString().ToUpper() == "DELIVERED" ? "Delivered" : "Next Status" %>'
                    Enabled='<%# Eval("Status").ToString().ToUpper() != "DELIVERED" %>'
                    aria-label='<%# "Change status for " + Eval("ProductName") %>' />

                  <div class="tracker" aria-label='<%# "Tracking progress for " + Eval("ProductName") %>'>
                    <asp:Literal ID="litTracker" runat="server" />
                  </div>
                </article>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </section>
      </ItemTemplate>
    </asp:Repeater>
  </main>

  <!-- Bootstrap JS Bundle -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
