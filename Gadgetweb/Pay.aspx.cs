using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Gadgetweb
{
    public partial class Pay : Page
    {
        private DataTable OrderItems
        {
            get => ViewState["OrderItems"] as DataTable;
            set => ViewState["OrderItems"] = value;
        }

        private decimal OrderTotal
        {
            get => ViewState["OrderTotal"] != null ? (decimal)ViewState["OrderTotal"] : 0m;
            set => ViewState["OrderTotal"] = value;
        }

        private string Username
        {
            get => ViewState["Username"] as string ?? "";
            set => ViewState["Username"] = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                LoadOrderSummary();
            }
            else
            {
                if (OrderItems != null)
                {
                    rptOrderItems.DataSource = OrderItems;
                    rptOrderItems.DataBind();
                    lblTotal.Text = OrderTotal.ToString("F2");
                }
            }
        }

        private void LoadOrderSummary()
        {
            int userId = Convert.ToInt32(Session["UserId"]);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            DataTable dt = new DataTable();

            string sql = @"SELECT p.ProductName, ci.Quantity, ci.Price, (ci.Quantity * ci.Price) AS Subtotal 
                           FROM CartItems ci INNER JOIN Products p ON ci.ProductId = p.Id WHERE ci.UserId = @UserId";
            string usernameValue = "";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(dt);
                    }
                }
                using (SqlCommand userCmd = new SqlCommand("SELECT Username FROM Users WHERE Id=@UserId", conn))
                {
                    userCmd.Parameters.AddWithValue("@UserId", userId);
                    using (var reader = userCmd.ExecuteReader())
                    {
                        if (reader.Read())
                            usernameValue = reader["Username"]?.ToString() ?? "";
                    }
                }
            }

            OrderItems = dt;
            Username = usernameValue;

            decimal total = 0m;
            foreach (DataRow row in dt.Rows)
            {
                if (row["Subtotal"] != DBNull.Value)
                    total += Convert.ToDecimal(row["Subtotal"]);
            }
            lblTotal.Text = total.ToString("F2");
            OrderTotal = total;
            txtUsername.Text = usernameValue;

            rptOrderItems.DataSource = dt;
            rptOrderItems.DataBind();
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            lblMessage.CssClass = "";
            lblMessage.Text = "";

            if (OrderItems == null || OrderItems.Rows.Count == 0)
            {
                lblMessage.CssClass = "feedback-error";
                lblMessage.Text = "Nothing to pay for, cart is empty.";
                return;
            }

            if (string.IsNullOrWhiteSpace(txtCardNumber.Text) ||
                string.IsNullOrWhiteSpace(txtNameOnCard.Text) ||
                string.IsNullOrWhiteSpace(txtExpiryDate.Text))
            {
                lblMessage.CssClass = "feedback-error";
                lblMessage.Text = "All payment fields are required.";
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            int orderId = 0;
            bool paymentSuccess = false;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlTransaction txn = conn.BeginTransaction())
                {
                    try
                    {
                        // Insert main order
                        string insertOrderSql = "INSERT INTO Orders (UserId, OrderDate, TotalPrice) VALUES (@UserId, GETDATE(), @TotalPrice); SELECT CAST(SCOPE_IDENTITY() AS INT)";
                        using (SqlCommand cmdOrder = new SqlCommand(insertOrderSql, conn, txn))
                        {
                            cmdOrder.Parameters.AddWithValue("@UserId", userId);
                            cmdOrder.Parameters.AddWithValue("@TotalPrice", OrderTotal);
                            orderId = (int)cmdOrder.ExecuteScalar();
                        }
                        // Order items + inventory
                        foreach (DataRow row in OrderItems.Rows)
                        {
                            string prodName = row["ProductName"].ToString();
                            int quantity = Convert.ToInt32(row["Quantity"]);
                            decimal price = Convert.ToDecimal(row["Price"]);
                            // Get productId (assuming ProductName is unique)
                            int productId = 0;
                            using (SqlCommand findProd = new SqlCommand("SELECT Id FROM Products WHERE ProductName = @ProductName", conn, txn))
                            {
                                findProd.Parameters.AddWithValue("@ProductName", prodName);
                                var res = findProd.ExecuteScalar();
                                if (res != null) productId = Convert.ToInt32(res);
                            }
                            using (SqlCommand cmdItem = new SqlCommand(
                                "INSERT INTO OrderItems (OrderId, ProductId, Quantity, Price, Status) VALUES (@OrderId, @ProductId, @Quantity, @Price, 'PLACED')",
                                conn, txn))
                            {
                                cmdItem.Parameters.AddWithValue("@OrderId", orderId);
                                cmdItem.Parameters.AddWithValue("@ProductId", productId);
                                cmdItem.Parameters.AddWithValue("@Quantity", quantity);
                                cmdItem.Parameters.AddWithValue("@Price", price);
                                cmdItem.ExecuteNonQuery();
                            }
                            using (SqlCommand cmdStock = new SqlCommand(
                                "UPDATE Products SET Quantity = Quantity - @Quantity WHERE Id = @ProductId AND Quantity >= @Quantity", conn, txn))
                            {
                                cmdStock.Parameters.AddWithValue("@Quantity", quantity);
                                cmdStock.Parameters.AddWithValue("@ProductId", productId);
                                int affected = cmdStock.ExecuteNonQuery();
                                if (affected == 0)
                                    throw new Exception($"Not enough stock for {prodName}");
                            }
                        }
                        using (SqlCommand clearCart = new SqlCommand("DELETE FROM CartItems WHERE UserId = @UserId", conn, txn))
                        {
                            clearCart.Parameters.AddWithValue("@UserId", userId);
                            clearCart.ExecuteNonQuery();
                        }
                        txn.Commit();
                        paymentSuccess = true;
                    }
                    catch (Exception ex)
                    {
                        txn.Rollback();
                        lblMessage.CssClass = "feedback-error";
                        lblMessage.Text = "Payment failed: " + ex.Message;
                        paymentSuccess = false;
                    }
                }
            }
            if (paymentSuccess)
            {
                lblMessage.CssClass = "feedback-confirm";
                lblMessage.Text = "Payment successful! Downloading your receipt...";
                GeneratePdfAndSend(OrderItems, txtNameOnCard.Text.Trim(), Username, OrderTotal);
            }
        }

        private void GeneratePdfAndSend(DataTable items, string cardName, string username, decimal total)
        {
            using (var ms = new MemoryStream())
            {
                var doc = new Document(PageSize.A4);
                var writer = PdfWriter.GetInstance(doc, ms);
                doc.Open();

                var titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 22, BaseColor.DARK_GRAY);
                var headerFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.DARK_GRAY);
                var regularFont = FontFactory.GetFont(FontFactory.HELVETICA, 12);

                doc.Add(new Paragraph("TechNest Receipt", titleFont) { Alignment = Element.ALIGN_CENTER });
                doc.Add(new Paragraph($"Checkout Date: {DateTime.Now:yyyy-MM-dd HH:mm}", regularFont));
                doc.Add(new Paragraph($"Customer: {username}", regularFont));
                doc.Add(new Paragraph($"Paid by Cardholder: {cardName}", regularFont));
                doc.Add(Chunk.NEWLINE);

                PdfPTable table = new PdfPTable(4) { WidthPercentage = 95 };
                table.SetWidths(new float[] { 4f, 1f, 2f, 2f });
                table.AddCell(new PdfPCell(new Phrase("Item", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Qty", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Unit Price", headerFont)));
                table.AddCell(new PdfPCell(new Phrase("Subtotal", headerFont)));
                foreach (DataRow row in items.Rows)
                {
                    table.AddCell(new PdfPCell(new Phrase(row["ProductName"].ToString(), regularFont)));
                    table.AddCell(new PdfPCell(new Phrase(row["Quantity"].ToString(), regularFont)));
                    table.AddCell(new PdfPCell(new Phrase($"${row["Price"]:0.00}", regularFont)));
                    table.AddCell(new PdfPCell(new Phrase($"${row["Subtotal"]:0.00}", regularFont)));
                }
                PdfPCell totalCell = new PdfPCell(new Phrase("Total", headerFont)) { Colspan = 3, HorizontalAlignment = Element.ALIGN_RIGHT };
                table.AddCell(totalCell);
                table.AddCell(new PdfPCell(new Phrase($"${total:0.00}", headerFont)));
                doc.Add(table);

                doc.Add(Chunk.NEWLINE);
                doc.Add(new Paragraph("Thank you for shopping at TechNest!", regularFont));
                doc.Close();

                byte[] pdfBytes = ms.ToArray();
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("Content-Disposition", $"attachment; filename=TechNest_Receipt_{DateTime.Now:yyyyMMddHHmmss}.pdf");
                Response.BinaryWrite(pdfBytes);
                Response.Flush();
                Response.End();
            }
        }

        protected void btnDownloadCsv_Click(object sender, EventArgs e)
        {
            if (OrderItems == null || OrderItems.Rows.Count == 0)
            {
                lblMessage.CssClass = "feedback-error";
                lblMessage.Text = "No order data to export.";
                return;
            }
            var csv = new System.Text.StringBuilder();
            csv.AppendLine("Product,Quantity,Unit Price,Subtotal");
            foreach (DataRow row in OrderItems.Rows)
                csv.AppendLine($"\"{row["ProductName"]}\",{row["Quantity"]},{row["Price"]},{row["Subtotal"]}");

            Response.Clear();
            Response.ContentType = "text/csv";
            Response.AddHeader("Content-Disposition", $"attachment; filename=Order_{DateTime.Now:yyyyMMddHHmmss}.csv");
            Response.Write(csv.ToString());
            Response.End();
        }

        protected void btnGoToCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }
    }
}
