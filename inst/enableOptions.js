window.addEventListener('DOMContentLoaded', function() {
    const radioButtons = document.getElementsByName('options_ids');
    const submitButton = document.getElementById('button_id');

    radioButtons.forEach(function(radioButton) {
      radioButton.addEventListener('change', function() {
        submitButton.disabled = false;
      });
    });
});
