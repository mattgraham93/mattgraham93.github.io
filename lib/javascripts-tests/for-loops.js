function addToList() {
    const myList = document.getElementById('my-list');

    for (let i=0; i < 5; i++) {
        elfCode.appendToList(myList, i);
    }
}

window.onload = () => {
    const listButton = document.getElementById('run-for-loop');
    listButton.onclick = addToList;
};