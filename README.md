# Gadget_Web – E-Commerce Marketplace Platform

Gadget_Web is a comprehensive e-commerce website developed using ASP.NET and C#. It provides a complete marketplace solution where users and sellers can interact seamlessly, offering product listing, purchasing, delivery management, and order acceptance for a complete online shopping experience.

## 🚀 Features

- **User & Seller Registration** - Secure authentication system for both buyers and sellers
- **Product Management** - Sellers can list, edit, and manage their products with ease
- **Advanced Search & Browse** - Users can search and filter products by categories, price, and features
- **Order Management** - Complete order placement with real-time delivery tracking
- **Messaging System** - Built-in communication platform between users and sellers
- **Secure Payments** - Integrated payment processing with order acceptance workflow
- **Responsive Design** - Optimized for desktop, tablet, and mobile devices
- **Inventory Management** - Real-time stock tracking and product availability updates
- **Review & Rating System** - Customer feedback and product rating functionality

## 🛠 Tech Stack

**Frontend:** HTML5, CSS3, JavaScript, Bootstrap
**Backend:** ASP.NET Framework, C#
**Database:** SQL Server
**Authentication:** ASP.NET Identity
**Payment Integration:** Secure payment gateway integration
**Development Environment:** Visual Studio
**Server:** IIS (Internet Information Services)

## 📂 Project Structure

```
Gadget_Web/
│
├── App_Data/              # Database files and data storage
├── App_Start/             # Application startup configuration
├── Controllers/           # MVC Controllers
│   ├── HomeController.cs
│   ├── ProductController.cs
│   ├── UserController.cs
│   └── OrderController.cs
│
├── Models/               # Data models and entities
│   ├── User.cs
│   ├── Product.cs
│   ├── Order.cs
│   └── Message.cs
│
├── Views/                # Razor views and UI templates
│   ├── Home/
│   ├── Product/
│   ├── User/
│   └── Shared/
│
├── Scripts/              # JavaScript files
├── Content/              # CSS and styling files
├── Images/               # Product images and assets
├── bin/                  # Compiled assemblies
└── Web.config            # Configuration file
```

## 🎯 Key Functionalities

### For Sellers
- **Product Listing** - Easy-to-use interface for adding new products
- **Inventory Management** - Track stock levels and product availability
- **Order Processing** - Manage incoming orders and update delivery status
- **Sales Analytics** - View sales performance and customer insights
- **Profile Management** - Update seller information and business details

### For Users
- **Product Discovery** - Browse extensive product catalog with advanced filters
- **Shopping Cart** - Add products and manage shopping sessions
- **Secure Checkout** - Multiple payment options with secure processing
- **Order Tracking** - Real-time updates on order and delivery status
- **Communication** - Direct messaging with sellers for inquiries

### Administrative Features
- **User Management** - Admin panel for managing users and sellers
- **Product Moderation** - Review and approve product listings
- **Order Oversight** - Monitor all transactions and resolve disputes
- **System Analytics** - Comprehensive reports on platform performance

## 💻 Installation & Setup

### Prerequisites
- Visual Studio 2019 or later
- .NET Framework 4.7.2 or later
- SQL Server 2016 or later
- IIS Express (included with Visual Studio)

### Installation Steps

```bash
# Clone the repository
git clone https://github.com/SDhanupa/Gadget_Web.git

# Navigate to project directory
cd Gadget_Web
```

### Visual Studio Setup

1. **Open Solution**
   - Launch Visual Studio
   - Open the `Gadget_Web.sln` file

2. **Restore NuGet Packages**
   - Right-click on Solution in Solution Explorer
   - Select "Restore NuGet Packages"

3. **Configure Database**
   - Open `Web.config`
   - Update the connection string with your SQL Server details:
   ```xml
   <connectionStrings>
     <add name="DefaultConnection" 
          connectionString="Data Source=YourServer;Initial Catalog=GadgetWebDB;Integrated Security=True" 
          providerName="System.Data.SqlClient" />
   </connectionStrings>
   ```

4. **Database Migration**
   - Open Package Manager Console
   - Run: `Update-Database`

5. **Build and Run**
   - Build the solution (Ctrl+Shift+B)
   - Press F5 to run the project

## 🔧 Configuration

### Database Configuration
Update the connection string in `Web.config`:
```xml
<add name="DefaultConnection" 
     connectionString="Your_SQL_Server_Connection_String" 
     providerName="System.Data.SqlClient" />
```

### Email Configuration (Optional)
Configure SMTP settings for email notifications:
```xml
<system.net>
  <mailSettings>
    <smtp from="noreply@gadgetweb.com">
      <network host="your-smtp-server" port="587" userName="your-email" password="your-password" />
    </smtp>
  </mailSettings>
</system.net>
```

## 📱 Usage

### Getting Started
1. **Registration**
   - New users can register as buyers or sellers
   - Email verification required for account activation

2. **For Sellers**
   - Complete seller profile setup
   - Add product categories and listings
   - Set pricing and inventory levels
   - Manage orders and customer communications

3. **For Buyers**
   - Browse product catalog
   - Use search and filter options
   - Add items to cart and checkout securely
   - Track orders and communicate with sellers

### User Workflows

**Seller Journey:**
1. Register → Verify Email → Setup Profile
2. Add Products → Set Prices → Manage Inventory
3. Receive Orders → Process → Update Delivery Status

**Buyer Journey:**
1. Browse Products → Search/Filter → View Details
2. Add to Cart → Checkout → Make Payment
3. Track Order → Receive Product → Leave Review

## 🛡️ Security Features

- **Secure Authentication** - ASP.NET Identity with password encryption
- **SQL Injection Protection** - Parameterized queries and Entity Framework
- **XSS Prevention** - Input validation and output encoding
- **CSRF Protection** - Anti-forgery tokens on forms
- **Secure Payment Processing** - PCI-compliant payment handling

## 🚀 Performance Optimization

- **Caching Implementation** - Output caching for frequently accessed pages
- **Image Optimization** - Compressed product images for faster loading
- **Database Indexing** - Optimized database queries and indexing
- **Minification** - CSS and JavaScript file minification

## 🔄 Future Enhancements

- Mobile application development
- Advanced analytics and reporting
- Multi-language support
- Social media integration
- AI-powered product recommendations
- Advanced search with machine learning
