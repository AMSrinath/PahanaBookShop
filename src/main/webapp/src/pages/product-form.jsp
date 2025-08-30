<%@ page import="pahana.education.model.response.InventoryTypeResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.education.model.response.AuthorDataResponse" %>
<%@ page import="pahana.education.model.response.InventoryResponse" %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<%
    String pageTitle = "Product";
    String idParam = request.getParameter("id");
    InventoryResponse inventory = (InventoryResponse) request.getAttribute("inventoriesData");
    boolean isHide = (inventory != null);

    String baseUrl = request.getContextPath();
    String imagePath = (inventory != null && inventory.getDefaultImage() != null && !inventory.getDefaultImage().isEmpty())
            ? baseUrl + "/" + inventory.getDefaultImage()
            : baseUrl + "/src/assets/images/default.jpg";
%>


<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/inventory">
                        <i class="fas fa-arrow-left me-2"></i>Back to Product Types
                    </a>
                </button>
            </div>

            <div class="custom-form-view">
                <div class="form-header">
                    <h2 id="form-title"><i class="fas fa-box me-2"></i>Add New Product</h2>
                    <div class="form-buttons">
                        <% if (!isHide) { %>
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
                        <% } %>
                        <button type="button" class="btn btn-primary" id="save-btn">
                            <i class="fas fa-save me-2"></i>Save
                        </button>
                    </div>
                </div>

                <form id="productForm" method="post" enctype="multipart/form-data">
                    <div class="row">
                        <input type="hidden" name="productId" id="productId" value="<%= (inventory != null) ? inventory.getId() : "" %>">
                        <input type="hidden" name="priceListId" id="priceListId" value="<%= (inventory != null) ? inventory.getPriceListId() : "" %>">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Barcode <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="barcode"
                                   id="barcode"
                                   value="<%= (inventory != null) ? inventory.getBarcode() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Item Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="itemName"
                                   id="itemName"
                                   value="<%= (inventory != null) ? inventory.getName() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Inventory Type</label>
                            <select class="form-select" name="inventoryTypeId" required>
                                <option value="">-- Select Inventory Type --</option>
                                <%
                                    List<InventoryTypeResponse> inventoryTypes = (List<InventoryTypeResponse>) request.getAttribute("inventoryTypes");
                                    if (inventoryTypes != null) {
                                        for (InventoryTypeResponse type : inventoryTypes) {
                                            boolean isSelected = (inventory != null && inventory.getInventoryTypeId() == type.getId());
                                %>
                                <option id="inventoryTypeId" value="<%= type.getId() %>" <%= isSelected ? "selected" : "" %>><%= type.getName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Author</label>
                            <select class="form-select" name="authorId" required>
                                <option value="">-- Select Author --</option>
                                <%
                                    List<AuthorDataResponse> authorList = (List<AuthorDataResponse>) request.getAttribute("authorList");
                                    if (authorList != null) {
                                        for (AuthorDataResponse auth : authorList) {
                                            boolean isSelected = (inventory != null && inventory.getAuthorId() == auth.getId());
                                %>
                                <option value="<%= auth.getId() %>"  <%= isSelected ? "selected" : "" %>  ><%= auth.getFullName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">ISBN Number</label>
                            <input type="text" class="form-control" name="isbnNo" value="<%= (inventory != null) ? inventory.getIsbnNo() : "" %>">
                        </div>

                        <h4 class="mt-4 mb-3">Pricing & Stock</h4>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Retail Price (Rs)</label>
                            <input type="number" class="form-control" name="retailPrice" value="<%= (inventory != null) ? inventory.getRetailPrice() : "" %>">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Cost Price (Rs)</label>
                            <input type="number" class="form-control" name="costPrice" value="<%= (inventory != null) ? inventory.getCostPrice() : "" %>">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Quantity on Hand</label>
                            <input type="number" class="form-control" name="qtyHand" value="<%= (inventory != null) ? inventory.getQtyHand() : "" %>">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Product Image</label>
                            <div class="image-upload-container">
                                <div class="image-preview-form mb-3" id="imagePreview">
                                    <img id="previewImage" src="<%= imagePath %>" />
                                </div>

                                <div class="input-group mb-2">
                                    <button type="button" class="btn btn-outline-primary" id="uploadTrigger">
                                        <i class="fas fa-upload me-2"></i>Upload Image
                                    </button>
                                    <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999">
    <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        let base64ImageData = "";
        const idParam = '<%= (idParam != null) ? idParam : "" %>';
        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Product Type');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        // toggleAuthorField();
        // $('[name="inventoryTypeId"]').change(toggleAuthorField);

        const previewSrc = $("#previewImage").attr("src");

        if (previewSrc && !previewSrc.startsWith("data:image") && !previewSrc.includes("default.jpg")) {
            convertImageToBase64(previewSrc, function (base64) {
                base64ImageData = base64;
            });
        }

        $("#imageFile").on("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                base64ImageData = e.target.result;
                $("#previewImage").attr("src", base64ImageData);
            };
            reader.readAsDataURL(file);
        });

        $("#save-btn").click(function() {
            if (!validateForm()){
                return
            }
            const newFormData = {
                productId: $('[name="productId"]').val(),
                priceListId: $('[name="priceListId"]').val(),
                barcode: $('[name="barcode"]').val(),
                itemName: $('[name="itemName"]').val(),
                inventoryTypeId: $('[name="inventoryTypeId"]').val(),
                authorId: $('[name="authorId"]').val(),
                isbnNo: $('[name="isbnNo"]').val(),
                retailPrice: $('[name="retailPrice"]').val(),
                costPrice: $('[name="costPrice"]').val(),
                qtyHand: $('[name="qtyHand"]').val(),
                productImage: base64ImageData,
            };

            $.ajax({
                url: "<%= request.getContextPath() %>/inventory",
                type: "POST",
                data: JSON.stringify(newFormData),
                processData: false,
                contentType: false,
                success: function (response) {
                    if (response.code === 200) {
                        showToast(response.message, "success");
                        setTimeout(() => {
                            window.location.href = "<%= request.getContextPath() %>/inventory";
                        }, 2000);
                    } else {
                        showToast(response.message || "Something went wrong", "error");
                    }
                },
                error: function (xhr) {
                    showToast("Request failed: ","error");
                }
            });
        });
    });

    $("#clear-btn").click(function() {
        $("#productForm")[0].reset();
        $("#previewImage")
            .attr("src", "<%= request.getContextPath() %>/src/assets/images/default.jpg")
            .show();

        $(".fa-image").show();
    });

    $("#imageFile").change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $("#previewImage").attr("src", e.target.result).show();
                $(".fa-image").hide();
            }
            reader.readAsDataURL(file);
        }
    });

    $("#uploadTrigger").click(function() {
        $("#imageFile").click();
    });

    $("#removeImageBtn").click(function() {
        $("#imageFile").val("");
        $("#previewImage").attr("src", "").hide();
        $(".fa-image").show();
    });


    function toggleAuthorField() {
        const selectedText = $('[name="inventoryTypeId"] option:selected').text().toLowerCase();
        const isNovel = selectedText.includes('novel'); // Case-insensitive check

        $('[name="authorId"]').prop('disabled', !isNovel)
            .closest('.mb-3').toggleClass('field-disabled', !isNovel);

        if (!isNovel) $('[name="authorId"]').val('');
    }

    function convertImageToBase64(imageUrl, callback) {
        fetch(imageUrl)
            .then(response => response.blob())
            .then(blob => {
                const reader = new FileReader();
                reader.onloadend = function () {
                    callback(reader.result);
                };
                reader.readAsDataURL(blob);
            })
            .catch(error => {
                console.error("Failed to convert image to base64:", error);
                callback(""); // fallback if fetch fails
            });
    }

    function validateForm() {
        const barcode = $('[name="barcode"]').val();
        const itemName = $('[name="itemName"]').val();
        const inventoryTypeId = $('[name="inventoryTypeId"]').val();
        const retailPrice = $('[name="retailPrice"]').val();
        const costPrice = $('[name="costPrice"]').val();
        const qtyHand = $('[name="qtyHand"]').val();

        if (!barcode) {
            showToast("Barcode is required", "error");
            return false;
        }

        if (!itemName) {
            showToast("Item Name is required", "error");
            return false;
        }

        if (!inventoryTypeId) {
            showToast("Please select Inventory type", "error");
            return false;
        }

        if (parseFloat(retailPrice) <= 0 ) {
            showToast("Retail price is required ", "error");
            return false;
        }

        if (parseFloat(costPrice) <= 0 ) {
            showToast("Cost price is required ", "error");
            return false;
        }

        if (parseFloat(retailPrice) < parseFloat(costPrice)) {
            showToast("Retail price should be greater than or equal to Cost price", "error");
            return false;
        }

        if (qtyHand < 0 ) {
            showToast("Quantity on hand is required ", "error");
            return false;
        }
        return true;
    }

</script>

<%@ include file="../includes/footer.jsp" %>

