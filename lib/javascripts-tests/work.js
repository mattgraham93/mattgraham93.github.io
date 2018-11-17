window.onload = () => {
    var person = {
        firstName: 'Matt',
        lastName: 'Graham',

        fullName: function() {
            'use strict';
            console.log(person.firstName + ' ' + person.lastName)
        }
    };

    console.log(person);
    person.fullName();


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

    calculator.operand01 = person.firstName;
    calculator.operand02 = person.lastName;

    console.log(calculator.operand01);
    console.log(calculator.operand02);

    calculator.add();
    calculator.subtract();

    calculator.multiply = function() {
        console.log(calculator.operand01 * calculator.operand02);
    };
};
