<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Pay.aspx.cs" Inherits="Gadgetweb.Pay" UnobtrusiveValidationMode="None" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Checkout - Gadget Hub</title>
    <!-- Fonts & Bootstrap -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Georgia&display=swap" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        html, body { height: 100%; min-height: 100vh; margin: 0; }
        body {
            font-family: 'Georgia', serif;
            background: linear-gradient(135deg, #bee6db 0%, #f0f7f4 100%);
            color: #1e5e58;
            -webkit-font-smoothing: antialiased;
            user-select: text;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 6rem 1.5rem 3rem 1.5rem;
        }
        .checkout-outer {
            background: rgba(255,255,255,0.95);
            box-shadow: 0 14px 46px rgba(36, 212, 144, 0.28);
            border-radius: 28px;
            max-width: 500px;
            width: 100%;
            padding: 3rem 3rem 2.8rem 3rem;
            display: flex;
            flex-direction: column;
            user-select: text;
            animation: fadeIn 0.7s ease forwards;
        }
        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(30px);}
            to {opacity: 1; transform: translateY(0);}
        }
        h1.checkout-title {
            font-family: 'Georgia', serif;
            color: #16ab7f;
            font-weight: 900;
            text-align: center;
            font-size: 2.8rem;
            margin-bottom: 1.5rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            text-shadow: 0 0 12px #24d490aa;
            user-select: text;
        }
        .order-summary-block {
            background: linear-gradient(91deg, #d1f0e9 0%, #a3dbc6 100%);
            border-radius: 18px;
            padding: 1.4rem 1.6rem 1.1rem 1.6rem;
            color: #0e473e;
            margin-bottom: 1.8rem;
            box-shadow: 0 3px 28px #16ab7f77;
            user-select: text;
        }
        .order-summary-block h2 {
            font-size: 1.25rem;
            font-weight: 700;
            text-transform: uppercase;
            color: #139779;
            font-family: 'Georgia', serif;
            margin-bottom: 0.8rem;
            letter-spacing: 0.06em;
        }
        .summary-items-list {
            font-size: 1.07rem;
            margin-bottom: 0.7rem;
            list-style: none;
            padding: 0;
        }
        .summary-items-list li {
            padding: 0.25rem 0;
            color: #0d3c32;
            display: flex;
            justify-content: space-between;
            user-select: text;
        }
        .checkout-total-line {
            font-size: 1.3rem;
            font-weight: 900;
            color: #13a275;
            display: flex;
            justify-content: space-between;
            border-top: 1.7px solid #82c8b6aa;
            padding-top: 0.5rem;
            margin-top: 0.8rem;
            user-select: text;
        }
        label.checkout-form-label {
            color: #168462;
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: 1.4rem;
            letter-spacing: 0.04em;
            font-family: 'Georgia', serif;
            user-select: text;
        }
        .checkout-form-input, .checkout-form-input:disabled {
            background: #c9ece4;
            border: 2px solid #13a275;
            border-radius: 1.6rem;
            padding: 1.1rem 1.2rem;
            margin-top: 0.4rem;
            color: #11553f;
            font-weight: 700;
            font-size: 1.1rem;
            font-family: 'Georgia', serif;
            box-shadow: inset 0 0 10px #16ab7fbb;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            user-select: text;
        }
        .checkout-form-input:focus {
            outline: none;
            background: #a3d6c4;
            border-color: #0f4f3d;
            box-shadow: 0 0 18px #0f4f3daa inset;
        }
        .checkout-form-input[readonly] {
            color: #255c4a;
            opacity: 1;
            font-style: italic;
        }
        .pay-btn {
            width: 100%;
            padding: 1.2rem 0;
            font-size: 1.35rem;
            border-radius: 2.4rem;
            border: none;
            font-weight: 900;
            background: linear-gradient(95deg, #24d490 18%, #16ab7d 100%);
            color: #072a1d;
            letter-spacing: 0.1em;
            box-shadow: 0 6px 24px #16ab7dba;
            cursor: pointer;
            text-transform: uppercase;
            transition: background 0.3s ease, color 0.25s ease;
            user-select: none;
            margin-top: 2rem;
            user-select: none;
        }
        .pay-btn:hover, .pay-btn:focus {
            background: linear-gradient(95deg, #16ab7d 10%, #098059 95%);
            color: #e6fff9;
            outline: none;
            box-shadow: 0 10px 40px #098059bb;
        }
        .download-btn, .back-btn {
            display: inline-block;
            width: 48%;
            margin: 1.1rem 1% 0 1%;
            background: #16ab7d;
            color: #e6fff9;
            font-size: 1.1rem;
            padding: 0.9rem 0;
            border-radius: 1.8rem;
            border: none;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            box-shadow: 0 4px 18px #16ab7dbf;
            cursor: pointer;
            transition: background 0.3s ease, color 0.3s ease;
            user-select: none;
        }
        .download-btn:hover,
        .back-btn:hover,
        .download-btn:focus,
        .back-btn:focus {
            background: #0f7e6d;
            color: #b3ffeb;
            outline: none;
        }
        .checkout-feedback {
            padding-top: 18px;
            min-height: 32px;
            text-align: center;
            font-weight: 700;
            user-select: text;
        }
        .feedback-error {
            color: #d94e53;
            letter-spacing: 0.02em;
        }
        .feedback-confirm {
            color: #35dd8c;
            letter-spacing: 0.02em;
        }
        @media (max-width: 600px) {
            .checkout-outer {
                max-width: 98vw;
                padding: 2rem 5vw;
            }
            .checkout-title {
                font-size: 2.4rem;
            }
            label.checkout-form-label {
                font-size: 1rem;
            }
            .checkout-form-input {
                font-size: 1rem;
                padding: 0.9rem 1rem;
            }
            .pay-btn, .download-btn, .back-btn {
                font-size: 1.1rem;
                padding: 1rem 0;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="checkout-outer" role="form" aria-label="Checkout Payment Details">
        <h1 class="checkout-title" tabindex="0">Quick Checkout</h1>

        <div class="order-summary-block" aria-label="Order Summary" tabindex="0">
            <h2>Order Summary</h2>
            <ul class="summary-items-list">
                <asp:Repeater ID="rptOrderItems" runat="server">
                    <ItemTemplate>
                        <li>
                            <span><%# Eval("ProductName") %> <span style="color:#7ad3b1;">×<%# Eval("Quantity") %></span></span>
                            <span>$<%# Eval("Subtotal", "{0:F2}") %></span>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
            </ul>
            <div class="checkout-total-line">
                <span>Total</span>
                <span>$<asp:Label ID="lblTotal" runat="server" Text="0.00" /></span>
            </div>
        </div>
        
        <label class="checkout-form-label" for="txtCardNumber">Card Number</label>
        <asp:TextBox ID="txtCardNumber" runat="server" MaxLength="16" CssClass="checkout-form-input" TextMode="Number" placeholder="1234 5678 9012 3456" autocomplete="cc-number" aria-label="Card Number" />

        <label class="checkout-form-label" for="txtNameOnCard">Name on Card</label>
        <asp:TextBox ID="txtNameOnCard" runat="server" MaxLength="64" CssClass="checkout-form-input" placeholder="Full Name" autocomplete="cc-name" aria-label="Name on Card" />

        <label class="checkout-form-label" for="txtExpiryDate">Expiry (MM/YY)</label>
        <asp:TextBox ID="txtExpiryDate" runat="server" MaxLength="5" CssClass="checkout-form-input" placeholder="MM/YY" autocomplete="cc-exp" aria-label="Card Expiry Date" />

        <label class="checkout-form-label" for="txtUsername">Username</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="checkout-form-input" ReadOnly="true" aria-readonly="true" aria-label="Username" />

        <asp:Button ID="btnPay" runat="server" Text="Pay &amp; Download Receipt" CssClass="pay-btn" OnClick="btnPay_Click" />

        <div>
            <asp:Button ID="btnDownloadCsv" runat="server" Text="Download as CSV" CssClass="download-btn" CausesValidation="false" OnClick="btnDownloadCsv_Click" />
            <asp:Button ID="btnGoToCart" runat="server" Text="Back to Cart" CssClass="back-btn" OnClick="btnGoToCart_Click" CausesValidation="false" />
        </div>
        <div class="checkout-feedback">
            <asp:Label ID="lblMessage" runat="server" CssClass="" EnableViewState="false" />
        </div>
    </div>
</asp:Content>
