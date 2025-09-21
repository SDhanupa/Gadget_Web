using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI.WebControls;
using System.Collections.Generic;

namespace Gadgetweb
{
    public partial class Tracker : System.Web.UI.Page
    {
        // These should match your OrderItems status values
        private static readonly string[] StatusSteps = { "PLACED", "PRINTING", "SHIPPED", "DELIVERED" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindOrdersAndItems();
        }

        private void BindOrdersAndItems()
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            int userId = Convert.ToInt32(Session["UserId"]);
            string connStr = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            DataTable ordersTable = new DataTable();
            DataTable itemsTable = new DataTable();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmdOrders = new SqlCommand(
                    "SELECT Id AS OrderId, OrderDate, TotalPrice FROM Orders WHERE UserId = @UserId ORDER BY OrderDate DESC", conn))
                {
                    cmdOrders.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmdOrders))
                    {
                        adapter.Fill(ordersTable);
                    }
                }
                using (SqlCommand cmdItems = new SqlCommand(
                    @"SELECT oi.OrderId, oi.ProductId, p.ProductName, oi.Quantity, oi.Price, oi.Status
                      FROM OrderItems oi
                      INNER JOIN Products p ON oi.ProductId = p.Id
                      INNER JOIN Orders o ON oi.OrderId = o.Id
                      WHERE o.UserId = @UserId
                      ORDER BY oi.OrderId DESC, oi.Id ASC", conn))
                {
                    cmdItems.Parameters.AddWithValue("@UserId", userId);
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmdItems))
                    {
                        adapter.Fill(itemsTable);
                    }
                }
            }

            // Prepare list of orders with their items as DataTable
            var orderList = new List<dynamic>();

            foreach (DataRow order in ordersTable.Rows)
            {
                int orderId = (int)order["OrderId"];
                DataRow[] orderItems = itemsTable.Select($"OrderId = {orderId}");
                DataTable itemsForOrder = itemsTable.Clone();
                foreach (var row in orderItems) itemsForOrder.ImportRow(row);

                orderList.Add(new
                {
                    OrderId = orderId,
                    OrderDate = order["OrderDate"],
                    TotalPrice = order["TotalPrice"],
                    Items = itemsForOrder
                });
            }

            rptOrders.DataSource = orderList;
            rptOrders.DataBind();

            for (int i = 0; i < rptOrders.Items.Count; i++)
            {
                var items = (DataTable)orderList[i].Items;
                Repeater rptItems = (Repeater)rptOrders.Items[i].FindControl("rptOrderItems");
                if (rptItems != null)
                {
                    rptItems.DataSource = items;
                    rptItems.DataBind();
                }
            }
            pnlEmptyOrders.Visible = ordersTable.Rows.Count == 0;
            rptOrders.Visible = ordersTable.Rows.Count > 0;
        }

        protected void rptOrders_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            // For future use, e.g. per-order logic
        }

        protected void rptOrderItems_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.DataItem == null) return;
            DataRowView drv = e.Item.DataItem as DataRowView;
            string status = drv["Status"].ToString();

            Literal litTracker = (Literal)e.Item.FindControl("litTrackerSteps");
            if (litTracker != null)
            {
                litTracker.Text = BuildTrackerStepsHtml(status);
            }
        }

        private string BuildTrackerStepsHtml(string currentStatus)
        {
            int statusIndex = Array.IndexOf(StatusSteps, (currentStatus ?? "").ToUpperInvariant());
            if (statusIndex < 0) statusIndex = 0;

            // Fancy, totally different tracker design
            var sb = new StringBuilder();
            sb.Append("<div class='tracker-progress-bar'>");
            for (int i = 0; i < StatusSteps.Length; i++)
            {
                string dotClass = "step-dot";
                if (i < statusIndex) dotClass += " completed";
                if (i == statusIndex) dotClass += " active";
                string icon = (i < statusIndex) ? "&#10003;" : (i + 1).ToString();

                sb.AppendFormat("<div class='{0}' aria-label='{1}' tabindex='0'>{2}</div>", dotClass, StatusSteps[i], icon);
                if (i < StatusSteps.Length - 1)
                    sb.Append("<div class='track-bar-sep'></div>");
            }
            sb.Append("</div>");

            // Step labels row
            sb.Append("<div style='display:flex;justify-content:space-between;margin:0 2px 2px 2px;'>");
            for (int i = 0; i < StatusSteps.Length; i++)
            {
                var label = StatusSteps[i].Substring(0, 1) + StatusSteps[i].Substring(1).ToLower();
                string labelClass = "step-label";
                if (i == statusIndex) labelClass += " active";
                sb.AppendFormat("<div class='{0}' style='min-width:74px'>{1}</div>", labelClass, label);
            }
            sb.Append("</div>");

            return sb.ToString();
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}
