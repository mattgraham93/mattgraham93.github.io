window.onload = () => {
    const feetToInchesAction = document.getElementById('feet-to-inches-action');
    const milesToFeetAction = document.getElementById('miles-to-feet-action');
    const areaOfTriangleAction = document.getElementById('area-of-triangle-action');
    const areaOfCircleAction = document.getElementById('area-of-circle-action');

    feetToInchesAction.onclick = () => {
        const feetToInchesInput = document.getElementById('feet-to-inches-input');
        const feetToInchesDisplay = document.getElementById('feet-to-inches-display');

        feetToInchesDisplay.textContent = feetToInches(feetToInchesInput.value);
    };

    milesToFeetAction.onclick = () => {
        const milesToFeetInput = document.getElementById('miles-to-feet-input');
        const milesToFeetDisplay = document.getElementById('miles-to-feet-display');

        milesToFeetDisplay.textContent = milesToFeet(milesToFeetInput.value);
    };

    areaOfTriangleAction.onclick = () => {
        const triangleWidth = document.getElementById('triangle-width');
        const triangleHeight = document.getElementById('triangle-height');
        const areaOfTriangleDisplay = document.getElementById('area-of-triangle-display');

        areaOfTriangleDisplay.textContent = areaOfTriangle(triangleWidth.value, triangleHeight.value);
    };

    areaOfCircleAction.onclick = () => {
        const areaOfCircleInput = document.getElementById('area-of-circle-input');
        const areaOfCircleDisplay = document.getElementById('area-of-circle-display');

        areaOfCircleDisplay.textContent = areaOfCircle(areaOfCircleInput.value);
    };
};

const feetToInches = (feet) => {
    return feet * 12;
};

const milesToFeet = (miles) => {
    return miles * 5280;
};

const areaOfTriangle = (base, height) => {
    return (base * height) / 2;
};

const areaOfCircle = (radius) => {
    return Math.PI * (radius * radius);
};