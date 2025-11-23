/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Gates4

module top_module #(parameter WIDTH = 4)( 
    input [WIDTH-1:0] in,
    output out_and,
    output out_or,
    output out_xor
);
    // and a1 (out_and, in[0], in[1], in[2], in[3]);
    assign out_and = &in;  
    // or o1 (out_or, in[0], in[1], in[2], in[3]);
    assign out_or = |in;
    // xor xr1 (out_xor, in[0], in[1], in[2], in[3]);
    assign out_xor = ^in;
    
endmodule

/* testbench with mismatch


*/
