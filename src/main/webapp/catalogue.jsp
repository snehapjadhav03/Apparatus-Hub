
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.apparatushub.CatalogueServlet.EquipmentItem" %>
<!DOCTYPE html>
<html>
<head>
    <title>ApparatusHub - Catalogue</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body { background-color: #faf9f6; color: #2d3142; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; }
        .card { background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 12px; }
        .badge-category { background-color: #f1f5f9; color: #475569; border: 1px solid #cbd5e1; }
        .btn-buy { background-color: #2e7d32; color: #ffffff; border: none; font-weight: 600; }
        .btn-buy:hover { background-color: #1b5e20; color: #ffffff; }
        .btn-rent { background-color: #5c6bc0; color: #ffffff; border: none; font-weight: 600; }
        .btn-rent:hover { background-color: #3f51b5; color: #ffffff; }
        .btn-diary { border: 1px solid #cbd5e1; color: #475569; background-color: #ffffff; font-weight: 600; }
    </style>
</head>
<body>
    <div class="container my-5">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h3 class="fw-bold mb-1" style="color: #1e293b;">ApparatusHub Inventory</h3>
                <p class="text-muted small mb-0">Laboratory Equipment Catalogue</p>
            </div>
            <a href="diary" class="btn btn-diary px-4 py-2">Equipment Diary Logs</a>
        </div>

        <div class="row">
            <%
                List<EquipmentItem> items = (List<EquipmentItem>) request.getAttribute("catalogueItems");
                if (items != null && !items.isEmpty()) {
                    for (EquipmentItem item : items) {
                        boolean isBuy = "Buy".equalsIgnoreCase(item.getListingType());
            %>
            <div class="col-md-3 mb-4">
                <div class="card h-100 shadow-sm">
                    <img src="<%= item.getImageUrl() %>" class="card-img-top" style="height: 170px; object-fit: cover; border-top-left-radius: 12px; border-top-right-radius: 12px;" alt="<%= item.getName() %>">
                    <div class="card-body">
                        <span class="badge badge-category mb-2"><%= item.getCategory() %></span>
                        <h6 class="card-title fw-bold mb-1" style="color: #0f172a;"><%= item.getName() %></h6>
                        <p class="text-muted small mb-1"><strong>Provider:</strong> <%= item.getVendorOrRenter() %></p>
                        <p class="card-text text-muted small mb-3"><%= item.getDescription() %></p>
                        <div class="d-flex justify-content-between align-items-center small text-secondary">
                            <span>ID: <strong><%= item.getId() %></strong></span>
                            <span>Stock: <strong style="color: #2e7d32;"><%= item.getQuantity() %></strong></span>
                        </div>
                    </div>
                    <div class="card-footer bg-white border-top-0 d-grid pb-3">
                        <button type="button" class="btn <%= isBuy ? "btn-buy" : "btn-rent" %> w-100" 
                                onclick="openCheckout('<%= item.getId() %>', '<%= item.getName() %>', '<%= item.getListingType() %>', '<%= item.getVendorOrRenter() %>', <%= item.getQuantity() %>)">
                            <%= item.getListingType() %> Now
                        </button>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- Requisition Checkout Modal -->
    <div class="modal fade" id="checkoutModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content" style="border-radius: 12px; border: none;">
                <form action="diary-transaction" method="post">
                    <div class="modal-header border-bottom-0">
                        <h5 class="modal-title fw-bold" id="modalTitle">Equipment Requisition</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <input type="hidden" id="modalItemId" name="itemId">
                        <input type="hidden" id="modalActionType" name="actionType">

                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Equipment Item</label>
                            <input type="text" id="modalItemName" name="itemName" class="form-control" style="background-color: #f8fafc;" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Source (Shop / College)</label>
                            <input type="text" id="modalVendor" name="vendorOrRenter" class="form-control" style="background-color: #f8fafc;" readonly>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Quantity Needed</label>
                            <input type="number" id="modalQuantity" name="quantity" class="form-control" min="1" max="10" value="1" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Faculty / Requisitioner</label>
                            <input type="text" name="userName" class="form-control" value="Samruddhi Kawatkar" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Department</label>
                            <input type="text" name="department" class="form-control" value="Computer Engineering" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small fw-bold text-secondary">Purpose / Reason</label>
                            <input type="text" name="reason" class="form-control" value="Lab Demonstration & Testing" required>
                        </div>
                    </div>
                    <div class="modal-footer border-top-0">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-buy px-4">Confirm Requisition</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function openCheckout(id, name, action, vendor, maxStock) {
            document.getElementById('modalItemId').value = id;
            document.getElementById('modalItemName').value = name;
            document.getElementById('modalActionType').value = action;
            document.getElementById('modalVendor').value = vendor;
            document.getElementById('modalQuantity').max = maxStock;
            document.getElementById('modalQuantity').value = 1;
            document.getElementById('modalTitle').innerText = action + ' Request - ' + name;
            var checkoutModal = new bootstrap.Modal(document.getElementById('checkoutModal'));
            checkoutModal.show();
        }
    </script>
</body>
</html>
