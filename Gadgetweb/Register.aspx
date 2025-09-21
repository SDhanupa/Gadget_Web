<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master" CodeBehind="Register.aspx.cs" Inherits="Gadgetweb.Register" UnobtrusiveValidationMode="None" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <title>Sign Up - Gadget Hub</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;700&family=Georgia&display=swap" rel="stylesheet" />
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        html, body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Georgia', serif;
            background: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
            user-select: text;
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100vw;
        }

        .register-wrapper {
            position: relative;
            width: 400px;
            user-select: text;
        }

        /* Blurred background layers for glass effect */
        .blurred-bg-layer {
            position: absolute;
            border-radius: 32px;
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            box-shadow: 0 10px 38px rgba(41, 130, 122, 0.2);
            z-index: 2;
            user-select: none;
            background: rgba(41, 130, 122, 0.14);
            transition: box-shadow 0.4s ease;
        }
        .blurred-bg-layer.first {
            width: 380px;
            height: 580px;
            top: 0; left: 0;
        }
        .blurred-bg-layer.second {
            width: 420px;
            height: 600px;
            top: 18px;
            left: 22px;
            background: rgba(41, 130, 122, 0.22);
            box-shadow: 0 18px 54px rgba(41, 130, 122, 0.28);
            transform: rotate(-4deg);
            z-index: 1;
        }

        /* The main register panel */
        .register-glassbox {
            position: relative;
            background: rgba(255, 255, 255, 0.92);
            border-radius: 32px;
            box-shadow: 0 14px 46px rgba(41, 130, 122, 0.35);
            padding: 3.5rem 3.2rem 3.2rem 3.2rem;
            z-index: 3;
            user-select: text;
            font-family: 'Georgia', serif;
            display: flex;
            flex-direction: column;
        }
        .register-title {
            font-size: 2.9rem;
            font-weight: 900;
            letter-spacing: 0.1em;
            color: #1e5e58;
            text-align: center;
            margin-bottom: 48px;
            user-select: text;
            text-shadow: 0 0 10px #179989a3;
        }

        label.register-form-label {
            color: #1a4d49;
            font-weight: 700;
            font-size: 1.13rem;
            margin-bottom: 8px;
            user-select: text;
            display: block;
        }

        .register-input {
            width: 100%;
            padding: 16px 20px;
            font-size: 1.1rem;
            font-family: 'Georgia', serif;
            font-weight: 600;
            color: #1c4b49;
            border-radius: 28px;
            border: 2px solid #94c9c4;
            background-color: #e0f0ed;
            box-shadow: inset 0 0 18px #94c9c4cc;
            transition: border-color 0.3s ease, background-color 0.3s ease;
            user-select: text;
        }
        .register-input::placeholder {
            color: #50a99bdd;
            font-style: italic;
        }
        .register-input:focus {
            outline: none;
            border-color: #1e5e58;
            background-color: #f0fcfa;
            box-shadow: 0 0 22px #1e5e58cc inset;
        }

        /* Password input container with toggle */
        .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .password-wrapper .register-input {
            padding-right: 50px;
        }
        .toggle-password-btn {
            position: absolute;
            right: 14px;
            background: transparent;
            border: none;
            color: #1e5e58;
            font-size: 1.18rem;
            cursor: pointer;
            padding: 6px;
            user-select: none;
            transition: color 0.25s ease;
        }
        .toggle-password-btn:hover,
        .toggle-password-btn:focus {
            color: #29827a;
            outline: none;
        }

        /* Validation messages */
        .validation-summary-errors, .register-error, .rfv, .cv, .rev {
            color: #bf3b3b;
            font-size: 1rem;
            font-weight: 700;
            margin-top: 6px;
            user-select: text;
            text-shadow: 0 0 8px #bc4343a3;
        }

        /* Roles selection */
        .register-roles-block {
            margin-top: 2rem;
            color: #1e5e58;
            font-weight: 700;
            font-size: 1.08rem;
            user-select: text;
        }
        .register-roles-inner {
            display: flex;
            justify-content: center;
            gap: 2.4rem;
            margin-top: 0.4rem;
        }
        .register-role-radio {
            accent-color: #1e5e58;
            width: 1.3em; height: 1.3em;
            vertical-align: middle;
        }
        .register-role-lbl {
            user-select: text;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            margin-left: 6px;
        }

        /* Register button */
        .btn-register-modern {
            margin-top: 2.4rem;
            background: linear-gradient(120deg, #1fa7b8 20%, #24d490 100%);
            color: #fff;
            font-weight: 800;
            font-size: 1.3rem;
            padding: 18px 0;
            border-radius: 40px;
            border: none;
            box-shadow: 0 10px 36px #20d490bb;
            cursor: pointer;
            transition: background 0.3s ease, box-shadow 0.33s ease, transform 0.33s ease;
            user-select: none;
            text-transform: uppercase;
        }
        .btn-register-modern:hover,
        .btn-register-modern:focus {
            background: linear-gradient(120deg, #13857e 10%, #1cbd89 90%);
            box-shadow: 0 16px 48px #1cbd8999;
            outline: none;
            transform: translateY(-4px) scale(1.02);
        }

        /* Footer register link */
        .register-link-foot {
            margin-top: 2.2rem;
            text-align: center;
            font-weight: 600;
            font-size: 1rem;
            color: #1e5e58;
            user-select: text;
        }
        .register-link-foot a {
            color: #24d490;
            font-weight: 700;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .register-link-foot a:hover,
        .register-link-foot a:focus {
            color: #1a936f;
            text-decoration: underline;
            outline: none;
        }

        /* Responsive */
        @media (max-width: 470px) {
            .register-wrapper {
                width: 92vw;
            }
            .blurred-bg-layer.second {
                display: none;
            }
            .register-glassbox {
                padding: 2.9rem 2.25rem 2.2rem 2.25rem;
            }
            .register-title {
                font-size: 2.15rem;
                margin-bottom: 36px;
            }
            .btn-register-modern {
                font-size: 1.2rem;
                padding: 16px 0;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="register-wrapper" role="main" aria-labelledby="registerTitle">

        <div class="blurred-bg-layer second" aria-hidden="true"></div>
        <div class="blurred-bg-layer first" aria-hidden="true"></div>

        <div class="register-glassbox">
            <div class="register-title" id="registerTitle">Create Your Account</div>

            <asp:ValidationSummary ID="vsSummary" runat="server" CssClass="validation-summary-errors"
                HeaderText="Please fix the following errors:" DisplayMode="BulletList" />

            <label class="register-form-label" for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="register-input" Placeholder="Choose your username..." MaxLength="100" />
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                ErrorMessage="Username is required." CssClass="register-error rfv" Display="Dynamic" SetFocusOnError="true" />

            <label class="register-form-label" for="txtEmail">Email Address</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="register-input" Placeholder="your@email.com" TextMode="Email" MaxLength="255" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="Email is required." CssClass="register-error rfv" Display="Dynamic" SetFocusOnError="true" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                ErrorMessage="Invalid email address."
                ValidationExpression="^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$"
                CssClass="register-error rev" Display="Dynamic" />

            <label class="register-form-label" for="txtPassword">Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="register-input" TextMode="Password" Placeholder="6+ characters, please" MaxLength="60" />
                <button type="button" id="btnTogglePassword" class="toggle-password-btn" aria-label="Show or hide password" tabindex="0">&#128065;</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                ErrorMessage="Password required." CssClass="register-error rfv" Display="Dynamic" SetFocusOnError="true" />
            <asp:RegularExpressionValidator ID="revPassword" runat="server" ControlToValidate="txtPassword"
                ErrorMessage="Password must be at least 6 characters."
                ValidationExpression=".{6,}"
                CssClass="register-error rev" Display="Dynamic" />

            <label class="register-form-label" for="txtConfirmPassword">Confirm Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="register-input" TextMode="Password" Placeholder="Re-enter password..." MaxLength="60" />
                <button type="button" id="btnToggleConfirmPassword" class="toggle-password-btn" aria-label="Show or hide confirm password" tabindex="0">&#128065;</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword"
                ErrorMessage="Confirmation required." CssClass="register-error rfv" Display="Dynamic" SetFocusOnError="true" />
            <asp:CompareValidator ID="cvPasswordMatch" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword"
                ErrorMessage="Password mismatch." CssClass="register-error cv" Display="Dynamic" />

            <div class="register-roles-block" aria-describedby="registerRolesHelp">
                <div class="register-roles-inner">
                    <label class="register-role-lbl">
                        <asp:RadioButton ID="rbBuyer" runat="server" GroupName="UserRole" CssClass="register-role-radio" Checked="true" />
                        Buyer
                    </label>
                    <label class="register-role-lbl">
                        <asp:RadioButton ID="rbSeller" runat="server" GroupName="UserRole" CssClass="register-role-radio" />
                        Seller
                    </label>
                </div>
                <div id="registerRolesHelp" style="font-size:0.9em; color:#1a5e57; margin-top:0.4em; user-select:text;">
                    Select your registration role.
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register Now" CssClass="btn-register-modern" OnClick="btnRegister_Click" />
            <div class="register-link-foot">
                Already registered? <a href="Login.aspx">Login here</a>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Password Toggle Script -->
    <script>
        (function () {
            function setupToggle(passwordInputId, toggleBtnId) {
                const input = document.getElementById(passwordInputId);
                const btn = document.getElementById(toggleBtnId);
                if (!input || !btn) return;
                btn.addEventListener('click', () => {
                    if (input.type === 'password') {
                        input.type = 'text';
                        btn.innerHTML = '&#128068;'; // closed eye icon
                        btn.setAttribute('aria-label', 'Hide password');
                    } else {
                        input.type = 'password';
                        btn.innerHTML = '&#128065;'; // open eye icon
                        btn.setAttribute('aria-label', 'Show password');
                    }
                });
                btn.addEventListener('keydown', (e) => {
                    if (e.key === 'Enter' || e.key === ' ') {
                        e.preventDefault();
                        btn.click();
                    }
                });
            }

            setupToggle('<%= txtPassword.ClientID %>', 'btnTogglePassword');
            setupToggle('<%= txtConfirmPassword.ClientID %>', 'btnToggleConfirmPassword');
        })();
    </script>
</asp:Content>
