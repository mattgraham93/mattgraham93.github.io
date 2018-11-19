window.onload = () => {
    const objectLiteralAction = document.getElementById('object-literal-action');

    objectLiteralAction.onclick = () => {
        const objectLiteralDisplay = document.getElementById('object-literal-display');
        console.log(objectLiteral.sayName());

        objectLiteralDisplay.textContent = objectLiteral.sayName();
    };

    const number = [2, 1, 3];
    const numberAction = document.getElementById('numbers-action');

    numberAction.onclick = () => {
      const numberDisplay = document.getElementById('numbers-display');
      console.log(number);

      numberDisplay.textContent = number.toString();
    };

    const objectLiteral = {
        objectName: 'Object literal is my name',

        sayName: function() {
            return this.objectName;
        }
    }
};