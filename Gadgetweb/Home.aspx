<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="GadgetHub.Home" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <title>Gadget Hub - Home</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        /* =============== GLOBALS =============== */
        body {
            font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
            background: linear-gradient(135deg, #e5f6fd 0%, #f0f0f5 100%);
            margin: 0;
            color: #20282b;
            min-height: 100vh;
        }

        a {
            color: #1fa7b8;
            text-decoration: none;
            transition: color 0.2s;
        }
        a:hover, a:focus {
            color: #055e78;
        }

        /* =============== NAVBAR =============== */
        .navbar-custom {
            background: rgba(255,255,255,0.96);
            box-shadow: 0 2px 16px rgba(34,60,80,0.09);
            font-weight: 600;
            border-bottom: 1px solid #ebf1f5;
        }
        .navbar-brand {
            font-size: 2.3rem;
            color: #1fa7b8 !important;
            font-weight: 900;
            letter-spacing: 0.09em;
            text-shadow: 0 2px 4px #27b2db27;
        }
        .navbar-nav .nav-link {
            font-size: 1.11rem;
            padding-right: 1.3rem;
            color: #263238 !important;
            transition: color 0.15s;
        }
        .navbar-nav .nav-link.active, .navbar-nav .nav-link:hover {
            color: #1fa7b8 !important;
            text-decoration: underline;
        }
        .navbar-toggler {
            border: none;
            background: none;
        }

        /* =============== HERO =============== */
        .hero-bg {
            background: linear-gradient(120deg, #dbe5ff 0 60%, #e0fcfc 90%);
            border-radius: 36px;
            box-shadow: 0 16px 44px 0 rgba(71, 202, 237, 0.07);
            margin: 120px auto 50px auto;
            max-width: 950px;
            padding: 60px 36px 56px 36px;
            position: relative;
            overflow: hidden;
        }
        .hero-bg::before {
            content:"";
            position: absolute;
            left: -120px; top: -90px;
            width: 350px; height:350px;
            background: radial-gradient(circle, #1fa7b87d 30%, transparent 85%);
            z-index: 0;
        }
        .hero-bg h1 {
            font-size: 3.3rem;
            font-weight: 900;
            color: #012031;
            margin-bottom: 0.6rem;
            letter-spacing: 0.12em;
            z-index: 2;
            position: relative;
        }
        .hero-bg p {
            font-size: 1.27rem;
            color: #357487;
            margin-bottom: 2rem;
            max-width: 520px;
            margin-left: auto;
            margin-right: auto;
            font-style: italic;
            z-index: 2;
            position: relative;
        }
        .btn-hero {
            min-width:160px;
            padding: 1.2rem 3rem;
            background: linear-gradient(120deg,#1fa7b8 50%,#24d490 100%);
            color: #fff;
            font-weight: 800;
            border-radius: 34px;
            font-size: 1.3rem;
            border: 0;
            box-shadow: 0 8px 28px #1fa7b859;
            text-transform: uppercase;
            transition: background 0.2s, transform 0.15s;
        }
        .btn-hero:hover, .btn-hero:focus {
            background: linear-gradient(90deg,#179bad 70%,#26e174 100%);
            transform: translateY(-4px) scale(1.03);
            color: #fff;
        }

        /* =============== OFFERS =============== */
        .section-card {
            background: rgba(255,255,255,0.97);
            border-radius: 26px;
            max-width: 780px;
            margin: 0 auto 46px auto;
            padding: 48px 30px 34px 30px;
            box-shadow: 0 2px 30px 0 rgba(34,68,86,0.13);
            text-align: center;
        }
        .section-card h2 {
            font-weight: 800;
            font-size: 2.2rem;
            color: #1fa7b8;
            margin-bottom: 0.9em;
        }
        .section-card p {
            font-size: 1.13rem;
            color: #2a3c47;
            margin-bottom: 30px;
            max-width: 555px;
            margin-left: auto; margin-right: auto;
        }
        .btn-offer {
            background: #fff;
            border: 2px solid #19c4b7;
            color: #1fa7b8;
            font-weight: 700;
            padding: 0.95em 3em;
            font-size: 1.16rem;
            border-radius: 26px;
            box-shadow: 0 4px 18px #66eaec0d;
            transition: background 0.2s, color 0.2s, border-color 0.2s, transform 0.12s;
        }
        .btn-offer:hover, .btn-offer:focus {
            background: linear-gradient(100deg,#ddf7fb 40%,#d2fbf7 90%);
            color: #0c616e;
            border-color: #1fa7b8;
            transform: translateY(-2px) scale(1.01);
        }

        /* =============== PARTNERS =============== */
        .partners-section {
            max-width: 1050px;
            margin: 38px auto 52px auto;
            border-radius: 20px;
            background: rgba(245,250,255, 0.93);
            box-shadow: 0 3px 18px #91cfe21a;
            padding: 26px 2vw 38px 2vw;
        }
        .partners-section h2 {
            text-align: center;
            font-weight: 800;
            font-size: 2rem;
            color: #1fa7b8;
            margin-bottom: 1.1em;
        }
        .partners-logos {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2.5rem 3.5rem;
        }
        .partner-logo {
            width: 120px;
            height: 67px;
            padding: 8px 10px;
            background: rgba(245,255,255,0.8);
            border-radius: 12px;
            box-shadow: 0 4px 18px #20e9fd13;
            filter: grayscale(1) contrast(0.6) brightness(1.08);
            opacity: 0.66;
            transition: filter 0.23s, opacity 0.23s, box-shadow 0.2s;
            object-fit: contain;
            cursor: pointer;
        }
        .partner-logo:hover, .partner-logo:focus {
            filter: none;
            opacity: 1;
            box-shadow: 0 12px 30px #1fa7b81c;
        }

        /* =============== TESTIMONIALS =============== */
        .testimonials-section {
            max-width: 940px;
            margin: 0 auto 46px auto;
            padding: 48px 24px 38px 24px;
            background:rgba(248,250,253,0.99);
            border-radius:26px;
            box-shadow: 0 4px 36px #00839323;
            text-align: center;
        }
        .testimonials-section h2 {
            font-size: 2.1rem;
            color: #336e7b;
            font-weight: 800;
            margin-bottom: 2.5em;
        }
        .testimonial-card {
            margin-bottom: 32px;
            background: rgba(255,255,255,0.95);
            border-radius: 16px;
            padding: 1.5rem 2rem 1.3rem 2rem;
            box-shadow: 0 3px 16px #20d4ef20;
            backdrop-filter: blur(2.5px);
            display: flex;
            flex-direction: column;
            gap: 0.7rem;
            align-items: flex-start;
        }
        .testimonial-card:last-child { margin-bottom: 0; }
        .testimonial-text {
            font-size: 1.14rem;
            color: #333e50;
            line-height: 1.56;
        }
        .testimonial-author {
            font-size: 1.02rem;
            color: #1fa7b8;
            font-weight: 700;
            margin-left: auto;
        }

        /* =============== NEWSLETTER =============== */
        .newsletter-section {
            background: linear-gradient(120deg, #1fa7b8 80%, #42e2b8 100%);
            border-radius: 26px;
            box-shadow: 0 6px 28px #1fa7b82f;
            padding: 40px 18px 30px 18px;
            max-width: 710px;
            margin: 0 auto 56px auto;
            text-align: center;
            color: #fff;
        }
        .newsletter-section h3 {
            font-size: 2.1rem;
            font-weight:900;
            margin-bottom: 0.35em;
            letter-spacing: 0.06em;
        }
        .newsletter-section p {
            color: #e6f9ff;
            font-size: 1.15rem;
            margin-bottom: 2rem;
            font-weight: 400;
        }
        .newsletter-form {
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }
        .newsletter-section .form-control {
            border-radius: 50px !important;
            border: none;
            padding: 0.98rem 2rem;
            font-size: 1.08rem;
            max-width: 312px;
            background: rgba(255,255,255,0.82);
            color: #005d6c;
            font-weight: 500;
            box-shadow: 0 1px 14px #2be2e02f;
        }
        .newsletter-section .form-control:focus {
            border: 1.5px solid #fff;
            background: #fff;
            color: #005d6c;
        }
        .btn-newsletter {
            border-radius: 50px;
            padding: 0.98rem 2.6rem;
            background: linear-gradient(90deg,#0a7da5,#11e4af 90%);
            color: #fff;
            font-weight: 800;
            font-size: 1.12rem;
            border: none;
            box-shadow: 0 5px 18px #12b6a859;
            transition: transform 0.15s, box-shadow 0.21s, background 0.14s;
        }
        .btn-newsletter:hover, .btn-newsletter:focus {
            background: linear-gradient(90deg,#0a7da5,#0bda85 100%);
            transform: translateY(-3px) scale(1.01);
        }
        .newsletter-section .newsletter-message {
            margin-top: 1.3rem;
            font-weight: 600;
            font-size: 1.13rem;
            user-select: none;
        }
        .newsletter-section .text-success {
            color: #7dffcc !important;
            text-shadow: 0 1px 9px #0bda85b2;
        }
        .newsletter-section .text-danger {
            color: #ffd9d9 !important;
            text-shadow: 0 1px 5px #cc4444a8;
        }

        /* =============== FOOTER =============== */
        .site-footer {
            background: #eaf4f9;
            color: #287889;
            padding: 1.6rem 0;
            font-size: 1.04rem;
            text-align: center;
            border-top: 1px solid #c1e3fa89;
            font-weight: 600;
            letter-spacing: 0.04em;
        }
        .site-footer a { color:#16a0b7; }

        /* =============== RESPONSIVE =============== */
        @media (max-width: 991px) {
            .hero-bg { padding: 40px 10vw;   }
            .section-card, .testimonials-section, .newsletter-section { padding: 32px 2vw; }
            .partners-logos { gap: 1.2rem 1.8rem; }
        }
        @media (max-width: 600px) {
            .navbar-brand { font-size:1.6rem;}
            .hero-bg h1 { font-size: 2.05rem;}
            .hero-bg { padding:32px 6vw 36px 6vw; margin-top:70px;}
            .partner-logo { width:80px; height:44px;}
            .section-card h2, .partners-section h2, .testimonials-section h2, .newsletter-section h3 { font-size:1.28rem;}
        }
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <nav class="navbar navbar-expand-lg navbar-custom fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="Home.aspx">Gadget Hub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav"
                aria-controls="mainNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon">
                    <span style="display:block; width:23px; height:3.5px; background:#1fa7b8; margin:5px 0; border-radius:3px"></span>
                    <span style="display:block; width:23px; height:3.5px; background:#1fa7b8; margin:5px 0; border-radius:3px"></span>
                </span>
            </button>
            <div class="collapse navbar-collapse" id="mainNav">
                <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                    <li class="nav-item"><a class="nav-link active" href="Home.aspx">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="Items.aspx">Products</a></li>
                    <li class="nav-item"><a class="nav-link" href="Login.aspx">Login</a></li>
                    <li class="nav-item"><a class="nav-link" href="Register.aspx">Register</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- HERO SECTION -->
    <section class="hero-bg" aria-label="Hero Banner">
        <h1>GADGET HUB</h1>
        <p>Your trusted partner for high quality PC parts and effortless custom builds.</p>
        <a href="Items.aspx" class="btn-hero" aria-label="Shop gadgets now">Shop Now</a>
    </section>

    <!-- OFFERS SECTION -->
    <section class="section-card" aria-label="Special Offers">
        <h2>Exclusive Bundle Deals</h2>
        <p>Bundle your dream setup and save! Find top-performing PC hardware together and get exclusive discounts only at Gadget Hub.</p>
        <a href="Items.aspx?deals=true" class="btn-offer" aria-label="Explore deals">Explore Deals</a>
    </section>

    <!-- PARTNER LOGOS -->
    <section class="partners-section" aria-label="Brand Partners">
        <h2>Our Trusted Sellers</h2>
        <div class="partners-logos" role="list">
            <img src="images/partners/techcorp.png" alt="TechCorp" class="partner-logo" role="listitem" tabindex="0"/>
            <img src="images/partners/hardwarehackers.png" alt="Hardware Hackers" class="partner-logo" role="listitem" tabindex="0"/>
            <img src="images/partners/gearzone.png" alt="GearZone" class="partner-logo" role="listitem" tabindex="0"/>
            <img src="images/partners/pcmasters.png" alt="PC Masters" class="partner-logo" role="listitem" tabindex="0"/>
            <img src="images/partners/cybertronics.png" alt="Cybertronics" class="partner-logo" role="listitem" tabindex="0"/>
        </div>
    </section>

    <!-- TESTIMONIALS -->
    <section class="testimonials-section" aria-label="Customer Testimonials">
        <h2>What Our Customers Say</h2>
        <div class="testimonial-card" tabindex="0" aria-label="Testimonial from neri M.">
            <p class="testimonial-text">"Gadget Hub made building my gaming rig seamless, with fast delivery and quality parts."</p>
            <span class="testimonial-author">— neri M.</span>
        </div>
        <div class="testimonial-card" tabindex="0" aria-label="Testimonial from Raj K.">
            <p class="testimonial-text">"Excellent selection and customer support. The bundle deals saved me a lot!"</p>
            <span class="testimonial-author">— Raj K.</span>
        </div>
        <div class="testimonial-card" tabindex="0" aria-label="Testimonial from semay R.">
            <p class="testimonial-text">"I trust Gadget Hub for all my PC component needs. Highly recommended."</p>
            <span class="testimonial-author">— semay R.</span>
        </div>
    </section>

    <!-- NEWSLETTER -->
    <section class="newsletter-section" aria-label="Newsletter Sign Up">
        <h3>Get the Latest Updates</h3>
        <p>Sign up for exclusive offers, news and pro PC build tips from Gadget Hub.</p>
        <form id="newsletterForm" runat="server" class="newsletter-form" autocomplete="off">
            <asp:TextBox ID="txtNewsletterEmail" runat="server" CssClass="form-control" placeholder="Your email address" AutoComplete="email" />
            <asp:Button ID="btnSubscribe" runat="server" Text="Subscribe" CssClass="btn-newsletter" OnClick="btnSubscribe_Click" />
        </form>
        <asp:Label ID="lblNewsletterMessage" runat="server" CssClass="newsletter-message"></asp:Label>
    </section>

    <!-- FOOTER -->
    <footer class="site-footer" aria-label="Site Footer">
        <p>&copy; <%# DateTime.Now.Year %> Gadget Hub. All rights reserved.</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
