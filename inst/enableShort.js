window.addEventListener('DOMContentLoaded', function() {
    const inputElement = document.getElementById("input_id");
    const buttonElement = document.getElementById("button_id");

    inputElement.addEventListener("input", function () {
        const inputValue = inputElement.value.trim();
        buttonElement.disabled = inputValue === "";
    });
});
