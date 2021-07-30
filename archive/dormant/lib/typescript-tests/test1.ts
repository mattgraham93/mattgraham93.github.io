interface Thing {
    a: number;
    b: string;
    foo: {
        (s: string): string;
        (n: number): number;
        data: any;
    };
    new (s: string): Element;
    [index: number]: Date;
    // foo(s: string): string;
    // foo(n: number): number;
}

interface Accumulator {
    clear() : void;
    add(a: number): void;
    result(): number;
}

function process1 (x: number) {
    var v = x + x;
    return v;
}

function process(x: Thing) {

    // return x.foo.data;
    // return new x("abc");
    // return x[0].getDate;
    return x.a;
}

function makeAccumulator(): Accumulator {
    var sum = 0;
    return {
        clear: function() { sum = 0; },
        add: function (value: number) { sum += value; },
        result: function() { return sum; }
    };
}

var a = makeAccumulator();
a.add(5);

window.onmousemove = function (e) { e.clientX; }
