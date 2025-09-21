<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site1.Master"
    CodeBehind="Login.aspx.cs" Inherits="GadgetHub.Login" UnobtrusiveValidationMode="None" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="server">
    <title>Login - Gadget Hub</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&family=Georgia&display=swap" rel="stylesheet" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />

    <style>
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Georgia', serif;
            background: linear-gradient(135deg, #bee6db 0%, #ffffff 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100vw;
            user-select: text;
        }
        /* Outer translucent blurred layer */
        .blurred-bg-layer {
            position: absolute;
            width: 360px;
            height: 550px;
            background: rgba(41, 130, 122, 0.13);
            border-radius: 36px;
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            box-shadow: 0 12px 32px rgb(41 130 122 / 20%);
            z-index: 4;
            user-select: none;
            transition: box-shadow 0.4s ease;
        }
        /* Slightly bigger blurred background rotated for subtle layered effect */
        .blurred-bg-layer.second {
            width: 400px;
            height: 580px;
            background: rgba(41, 130, 122, 0.18);
            transform: translate(14px, 18px) rotate(-3.6deg);
            z-index: 2;
            box-shadow: 0 18px 48px rgb(41 130 122 / 30%);
        }

        /* Container for forms */
        .login-wrapper {
            position: relative;
            width: 360px;
            z-index: 5;
            user-select: text;
        }

        /* Main login container */
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 60px 52px 64px 52px;
            border-radius: 36px;
            box-shadow: 0 14px 44px rgb(41 130 122 / 35%);
            display: flex;
            flex-direction: column;
            gap: 2rem;
            user-select: text;
            font-family: 'Georgia', serif;
        }


        /* Heading */
        .login-container h2 {
            font-weight: 900;
            font-size: 2.9rem;
            letter-spacing: 0.11em;
            color: #1e5e58;
            margin: 0 0 48px 0;
            text-align: center;
            user-select: text;
        }

        /* Form group */
        .form-group {
            position: relative;
            display: flex;
            flex-direction: column;
        }

        /* Labels */
        label {
            font-weight: 600;
            color: #29827a;
            font-size: 1.15rem;
            user-select: none;
            margin-bottom: 10px;
            user-select: text;
        }

        /* Inputs */
        .form-control {
            border-radius: 30px;
            border: 2px solid #9bd3cc;
            padding: 17px 22px 17px 22px;
            font-size: 1.2rem;
            font-family: 'Georgia', serif;
            background-color: #e0f0ed;
            color: #1c4b49;
            box-shadow: inset 0 0 10px #94c9c4aa;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            user-select: text;
        }
        .form-control::placeholder {
            color: #50a99bdd;
            font-style: italic;
        }
        .form-control:focus {
            outline: none;
            border-color: #1e5e58;
            box-shadow: 0 0 18px #1e5e587f;
            background-color: #ffffffcc;
        }

        /* Password container with toggle */
        .password-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .password-wrapper .form-control {
            flex-grow: 1;
            margin-bottom: 0;
            padding-right: 50px;
        }
        .toggle-password-btn {
            position: absolute;
            right: 14px;
            background: transparent;
            border: none;
            cursor: pointer;
            color: #1e5e58;
            font-size: 1.25rem;
            padding: 4px;
            user-select: none;
            transition: color 0.25s ease;
        }
        .toggle-password-btn:hover,
        .toggle-password-btn:focus {
            color: #29827a;
            outline: none;
        }

        /* Validation summary */
        .validation-summary-errors {
            background: #ffb6b6cc;
            border-radius: 18px;
            padding: 1.4rem 1.75rem;
            color: #801313;
            font-weight: 700;
            font-size: 1.1rem;
            margin-bottom: 2rem;
            box-shadow: inset 0 0 16px #b03b3bcc;
            user-select: text;
        }

        /* Inline validation error */
        .field-validation-error {
            color: #c04644;
            font-weight: 700;
            font-size: 1.05rem;
            margin-top: 8px;
            display: block;
            user-select: text;
        }

        /* Login Button */
        .btn-login {
            width: 100%;
            padding: 20px;
            font-size: 1.45rem;
            font-weight: 700;
            border-radius: 40px;
            background: linear-gradient(120deg, #29827a 0%, #1e5e58 100%);
            border: none;
            color: white;
            box-shadow: 0 10px 36px #1e5e585f, 0 0 28px #29827baa;
            cursor: pointer;
            transition: background 0.36s cubic-bezier(0.24, 0.31, 0, 0.94),
                box-shadow 0.36s cubic-bezier(0.24, 0.31, 0, 0.94),
                transform 0.34s ease;
            user-select: none;
        }
        .btn-login:hover,
        .btn-login:focus {
            background: linear-gradient(120deg, #1e5e58 0%, #17a092 100%);
            box-shadow: 0 14px 46px #17a092cc, 0 0 40px #29827bf0;
            transform: translateY(-3px) scale(1.025);
            outline: none;
        }
        .btn-login:focus-visible {
            outline: 3px solid #64c1b0;
            outline-offset: 4px;
        }

        /* Forgot password */
        .forgot-password {
            text-align: right;
            font-weight: 600;
            font-size: 1rem;
            user-select: none;
        }
        .forgot-password a {
            color: #29827a;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .forgot-password a:hover,
        .forgot-password a:focus {
            color: #1e5e58;
            outline: none;
            text-decoration: underline;
        }

        /* Register Link */
        .register-link {
            margin-top: 26px;
            text-align: center;
            font-weight: 600;
            font-size: 1.1rem;
            color: #494f4f;
            user-select: none;
        }
        .register-link a {
            color: #29827a;
            font-weight: 700;
            text-decoration: none;
            transition: color 0.28s ease;
        }
        .register-link a:hover,
        .register-link a:focus {
            color: #1e5e58;
            text-decoration: underline;
            outline: none;
        }

        /* Responsive */
        @media (max-width: 440px) {
            .login-wrapper {
                width: 94vw;
            }
            .blurred-bg-layer.second {
                display: none;
            }
            .login-container {
                padding: 48px 36px;
            }
            .login-container h2 {
                font-size: 2.45rem;
                margin-bottom: 38px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="position:relative; width: fit-content; user-select:none;">

        <!-- Background Layer 2: bigger, behind -->
        <div class="blurred-bg-layer second"></div>

        <!-- Background Layer 1: main translucent panel -->
        <div class="blurred-bg-layer"></div>

        <!-- Login Form Container -->
        <main class="login-wrapper" role="main" aria-labelledby="loginTitle">
            <div class="login-container">
                <h2 id="loginTitle">Gadget Hub Login</h2>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                    CssClass="validation-summary-errors"
                    HeaderText="Please fix the following errors:"
                    DisplayMode="BulletList"
                    ShowSummary="true"
                    EnableClientScript="true" />

                <div class="form-group">
                    <label for="txtUsername">Username</label>
                    <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" MaxLength="100"
                        AutoComplete="username" aria-required="true" />
                    <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername"
                        ErrorMessage="Username is required." ForeColor="#c04644" Display="Dynamic"
                        SetFocusOnError="true" CssClass="field-validation-error" />
                </div>

                <div class="form-group">
                    <label for="txtPassword">Password</label>
                    <div class="password-wrapper">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" MaxLength="100"
                            AutoComplete="current-password" aria-required="true" />
                        <button type="button" id="btnTogglePassword" class="toggle-password-btn" aria-label="Show or hide password" tabindex="0">&#128065;</button>
                    </div>
                    <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword"
                        ErrorMessage="Password is required." ForeColor="#c04644" Display="Dynamic"
                        SetFocusOnError="true" CssClass="field-validation-error" />
                </div>

                <div class="forgot-password">
                    <a href="ForgotPassword.aspx" tabindex="0" aria-label="Forgot password?">Forgot password?</a>
                </div>

                <asp:Button ID="btnLogin" runat="server" Text="Sign In"
                    CssClass="btn-login"
                    OnClick="btnLogin_Click"
                    aria-label="Sign In button" />

                <div class="register-link">
                    Don't have an account?
                    <a href="Register.aspx" tabindex="0" aria-label="Register here">Register here</a>
                </div>
            </div>
        </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        (function () {
            const toggleBtn = document.getElementById('btnTogglePassword');
            const passwordInput = document.getElementById('<%= txtPassword.ClientID %>');

            toggleBtn.addEventListener('click', () => {
                const type = passwordInput.getAttribute('type');
                if (type === 'password') {
                    passwordInput.setAttribute('type', 'text');
                    toggleBtn.innerHTML = '&#128068;'; // Closed eye icon
                    toggleBtn.setAttribute('aria-label', 'Hide password');
                } else {
                    passwordInput.setAttribute('type', 'password');
                    toggleBtn.innerHTML = '&#128065;'; // Eye icon
                    toggleBtn.setAttribute('aria-label', 'Show password');
                }
            });
            toggleBtn.addEventListener('keydown', (e) => {
                if (e.key === 'Enter' || e.key === ' ') {
                    e.preventDefault();
                    toggleBtn.click();
                }
            });
        })();
    </script>

</asp:Content>
