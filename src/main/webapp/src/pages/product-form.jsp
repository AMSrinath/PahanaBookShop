<%@ page import="pahana.education.model.response.InventoryTypeResponse" %>
<%@ page import="java.util.List" %>
<%@ page import="pahana.education.model.response.AuthorDataResponse" %>
<% String pageTitle = "Add Product"; %>
<%@ include file="../includes/header.jsp" %>
<%@ include file="../includes/dashboard-sidebar.jsp" %>

<div class="main-content">
    <%@ include file="../includes/dashboard-header.jsp" %>
    <div class="view active" id="dashboard-view">
        <div class="container-fluid">
            <div class="action-header">
                <button id="" class="btn btn-primary">
                    <a href="${pageContext.request.contextPath}/src/pages/product-list.jsp">
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

                <form id="productForm" action=""  enctype="multipart/form-data">
                    <div class="row">
                        <input type="hidden" id="id" name="id" value="">

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Barcode <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="barcode"  value="" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Item Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="itemName"  value="" required>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Inventory Type</label>
                            <select class="form-select" name="inventoryTypeId" required>
                                <option value="">-- Select Inventory Type --</option>
                                <%
                                    List<InventoryTypeResponse> inventoryTypes = (List<InventoryTypeResponse>) request.getAttribute("inventoryTypes");
                                    if (inventoryTypes != null) {
                                        for (InventoryTypeResponse type : inventoryTypes) {
                                %>
                                <option value="<%= type.getId() %>"><%= type.getName() %></option>
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
                                %>
                                <option value="<%= auth.getId() %>"><%= auth.getFullName() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">ISBN Number</label>
                            <input type="text" class="form-control" name="isbnNo" value="">
                        </div>

                        <h4 class="mt-4 mb-3">Pricing & Stock</h4>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Retail Price (Rs)</label>
                            <input type="number" class="form-control" name="retailPrice" value="">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Cost Price (Rs)</label>
                            <input type="number" class="form-control" name="costPrice" value="">
                        </div>

                        <div class="col-md-4 mb-3">
                            <label class="form-label">Quantity on Hand</label>
                            <input type="number" class="form-control" name="qtyHand" value="">
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label">Product Image</label>
                            <div class="image-upload-container">
                                <%-- Preview container --%>
                                <%--                                <div class="image-preview-form mb-3" id="imagePreview">--%>
                                <%--                                    <% if (inventory != null && inventory.getDefaultImage() != null && !inventory.getDefaultImage().isEmpty()) { %>--%>
                                <%--                                    <img id="previewImage" src="<%= inventory.getDefaultImage() %>"--%>
                                <%--                                         alt="Preview" style="max-width: 100%; max-height: 100%;"/>--%>
                                <%--                                    <% } else { %>--%>
                                <%--                                    <i class="fas fa-image text-muted" style="font-size: 3rem;"></i>--%>
                                <%--                                    <% } %>--%>
                                <%--                                </div>--%>

                                <div class="image-preview-form mb-3" id="imagePreview">
                                    <img id="previewImage" src="${pageContext.request.contextPath}/src/assets/images/uploads/default.jpg"/>
                                </div>

                                <div class="input-group mb-2">
                                    <button type="button" class="btn btn-outline-primary" id="uploadTrigger">
                                        <i class="fas fa-upload me-2"></i>Upload Image
                                    </button>
                                    <input type="file" class="form-control" id="imageFile" name="imageFile" accept="image/*" style="display: none;">
                                </div>

<%--                                    <div class="mt-2">--%>
<%--                                        <button type="button" class="btn btn-sm btn-outline-danger" id="removeImageBtn"--%>
<%--                                                style="">--%>
<%--                                            &lt;%&ndash; style="<%= (inventory == null || inventory.getDefaultImage() == null || inventory.getDefaultImage().isEmpty()) ? "display: none;" : "" %>">&ndash;%&gt;--%>
<%--                                            <i class="fas fa-trash me-1"></i> Remove Image--%>
<%--                                        </button>--%>
<%--                                    </div>--%>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<script>
    $(document).ready(function() {
        const errorToast = new bootstrap.Toast(document.getElementById('errorToast'));

        // Show validation error
        function showError(message) {
            $('#toastMessage').text(message);
            errorToast.show();
        }

        // Field validation
        function validateField(selector, message) {
            const $field = $(selector);
            let isValid = true;

            if ($field.prop('required')) {
                if ($field.is('select') && $field.val() === '') {
                    $field.addClass('is-invalid');
                    showError(message);
                    isValid = false;
                } else if ($field.is('input') && !$field.val().trim()) {
                    $field.addClass('is-invalid');
                    showError(message);
                    isValid = false;
                }
            }

            // Special validation for author when novels selected
            if (selector === '[name="authorId"]') {
                const isNovel = $('[name="inventoryTypeId"] option:selected').text().toLowerCase().includes('novel');
                if (isNovel && $field.val() === '') {
                    $field.addClass('is-invalid');
                    showError(message);
                    isValid = false;
                }
            }

            return isValid;
        }

        // Validate all fields
        function validateForm() {
            let isValid = true;

            // Clear previous errors
            $('.is-invalid').removeClass('is-invalid');

            // Validate required fields
            isValid &= validateField('[name="barcode"]', 'Please enter a barcode');
            isValid &= validateField('[name="itemName"]', 'Please enter an item name');
            isValid &= validateField('[name="inventoryTypeId"]', 'Please select an inventory type');
            isValid &= validateField('[name="authorId"]', 'Please select an author for novels');

            // Validate numeric fields
            const numericFields = [
                {selector: '[name="retailPrice"]', message: 'Retail price must be a positive number'},
                {selector: '[name="costPrice"]', message: 'Cost price must be a positive number'},
                {selector: '[name="qtyHand"]', message: 'Quantity must be a positive integer'}
            ];

            numericFields.forEach(field => {
                const value = $(field.selector).val();
                if (value && (isNaN(value) || parseFloat(value) <= 0)) {
                    $(field.selector).addClass('is-invalid');
                    showError(field.message);
                    isValid = false;
                }
            });
            return isValid;
        }

        $('input, select').on('input change', function() {
            $(this).removeClass('is-invalid');
        });


        //save button
        $("#save-btn").click(function() {
            if (!validateForm()) return;

            const formData = new FormData($("#productForm")[0]);
            $.ajax({
                url: "${pageContext.request.contextPath}/inventory",
                type: "POST",
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    if(response.code === 200) {
                        alert(response.message);
                    }
                },
                error: function(xhr) {
                    alert("Request failed: " + xhr.statusText);
                }
            });
        });

        //clear button
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

///////////////////////////////////////////////////
        function toggleAuthorField() {
            const selectedText = $('[name="inventoryTypeId"] option:selected').text().toLowerCase();
            const isNovel = selectedText.includes('novel'); // Case-insensitive check

            $('[name="authorId"]').prop('disabled', !isNovel)
                .closest('.mb-3').toggleClass('field-disabled', !isNovel);

            if (!isNovel) $('[name="authorId"]').val('');
        }

        // Initialize and bind events
        toggleAuthorField();
        $('[name="inventoryTypeId"]').change(toggleAuthorField);
    });


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

