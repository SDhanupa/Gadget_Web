<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" 
    CodeBehind="Cart.aspx.cs" Inherits="Gadgetweb.Cart" UnobtrusiveValidationMode="None" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>My Shopping Cart - TechNest</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet" />

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        /* Reset and Base */
        *, *::before, *::after {
            box-sizing: border-box;
        }
        body {
            margin: 0;
            padding-top: 75px; /* room for navbar */
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(130deg, #edf2f7, #d9e2ec);
            color: #1e293b;
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            user-select: none;
        }

        /* Heading */
        h1 {
            text-align: center;
            font-weight: 600;
            font-size: 3rem;
            color: #334e68;
            margin-bottom: 2.5rem;
            user-select: text;
        }

        /* Cart container */
        #cartContainer {
            max-width: 1080px;
            margin: 0 auto 4rem auto;
            background: white;
            border-radius: 14px;
            box-shadow: 0 10px 30px rgb(51 78 104 / 0.1);
            padding: 2.5rem 2rem;
        }

        /* Table */
        table.cart-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 14px;
        }

        table.cart-table thead tr {
            background: #e0e7f4;
        }
        table.cart-table thead th {
            text-align: left;
            font-weight: 600;
            font-size: 1rem;
            color: #334e68;
            padding: 16px 20px;
            user-select: none;
        }
        table.cart-table tbody tr {
            background: #f8fafc;
            border-radius: 12px;
            transition: background-color 0.3s ease;
        }
        table.cart-table tbody tr:hover,
        table.cart-table tbody tr:focus-within {
            background: #dbeafe;
        }
        table.cart-table tbody td {
            padding: 16px 20px;
            vertical-align: middle;
            color: #475569;
            font-size: 0.95rem;
            user-select: text;
        }

        /* Product image */
        .cart-image {
            width: 80px;
            height: 80px;
            border-radius: 12px;
            object-fit: cover;
            box-shadow: 0 2px 6px rgba(102, 126, 234, 0.3);
            user-select: none;
        }

        /* Quantity center */
        .qty-col {
            text-align: center;
            font-weight: 600;
        }

        /* Price/ subtotal */
        .price-col {
            font-weight: 700;
            text-align: right;
            min-width: 140px;
            color: #1e293b;
        }

        /* Actions */
        .actions-col {
            text-align: center;
            white-space: nowrap;
        }

        /* Buttons */
        .btn-remove,
        .btn-buy-now,
        .btn-buy-all {
            font-weight: 600;
            border-radius: 25px;
            border: none;
            padding: 9px 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            user-select: none;
            font-size: 0.95rem;
            box-shadow: 0 4px 12px rgb(56 189 248 / 0.3);
        }

        .btn-remove {
            background: #fee2e2;
            color: #b91c1c;
            margin-right: 10px;
            box-shadow: 0 4px 12px rgb(185 28 28 / 0.30);
        }

        .btn-remove:hover,
        .btn-remove:focus {
            background: #fca5a5;
            box-shadow: 0 6px 18px rgb(185 28 28 / 0.6);
            outline: none;
        }

        .btn-buy-now {
            background: #bae6fd;
            color: #0369a1;
        }

        .btn-buy-now:hover,
        .btn-buy-now:focus {
            background: #0ea5e9;
            color: #e0f2fe;
            box-shadow: 0 6px 18px rgb(14 165 233 / 0.75);
            outline: none;
        }

        /* Buy all */
        .btn-buy-all {
            display: block;
            width: fit-content;
            margin: 3rem auto 0;
            background: #2563eb;
            color: white;
            font-size: 1.25rem;
            padding: 14px 48px;
            box-shadow: 0 8px 28px rgba(37, 99, 235, 0.7);
            text-transform: uppercase;
            letter-spacing: 1.2px;
        }
        .btn-buy-all:hover,
        .btn-buy-all:focus {
            background: #1e40af;
            box-shadow: 0 10px 32px rgba(30, 64, 175, 0.9);
            outline: none;
        }

        /* Total Price */
        #totalPrice {
            margin-top: 1.5rem;
            font-weight: 700;
            font-size: 1.5rem;
            color: #1e293b;
            text-align: right;
            user-select: none;
        }

        /* Empty Cart */
        #emptyCartMsg {
            text-align: center;
            color: #475569;
            font-size: 1.3rem;
            margin-top: 10rem;
            user-select: text;
        }
        #emptyCartMsg a {
            color: #3b82f6;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        #emptyCartMsg a:hover,
        #emptyCartMsg a:focus {
            color: #1d4ed8;
            text-decoration: underline;
            outline: none;
        }

        /* Responsive */
        @media (max-width: 900px) {
            table.cart-table thead {
                display: none;
            }
            table.cart-table tbody tr {
                display: grid;
                grid-template-columns: 1fr 1fr;
                grid-template-rows: repeat(6, auto);
                gap: 6px 20px;
            }
            table.cart-table tbody td {
                padding: 6px 10px;
                display: flex;
                align-items: center;
            }
            table.cart-table tbody td:nth-child(1) {
                grid-row: 1 / span 2;
                justify-content: center;
            }
            table.cart-table tbody td:nth-child(2) {
                grid-row: 1;
                font-weight: 700;
                font-size: 1.1rem;
                color: #1e293b;
                padding-left: 0;
            }
            table.cart-table tbody td:nth-child(3) {
                grid-row: 2;
                font-style: italic;
                color: #64748b;
                padding-left: 0;
            }
            table.cart-table tbody td:nth-child(4),
            table.cart-table tbody td:nth-child(6) {
                justify-content: flex-start;
                font-weight: 600;
                font-size: 1rem;
            }
            table.cart-table tbody td:nth-child(5),
            table.cart-table tbody td:nth-child(7) {
                justify-content: flex-start;
                padding-left: 0;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="cartContainer" role="main" aria-label="Shopping Cart">
        <h1>Your Shopping Cart</h1>

        <asp:Panel ID="pnlCart" runat="server" Visible="false">
            <table class="cart-table" role="table" aria-describedby="totalPrice">
                <thead>
                    <tr>
                        <th scope="col">Product Image</th>
                        <th scope="col">Product Name</th>
                        <th scope="col">Description</th>
                        <th scope="col" class="price-col">Unit Price (USD)</th>
                        <th scope="col" class="qty-col">Quantity</th>
                        <th scope="col" class="price-col">Subtotal (USD)</th>
                        <th scope="col" class="actions-col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptCartItems" runat="server" OnItemCommand="rptCartItems_ItemCommand">
                        <ItemTemplate>
                            <tr tabindex="0" aria-label='<%# Eval("ProductName") + " with quantity " + Eval("Quantity") %>'>
                                <td><img src='<%# Eval("ImageUrl") %>' alt='<%# Eval("ProductName") %> image' class="cart-image" loading="lazy" /></td>
                                <td><%# Eval("ProductName") %></td>
                                <td><%# Eval("Description") %></td>
                                <td class="price-col">$<%# Eval("Price", "{0:F2}") %></td>
                                <td class="qty-col"><%# Eval("Quantity") %></td>
                                <td class="price-col">$<%# Eval("Subtotal", "{0:F2}") %></td>
                                <td class="actions-col">
                                    <asp:Button ID="btnRemove" runat="server" Text="Remove" CommandName="RemoveItem" CommandArgument='<%# Eval("Id") %>' CssClass="btn-remove" aria-label="Remove this item" />
                                    <asp:Button ID="btnBuyNow" runat="server" Text="Buy Now" CommandName="BuyItem" CommandArgument='<%# Eval("Id") %>' CssClass="btn-buy-now" aria-label="Buy this item now" />
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </tbody>
            </table>

            <div id="totalPrice" role="contentinfo" aria-live="polite" aria-atomic="true">
                Total Price: $<asp:Label ID="lblTotalPrice" runat="server" Text="0.00" />
            </div>

            <asp:Button ID="btnBuyAll" runat="server" Text="Buy All" CssClass="btn-buy-all" OnClick="btnBuyAll_Click" aria-label="Buy all items in cart" />
        </asp:Panel>

        <asp:Panel ID="pnlEmptyCart" runat="server" Visible="false" aria-live="polite" aria-atomic="true" CssClass="empty-cart-message" role="alert">
            Your cart is empty. <a href="items.aspx" tabindex="0">Continue shopping</a>.
        </asp:Panel>
    </div>

</asp:Content>
