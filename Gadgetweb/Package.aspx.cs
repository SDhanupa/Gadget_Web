using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GadgetWeb
{
    public partial class Package : Page
    {
        private static readonly string[] StatusSteps = { "PLACED", "PRINTING", "SHIPPED", "DELIVERED" };
        private readonly string connString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserId"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
                BindOrdersAndItems();
            }
        }

        private void BindOrdersAndItems()
        {
            int sellerId = GetSellerId();

            DataTable ordersTable = new DataTable();
            DataTable itemsTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

              
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT DISTINCT o.Id AS OrderId, o.UserId, o.OrderDate, o.TotalPrice
                    FROM Orders o
                    INNER JOIN OrderItems oi ON o.Id = oi.OrderId
                    INNER JOIN Products p ON oi.ProductId = p.Id
                    WHERE p.UserId = @SellerId
                    ORDER BY o.OrderDate DESC", conn))
                {
                    cmd.Parameters.AddWithValue("@SellerId", sellerId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(ordersTable);
                    }
                }

           
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT oi.Id AS OrderItemId, oi.OrderId, oi.ProductId, p.ProductName, oi.Quantity, oi.Price, oi.Status
                    FROM OrderItems oi
                    INNER JOIN Products p ON oi.ProductId = p.Id
                    WHERE p.UserId = @SellerId
                    ORDER BY oi.OrderId DESC, oi.Id ASC", conn))
                {
                    cmd.Parameters.AddWithValue("@SellerId", sellerId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        da.Fill(itemsTable);
                    }
                }
            }

            var orderList = new List<dynamic>();
            foreach (DataRow orderRow in ordersTable.Rows)
            {
                int orderId = (int)orderRow["OrderId"];
                DataRow[] filteredItems = itemsTable.Select($"OrderId = {orderId}");

                DataTable dtItems = itemsTable.Clone();
                foreach (var row in filteredItems)
                {
                    dtItems.ImportRow(row);
                }

                orderList.Add(new
                {
                    OrderId = orderId,
                    UserId = orderRow["UserId"],
                    OrderDate = orderRow["OrderDate"],
                    TotalPrice = orderRow["TotalPrice"],
                    Items = dtItems
                });
            }

            rptOrders.DataSource = orderList;
            rptOrders.DataBind();

            for (int i = 0; i < rptOrders.Items.Count; i++)
            {
                var rptOrderItems = (Repeater)rptOrders.Items[i].FindControl("rptOrderItems");
                var items = ((dynamic)orderList[i]).Items as DataTable;
                if (rptOrderItems != null && items != null)
                {
                    rptOrderItems.DataSource = items;
                    rptOrderItems.DataBind();
                }
            }
        }

        // *** Added event handler stub to fix compilation error ***
        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // No extra logic necessary now
        }

        protected void rptOrderItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem)
                return;

            DataRowView dataItem = e.Item.DataItem as DataRowView;
            if (dataItem == null) return;

            string status = dataItem["Status"]?.ToString() ?? "PLACED";
            Literal litTracker = (Literal)e.Item.FindControl("litTracker");
            if (litTracker != null)
                litTracker.Text = BuildTrackerHtml(status);
        }

        protected void rptOrderItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "ChangeStatus")
                return;

            string[] args = (e.CommandArgument as string)?.Split('|');
            if (args == null || args.Length != 2)
                return;

            if (!int.TryParse(args[0], out int orderItemId))
                return;

            string currentStatus = args[1].ToUpperInvariant();
            int currentIndex = Array.IndexOf(StatusSteps, currentStatus);
            if (currentIndex < 0 || currentIndex >= StatusSteps.Length - 1)
                return; // Already at last status or invalid

            string nextStatus = StatusSteps[currentIndex + 1];
            UpdateOrderItemStatus(orderItemId, nextStatus);

            BindOrdersAndItems();
        }

        private void UpdateOrderItemStatus(int orderItemId, string newStatus)
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("UPDATE OrderItems SET Status = @Status WHERE Id = @Id", conn))
                {
                    cmd.Parameters.AddWithValue("@Status", newStatus);
                    cmd.Parameters.AddWithValue("@Id", orderItemId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private string BuildTrackerHtml(string currentStatus)
        {
            int currentStep = Array.IndexOf(StatusSteps, currentStatus);
            if (currentStep < 0) currentStep = 0;

            var sb = new StringBuilder();
            for (int i = 0; i < StatusSteps.Length; i++)
            {
                bool done = i < currentStep;
                bool current = i == currentStep;

                sb.Append("<div class='tracker-step'>");
                sb.Append($"<div class='circle {(done || current ? "completed" : "")}'>");

                if (done)
                    sb.Append("<span class='tick' aria-hidden='true'>&#10003;</span>");
                else
                    sb.Append(i + 1);

                sb.Append("</div>");
                sb.Append($"<div class='step-label {(current ? "current" : "")}'>");
                sb.Append(StatusSteps[i]);
                sb.Append("</div>");
                sb.Append("</div>");

                if (i < StatusSteps.Length - 1)
                {
                    sb.Append("<div class='tracker-step' style='flex:0;flex-grow:0;width:25%;background:#2563eb;height:4px;margin-top:18px;'></div>");
                }
            }

            return sb.ToString();
        }

        private int GetSellerId()
        {
            if (Session["UserId"] != null)
                return (int)Session["UserId"];
            return 1; // fallback for testing or development
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
