
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.apparatushub.DiaryServlet.DiaryEntry" %>
<!DOCTYPE html>
<html>
<head>
    <title>ApparatusHub - Equipment Diary</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #faf9f6; color: #2d3142; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        .card { background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; }
        .btn-catalogue { border: 1px solid #cbd5e1; color: #475569; background-color: #ffffff; font-weight: 600; }
        .badge-txn { background-color: #f1f5f9; color: #475569; border: 1px solid #cbd5e1; }
        .badge-action { background-color: #e8f5e9; color: #2e7d32; border: 1px solid #a5d6a7; }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1" style="color: #1e293b;">Equipment Requisition Diary</h3>
                <p class="text-muted small mb-0">Live MySQL Transaction Logs</p>
            </div>
            <a href="catalogue" class="btn btn-catalogue px-4 py-2">Back to Catalogue</a>
        </div>
        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table align-middle mb-0">
                    <thead>
                        <tr>
                            <th class="ps-4">Txn ID</th>
                            <th>Item ID</th>
                            <th>Item Name</th>
                            <th>Action</th>
                            <th>Qty</th>
                            <th>Requisitioner</th>
                            <th>Department</th>
                            <th class="pe-4">Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<DiaryEntry> entries = (List<DiaryEntry>) request.getAttribute("diaryEntries");
                            if (entries != null && !entries.isEmpty()) {
                                for (DiaryEntry entry : entries) {
                        %>
                        <tr>
                            <td class="ps-4"><span class="badge badge-txn"><%= entry.getTransactionId() %></span></td>
                            <td class="text-secondary small"><%= entry.getItemId() %></td>
                            <td class="fw-bold" style="color: #0f172a;"><%= entry.getItemName() %></td>
                            <td><span class="badge badge-action"><%= entry.getActionType() %></span></td>
                            <td class="fw-bold"><%= entry.getQuantity() %></td>
                            <td><%= entry.getFacultyName() %></td>
                            <td class="text-secondary"><%= entry.getDepartment() %></td>
                            <td class="pe-4 text-muted small"><%= entry.getCreatedDate() %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="text-center py-5 text-muted">No transactions logged yet. Click "Buy" or "Rent" on an item in the catalogue to log an entry.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
