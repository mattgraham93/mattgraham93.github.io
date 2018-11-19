function loader() {
    const simpleObjectAction = document.getElementById('simple-object-action');
    const functionObjectAction = document.getElementById('function-object-action');
    const customClassAction = document.getElementById('custom-class-action');

    const simpleObject = {
        name: 'Simple object',

        sayName: function () {
            return this.name;
        }
    };

    const FunctionObject = {
        functionObject: 'This is a function object',

        sayName: function () {
            return this.functionObject;
        }
    };

    const privateFunction = {
        privateFunction: 'Private function',

        sayName: function () {
            return this.privateFunction;
        }
    };

    class CustomClass {
        static sayName() {
            return 'Custom class';
        }
    }

    simpleObjectAction.onclick = () => {
        const simpleObjectDisplay = document.getElementById('simple-object-display');
        console.log(simpleObject.sayName());

        simpleObjectDisplay.textContent = simpleObject.sayName();
    };

    functionObjectAction.onclick = () => {
        const functionObjectDisplay = document.getElementById('function-object-display');
        let displayName = new FunctionObject.sayName();
        console.log(displayName);
        functionObjectDisplay.textContent = displayName;
    };

    customClassAction.onclick = () => {
        const customClassDisplay = document.getElementById('custom-class-display');
        let customClass = new CustomClass.sayName();
        console.log(customClass);
        customClassDisplay.textContent = simpleObject.sayName();
    };

    simpleObject.sayName();
    new privateFunction.sayName();
    console.log(CustomClass.sayName());
}

window.onload = loader;



