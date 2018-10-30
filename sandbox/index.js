window.onload = () => {

    const setTextButton = document.getElementById('set-text');
    const userInput = document.getElementById('list-data');
    const listButton = document.getElementById('add-to-list');

    setTextButton.onclick = () => {
        userInput.value = 'The first item for my list';
    };

    listButton.onclick = () => {
        const myList = document.getElementById('my-list');
        elfCode.appendToList(myList, userInput.value);
    }
};

/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function openNav() {
    document.getElementById("mySidenav").style.width = "250px";
    document.getElementsByClassName("menuLeft")[0].style.display = "none";
    // document.getElementById('main').style.marginLeft = "25%";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0 */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementsByClassName("menuLeft")[0].style.display = "null";
    // document.getElementById("main").style.marginLeft = "25%";
}

