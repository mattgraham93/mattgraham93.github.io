function showMessage(message) {
    console.log("==============");
    console.log("==="+message);
    console.log("==============");
}

showMessage("Operation functions");
let result = 1 + 2 * 3;
console.log(result);

result = (1 + 2) * 3;
console.log(result);


showMessage("For loops");
for (let i = 0; i < 7; i++) {
    console.log(i);
}