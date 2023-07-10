window.addEventListener('DOMContentLoaded', function() {
    const elements = document.getElementsByName('elements_name');
    const checkButton = document.getElementById('button_id');

    elements.forEach(function(element) {
        element.addEventListener('dragend', function() {

            const pool = document.getElementById('elements_pool_id');


            if(pool.getElementsByClassName("element").length === 0) {
                checkButton.disabled = false;
            }
        });
    });
});
