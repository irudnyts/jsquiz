function checkOptions(button_name, radio_name, success_messages, failure_messages) {

  const radioButtons = document.getElementsByName(radio_name);
  let hasTrueValue = true;

  for (var i = radioButtons.length - 1; i >= 0; i--) {
    const radioButton = radioButtons[i];
    const text = radioButton.value === 'true' ? '✅' : '❌';
    const textElement = document.createElement('span');
    textElement.textContent = text;
    textElement.style.width = '20px';
    radioButton.parentNode.replaceChild(textElement, radioButton);

    if ((radioButton.checked && radioButton.value != 'true') || (!radioButton.checked && radioButton.value != 'false')) {
      hasTrueValue = false;
    }

  }

  const button = document.getElementById(button_name);
  const message = document.createElement('div');

  if (hasTrueValue) {

    message.textContent = success_messages[Math.floor(Math.random() * success_messages.length)];
    message.className = 'success';

  } else {
    message.textContent = failure_messages[Math.floor(Math.random() * failure_messages.length)];
    message.className = 'failure';
  }

  button.parentNode.replaceChild(message, button);

}
