/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vector4

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 32, COPIES = 24)(
    input [WIDTH_MIN-1 : 0] in,
    output [WIDTH_MAX-1 : 0] out
);
    assign out = { { COPIES{in[WIDTH_MIN-1]} }, in};

endmodule

/* testbench with mismatch


*/
