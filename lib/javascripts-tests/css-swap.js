window.onload = () => {

    const appearanceButton = document.getElementById('appearanceAction');

    appearanceButton.onclick = () => {
        const defaults = document.getElementById('default');
        const basic = document.getElementById('basic');

        disableStylesheet(defaults);
        enableStylesheet(basic);
    }

}

function enableStylesheet (node) {
    node.rel = 'stylesheet';
}

function disableStylesheet (node) {
    node.rel = 'alternate stylesheet';
}