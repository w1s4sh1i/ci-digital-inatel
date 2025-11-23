/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vector3

module top_module #(parameter WIDTH_MIN = 5, WIDTH_MAX = 8, ADDITION = 2'b11)(
    input [WIDTH_MIN - 1:0] a, b, c, d, e, f,
    output [WIDTH_MAX - 1:0] w, x, y, z 
);
    assign {w, x, y, z} = {a, b, c, d, e, f, ADDITION};

endmodule


/* testbench with mismatch


*/
