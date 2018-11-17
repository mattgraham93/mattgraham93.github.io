window.onload = () => {
    var person = {
        firstName: 'Matt',
        lastName: 'Graham',

        fullName: function() {
            'use strict';
            console.log(person.firstName + ' ' + person.lastName)
        }
    };

    var calculator = {
       operand01: -1,
       operand02: -1,

        add: function() {
           'use strict';
           console.log(calculator.operand01 + calculator.operand02);
        },

        subtract: function() {
           'use strict';
           console.log(calculator.operand01 - calculator.operand02);
        },
    };

    calculator.multiply = function() {
        console.log(calculator.operand01 * calculator.operand02);
    };

    console.log(person.firstName);
    console.log(person.lastName);
    person.fullName();

    calculator.operand01 = person.firstName.length;
    calculator.operand02 = person.lastName.length;

    console.log(calculator.operand01);
    console.log(calculator.operand02);

    calculator.add();
    calculator.subtract();

};
