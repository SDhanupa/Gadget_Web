<%@ Page Title="Manage Products - Gadget Hub Seller" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true" CodeBehind="Manage.aspx.cs" Inherits="GadgetWeb.Manage" UnobtrusiveValidationMode="None" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <title>Manage Products - Gadget Hub Seller</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&family=Georgia&display=swap" rel="stylesheet" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        *, *::before, *::after { box-sizing: border-box; }

        body {
            margin: 0;
            background: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
            font-family: 'Georgia', serif;
            color: #1e5e58;
            user-select: text;
            min-height: 100vh;
        }

        nav.seller-nav {
            background: rgba(255, 255, 255, 0.92);
            backdrop-filter: blur(12px);
            box-shadow: 0 4px 24px rgb(30 94 88 / 0.19);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 1200;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-family: 'Georgia', serif;
        }

        nav.seller-nav .brand {
            font-weight: 900;
            font-size: 2rem;
            color: #1fa7b8;
            letter-spacing: 0.12em;
            user-select: text;
            cursor: pointer;
            text-transform: uppercase;
            transition: color 0.3s;
        }

        nav.seller-nav .brand:hover,
        nav.seller-nav .brand:focus {
            color: #16685f;
            outline: none;
            text-decoration: underline;
        }

        nav.seller-nav ul.nav-links {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 2rem;
            align-items: center;
            white-space: nowrap;
        }

        nav.seller-nav ul.nav-links li {
            font-weight: 700;
            user-select: text;
        }

        nav.seller-nav ul.nav-links li a,
        nav.seller-nav ul.nav-links li button {
            font-size: 1rem;
            background: none;
            color: #13645b;
            border: none;
            cursor: pointer;
            padding: 0.4em 0.8em;
            border-radius: 12px;
            transition: background-color 0.25s, color 0.25s;
            text-decoration: none;
        }

        nav.seller-nav ul.nav-links li a.active,
        nav.seller-nav ul.nav-links li a:hover,
        nav.seller-nav ul.nav-links li a:focus,
        nav.seller-nav ul.nav-links li button:hover,
        nav.seller-nav ul.nav-links li button:focus {
            background-color: #1fa7b8;
            color: #fff;
            outline: none;
            text-decoration: none;
        }

        nav.seller-nav ul.nav-links li .username-label {
            color: #3fade3;
            font-style: italic;
        }

        section.main-content {
            max-width: 1024px;
            margin: 110px auto 3rem;
            padding: 2.5rem 3rem;
            background: rgba(247, 251, 250, 0.9);
            border-radius: 32px;
            box-shadow: 0 10px 40px rgb(30 94 88 / 0.12);
            color: #125449;
            user-select: text;
            font-family: 'Georgia', serif;
        }

        h2.section-title {
            font-weight: 900;
            font-size: 2.7rem;
            letter-spacing: 0.08em;
            text-align: center;
            margin-bottom: 2.6rem;
            color: #17a092;
            text-shadow: 0 0 15px #1fa7b85;
            user-select: text;
        }

        .feedback-message {
            border-radius: 20px;
            padding: 1.1rem 1.5rem;
            margin-bottom: 2rem;
            font-weight: 700;
            font-size: 1.03rem;
            box-shadow: 0 0 28px #1fa7b888;
            display: none;
        }

        .alert-success {
            background: #daf5ee;
            border: 1.5px solid #24d490cc;
            color: #1a674f;
        }

        .alert-danger {
            background: #f8d7da;
            border: 1.5px solid #e16070cc;
            color: #82292d;
        }

        .show-feedback {
            display: block !important;
        }

        ul.nav-tabs {
            border-bottom: 3px solid #17a092;
            margin-bottom: 2.8rem;
        }

        ul.nav-tabs li {
            margin-right: 1.2rem;
        }

        ul.nav-tabs li button {
            font-weight: 800;
            cursor: pointer;
            font-size: 1.22rem;
            padding: 11px 28px;
            border-radius: 28px 28px 0 0;
            border: none;
            background: transparent;
            color: #17a092;
            transition: background-color 0.3s ease;
        }

        ul.nav-tabs li button.active {
            background-color: #17a092cc;
            color: #e6f9f7;
            box-shadow: inset 0 -5px 20px #24d490cc;
            cursor: default;
        }

        ul.nav-tabs li button:hover,
        ul.nav-tabs li button:focus {
            background-color: #14a084;
            color: #c0f0e7;
            outline: none;
        }

        .product-form label {
            display: block;
            font-weight: 700;
            font-size: 1.16rem;
            margin-bottom: 10px;
            user-select: text;
            color: #179989;
        }

        .product-form .form-control,
        .product-form .form-select {
            background-color: #e0f0ed;
            color: #125449;
            border: none;
            border-radius: 1.2rem;
            padding: 13px 18px;
            font-weight: 600;
            font-size: 1.05rem;
            box-shadow: inset 0 0 15px #1fa7b8aa;
            transition: box-shadow 0.3s;
            user-select: text;
        }

        .product-form .form-control:focus,
        .product-form .form-select:focus {
            outline: none;
            box-shadow: 0 0 20px #17a092cc;
            background-color: #cbf1e6;
            color: #0e443a;
        }

        .product-image-thumb {
            max-width: 140px;
            max-height: 140px;
            border-radius: 20px;
            display: block;
            margin-bottom: 18px;
            border: 4px solid #1fa7b8;
            box-shadow: 0 0 30px #29e3bd88;
        }

        .btn-save {
            background: linear-gradient(120deg, #1fa7b8 40%, #24d490 90%);
            color: #fff;
            font-weight: 800;
            font-size: 1.12rem;
            border-radius: 40px;
            padding: 13px 40px;
            width: 100%;
            box-shadow: 0 0 32px #24d490dd;
            border: none;
            transition: background 0.4s, box-shadow 0.45s;
            cursor: pointer;
            user-select: none;
        }

        .btn-save:hover,
        .btn-save:focus {
            background: linear-gradient(120deg,#13857e 20%,#1cd394 90%);
            box-shadow: 0 0 54px #1cd394cc;
            outline: none;
            transform: translateY(-3px) scale(1.03);
        }

        .btn-cancel {
            background: transparent;
            border: 2px solid #169285;
            color: #2ebeaf;
            font-weight: 700;
            border-radius: 36px;
            padding: 12px 34px;
            width: 100%;
            margin-top: 1.3rem;
            cursor: pointer;
            user-select: none;
            transition: background-color 0.3s, color 0.3s;
        }

        .btn-cancel:hover,
        .btn-cancel:focus {
            background-color: #15ab94;
            border-color: #0d6f64;
            color: #e0f9f5;
            outline: none;
        }

        .product-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 12px;
            border-radius: 32px;
            overflow: hidden;
            background: #def3f1;
            box-shadow: 0 0 36px #23cfb3b7;
            border: 1.8px solid #19c2aaaa;
            color: #0e4c45;
            font-weight: 700;
            user-select: text;
            min-width: 100%;
        }

        .product-table thead tr {
            background: #15a58f;
            color: #d0faf3;
        }

        .product-table thead th {
            padding: 18px 14px;
            font-size: 1.18rem;
            text-align: center;
            user-select: none;
        }

        .product-table tbody tr {
            background: #c5ebe9;
            transition: background 0.27s;
        }

        .product-table tbody tr:nth-child(odd) {
            background: #dbf4f2;
        }

        .product-table tbody tr:hover {
            background: #42d9becc;
            color: #08372f;
            cursor: pointer;
        }

        .product-table tbody td {
            padding: 14px 14px;
            vertical-align: middle;
            text-align: center;
            word-break: break-word;
        }

        .product-table tbody img {
            max-width: 90px;
            max-height: 90px;
            border-radius: 22px;
            border: 3px solid #14ae91;
            box-shadow: 0 0 26px #1ec1b180;
        }

        .btn-edit {
            background: linear-gradient(120deg, #17a092, #1cd394);
            padding: 7px 24px;
            border-radius: 28px;
            color: #043021;
            font-weight: 700;
            box-shadow: 0 0 22px #11c3a3cc;
            border: none;
            transition: background 0.3s;
        }

        .btn-edit:hover,
        .btn-edit:focus {
            background: linear-gradient(120deg, #14816f, #13b587);
            color: #e6fff9;
            outline: none;
        }

        .btn-delete {
            background: linear-gradient(120deg,#fa6c6c, #db3939);
            padding: 7px 24px;
            border-radius: 28px;
            color: #380303;
            font-weight: 700;
            box-shadow: 0 0 22px #f8474755;
            border: none;
            transition: background 0.3s;
        }

        .btn-delete:hover,
        .btn-delete:focus {
            background: linear-gradient(120deg, #cc2a2a, #900f0f);
            color: #ffdddd;
            outline: none;
        }

        @media (max-width: 720px) {
            section.main-content {
                padding: 1.8rem 1.4rem;
                margin: 120px 0 3rem;
                border-radius: 26px;
            }

            ul.nav-tabs {
                margin-bottom: 2rem;
                gap: 0.8rem;
            }

            ul.nav-tabs li button {
                font-size: 1rem;
                padding: 9px 22px;
            }

            .product-image-thumb {
                max-width: 110px;
                max-height: 110px;
            }

            .product-table thead th,
            .product-table tbody td {
                font-size: 1rem;
                padding: 10px 8px;
            }

            .btn-save, .btn-cancel, .btn-edit, .btn-delete {
                font-size: 1rem;
                padding: 10px 22px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <nav class="seller-nav" role="navigation" aria-label="Seller Management Navigation">
        <a href="Seller.aspx" class="brand" tabindex="0" onkeypress="if(event.key==='Enter')location.href='Seller.aspx'">Gadget Hub Seller</a>
        <ul class="nav-links" role="menubar">
            <li role="none"><span class="username-label" role="text">Hello, <asp:Label ID="lblUsername" runat="server" /></span></li>
            <li role="none"><a href="Sellerpage.aspx" role="menuitem">Dashboard</a></li>
            <li role="none"><a href="Manage.aspx" role="menuitem" aria-current="page" class="active">Manage Products</a></li>
            <li role="none"><a href="Package.aspx" role="menuitem">Package Tracking</a></li>
            <li role="none"><a href="Tracker.aspx" role="menuitem">Tracker</a></li>
            <li role="none">
                <asp:LinkButton ID="lnkLogout" runat="server" CssClass="nav-link" OnClick="lnkLogout_Click" role="menuitem">Logout</asp:LinkButton>
            </li>
        </ul>
    </nav>

    <section class="main-content" aria-label="Seller Product Management">
        <h2 class="section-title">Product Management</h2>

        <asp:Panel ID="pnlFeedback" runat="server" CssClass="feedback-message" role="alert" aria-live="assertive" Visible="false">
            <asp:Label ID="lblFeedback" runat="server" />
        </asp:Panel>

        <ul class="nav nav-tabs" id="manageTabs" role="tablist">
            <li role="presentation">
                <button class="nav-link active" id="tab-add" data-bs-toggle="tab" data-bs-target="#add" type="button" role="tab" aria-controls="add" aria-selected="true">Add / Edit</button>
            </li>
            <li role="presentation">
                <button class="nav-link" id="tab-list" data-bs-toggle="tab" data-bs-target="#list" type="button" role="tab" aria-controls="list" aria-selected="false">Manage</button>
            </li>
        </ul>

        <div class="tab-content" id="manageTabsContent">
            <div class="tab-pane fade show active" id="add" role="tabpanel" tabindex="0" aria-labelledby="tab-add">
                <div style="max-width:460px; margin: 1.6rem auto;">
                    <asp:HiddenField ID="hfProductId" runat="server" />

                    <div class="product-form">
                        <div class="mb-3">
                            <label for="txtName">Product Name <span aria-hidden="true" style="color:#d94f4f;">*</span></label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="200" />
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName" ErrorMessage="Product Name is required." ForeColor="#d94f4f" Display="Dynamic" SetFocusOnError="true" />
                        </div>

                        <div class="mb-3">
                            <label for="txtDescription">Description</label>
                            <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" MaxLength="300" Rows="4" />
                        </div>

                        <div class="mb-3">
                            <label for="txtPrice">Price ($) <span aria-hidden="true" style="color:#d94f4f;">*</span></label>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtPrice" ErrorMessage="Price is required." ForeColor="#d94f4f" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revPrice" runat="server" ControlToValidate="txtPrice" ValidationExpression="^\d+(\.\d{1,2})?$" ErrorMessage="Invalid price format." ForeColor="#d94f4f" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label for="txtQuantity">Quantity <span aria-hidden="true" style="color:#d94f4f;">*</span></label>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvQty" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Quantity is required." ForeColor="#d94f4f" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revQty" runat="server" ControlToValidate="txtQuantity" ValidationExpression="^\d+$" ErrorMessage="Quantity must be a whole number." ForeColor="#d94f4f" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label>Product Image</label><br />
                            <asp:Image ID="imgPreview" runat="server" CssClass="product-image-thumb" AlternateText="Product Image Preview" Visible="false" />
                            <asp:FileUpload ID="fuImage" runat="server" CssClass="form-control" />
                        </div>

                        <asp:Button ID="btnSave" runat="server" CssClass="btn-save" Text="Save" OnClick="btnSave_Click" />
                        <asp:Button ID="btnCancel" runat="server" CssClass="btn-cancel" Text="Cancel" OnClick="btnCancel_Click" CausesValidation="false" />
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="list" role="tabpanel" tabindex="0" aria-labelledby="tab-list">
                <div class="table-responsive" style="max-height: 620px;">
                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                        <HeaderTemplate>
                            <table class="product-table">
                                <thead>
                                    <tr>
                                        <th>Image</th>
                                        <th>Name</th>
                                        <th>Description</th>
                                        <th>Price ($)</th>
                                        <th>Quantity</th>
                                        <th style="min-width:140px;">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <img src='<%# Eval("ImageUrl") ?? "images/no-image.png" %>' alt="Product Image" />
                                </td>
                                <td><%# Eval("ProductName") %></td>
                                <td><%# Eval("Description") %></td>
                                <td><%# Eval("Price", "{0:F2}") %></td>
                                <td><%# Eval("Quantity") %></td>
                                <td>
                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" CommandName="EditProduct" CommandArgument='<%# Eval("Id") %>' CssClass="btn-edit" />
                                    <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteProduct" CommandArgument='<%# Eval("Id") %>' CssClass="btn-delete"
                                        OnClientClick="return confirm('Are you sure you want to delete this product?');" />
                                </td>
                            </tr>
                        </ItemTemplate>
                        <FooterTemplate>
                                </tbody>
                            </table>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        (function () {
            var feedback = document.querySelector('.feedback-message');
            if (feedback && feedback.classList.contains('show-feedback')) {
                feedback.style.display = 'block';
            }
        })();
    </script>
</asp:Content>
