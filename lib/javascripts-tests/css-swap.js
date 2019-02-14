window.onload = () => {

    const appearanceButton = document.getElementById('appearanceAction');
    const appearanceButton2 = document.getElementById('appearanceAction2');

    appearanceButton.onclick = () => {
        const defaults = document.getElementById('default');
        const basic = document.getElementById('basic');
        console.log('clicked');
        disableStylesheet(defaults);
        enableStylesheet(basic);
    };

    appearanceButton2.onclick = () => {
        const defaults = document.getElementById('default');
        const basic = document.getElementById('basic');

        disableStylesheet(basic);
        enableStylesheet(defaults);
    }

};

function enableStylesheet (node) {
    node.rel = 'stylesheet';
}

function disableStylesheet (node) {
    node.rel = 'alternate stylesheet';
}