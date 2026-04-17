/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Module

module top_module ( 
    input a, b, 
    output out
);
    mod_a instance1 ( .in1(a), .in2(b), .out(out) );

endmodule


/* testbench with mismatch


*/
