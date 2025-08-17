function showToast(message, type) {
    const toastEl = document.getElementById('errorToast');
    const toastBody = document.getElementById('toastMessage');

    toastBody.innerText = message;
    toastEl.classList.remove('bg-success', 'bg-danger');
    toastEl.classList.add(type === 'success' ? 'bg-success' : 'bg-danger');

    const toast = new bootstrap.Toast(toastEl, { delay: 3000 });
    toast.show();
}


