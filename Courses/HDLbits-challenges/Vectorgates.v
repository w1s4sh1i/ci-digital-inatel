/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vectorgates

module top_module #(parameter WIDTH_MIN = 3, WIDTH_MAX = 6)( 
    input [WIDTH_MIN-1:0] a, b,
    output out_or_logical,
    output [WIDTH_MIN-1:0] out_or_bitwise,
    output [WIDTH_MAX-1:0] out_not
);
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;
    assign out_not[WIDTH_MIN-1:0] = ~a;
    assign out_not[WIDTH_MAX-1:WIDTH_MIN] = ~b;
    
endmodule

/* testbench with mismatch


*/
