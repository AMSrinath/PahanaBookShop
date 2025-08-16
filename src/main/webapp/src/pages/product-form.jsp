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

    String baseUrl = request.getContextPath();
    String imagePath = (inventory != null && inventory.getDefaultImage() != null && !inventory.getDefaultImage().isEmpty())
            ? baseUrl + "/" + inventory.getDefaultImage()
            : baseUrl + "/src/assets/images/uploads/default.jpg";
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
                        <button type="button" class="btn btn-outline-secondary" id="clear-btn">
                            Clear
                        </button>
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
                                    <%--                                    <img id="previewImage" src="${pageContext.request.contextPath}/src/assets/images/uploads/default.jpg"/>--%>
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

<script>
    $(document).ready(function () {
        let base64ImageData = "";
        const idParam = '<%= (idParam != null) ? idParam : "" %>';
        console.log("ID Parameter: " + idParam);
        if (idParam) {
            $('#form-title').html('<i class="fas fa-edit me-2"></i>Update Product Type');
            $('#save-btn').html('<i class="fas fa-save me-2"></i>Update');
        }

        toggleAuthorField();
        $('[name="inventoryTypeId"]').change(toggleAuthorField);

        document.getElementById("imageFile").addEventListener("change", function () {
            const file = this.files[0];
            if (!file) return;

            const reader = new FileReader();
            reader.onload = function (e) {
                base64ImageData = e.target.result;
                document.getElementById("previewImage").src = base64ImageData;
            };

            reader.readAsDataURL(file);
        });


        $("#save-btn").click(function() {
            // const formData = new FormData($("#productForm")[0]);
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

    function showToast(message, type) {
        const toastEl = document.getElementById('errorToast');
        const toastBody = document.getElementById('toastMessage');

        toastBody.innerText = message;
        toastEl.classList.remove('bg-success', 'bg-danger');
        toastEl.classList.add(type === 'success' ? 'bg-success' : 'bg-danger');

        const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
        toast.show();
    }

    $("#clear-btn").click(function() {
        $("#productForm")[0].reset();
        $("#previewImage").attr("src", "").hide();
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

</script>


<div class="toast-container position-fixed top-0 end-0 p-3" style="z-index: 9999">
    <div id="errorToast" class="toast align-items-center text-white bg-danger border-0" role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>


<%--<script>--%>
<%--    $(document).ready(function () {--%>
<%--        const imagePreview = $('#imagePreview');--%>
<%--        const imageFile = $('#imageFile');--%>
<%--        const uploadTrigger = $('#uploadTrigger');--%>
<%--        const imageUrlInput = $('#imageUrlInput');--%>
<%--        const removeImageBtn = $('#removeImageBtn');--%>

<%--        // Initialize preview--%>
<%--        function updatePreview(src) {--%>
<%--            if (src) {--%>
<%--                imagePreview.html(`<img id="previewImage" src="\${src}" alt="Preview" style="max-width: 100%; max-height: 100%;"/>`);--%>
<%--                imagePreview.css('background-color', 'transparent');--%>
<%--                imagePreview.css('border', 'none');--%>
<%--                removeImageBtn.show();--%>
<%--            } else {--%>
<%--                imagePreview.html('<i class="fas fa-image text-muted" style="font-size: 3rem;"></i>');--%>
<%--                imagePreview.css('background-color', '#f8f9fa');--%>
<%--                imagePreview.css('border', '1px dashed #ccc');--%>
<%--                removeImageBtn.hide();--%>
<%--            }--%>
<%--        }--%>

<%--        // Trigger file input click--%>
<%--        uploadTrigger.click(function () {--%>
<%--            imageFile.click();--%>
<%--        });--%>

<%--        // Handle file selection--%>
<%--        imageFile.change(function () {--%>
<%--            if (this.files && this.files[0]) {--%>
<%--                const reader = new FileReader();--%>
<%--                reader.onload = function (e) {--%>
<%--                    updatePreview(e.target.result);--%>
<%--                    imageUrlInput.val('');--%>
<%--                }--%>
<%--                reader.readAsDataURL(this.files[0]);--%>
<%--            }--%>
<%--        });--%>
<%--        --%>
<%--        removeImageBtn.click(function () {--%>
<%--            updatePreview(null);--%>
<%--            imageUrlInput.val('');--%>
<%--            imageFile.val('');--%>
<%--        });--%>


<%--        $('#save-btn').click(function () {--%>
<%--            const formData = {--%>
<%--                id: $('#id').val(),--%>
<%--                barcode: $('[name="barcode"]').val(),--%>
<%--                inventoryType: $('[name="inventoryType"]').val(),--%>
<%--                isbnNo: $('[name="isbnNo"]').val(),--%>
<%--                authorId: $('[name="authorId"]').val(),--%>
<%--                defaultImage: $('[name="defaultImage"]').val(),--%>
<%--                retailPrice: $('[name="retailPrice"]').val(),--%>
<%--                costPrice: $('[name="costPrice"]').val(),--%>
<%--                qtyHand: $('[name="qtyHand"]').val()--%>
<%--            };--%>

<%--            $.ajax({--%>
<%--                url: '${pageContext.request.contextPath}/inventory',--%>
<%--                type: 'POST',--%>
<%--                contentType: 'application/json',--%>
<%--                data: JSON.stringify(formData),--%>
<%--                success: function (response) {--%>
<%--                    if (response.success) {--%>
<%--                        window.location.href = '${pageContext.request.contextPath}/inventory';--%>
<%--                    } else {--%>
<%--                        alert('Error: ' + response.message);--%>
<%--                    }--%>
<%--                },--%>
<%--                error: function (xhr) {--%>
<%--                    alert('Error saving product: ' + xhr.responseText);--%>
<%--                }--%>
<%--            });--%>
<%--        });--%>

<%--    })--%>
<%--</script>--%>

<%@ include file="../includes/footer.jsp" %>

