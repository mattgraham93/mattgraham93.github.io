window.onload = () => {
    const simpleFunction = document.getElementById('simple-function');
    const functionCalls = document.getElementById('function-calls');

    function simple() {
        console.log('simple');
        simpleFunction.textContent = "simple";
    }

    functionCalls.onclick = simple;
}