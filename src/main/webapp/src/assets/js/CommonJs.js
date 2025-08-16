function showToast(message, type) {
    const toastEl = document.getElementById('errorToast');
    const toastBody = document.getElementById('toastMessage');

    toastBody.innerText = message;
    toastEl.classList.remove('bg-success', 'bg-danger');
    toastEl.classList.add(type === 'success' ? 'bg-success' : 'bg-danger');

    const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
    toast.show();
}


function togglePasswordVisibility(button) {
    const $button = $(button);
    const $input = $button.siblings('input'); // finds the input next to the button
    const $icon = $button.find('i');

    if ($input.attr('type') === 'password') {
        $input.attr('type', 'text');
        $icon.removeClass('fa-eye').addClass('fa-eye-slash');
    } else {
        $input.attr('type', 'password');
        $icon.removeClass('fa-eye-slash').addClass('fa-eye');
    }

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
}