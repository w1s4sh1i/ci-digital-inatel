/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vector2

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 32)( 
    input [WIDTH_MAX-1:0] in,
    output [WIDTH_MAX-1:0] out
);
	
    assign out[4*WIDTH_MIN -1 : 3*WIDTH_MIN ] = in[1*WIDTH_MIN -1 : 0*WIDTH_MIN];
    assign out[3*WIDTH_MIN -1 : 2*WIDTH_MIN ] = in[2*WIDTH_MIN -1 : 1*WIDTH_MIN];
    assign out[2*WIDTH_MIN -1 : 1*WIDTH_MIN ] = in[3*WIDTH_MIN -1 : 2*WIDTH_MIN];
    assign out[1*WIDTH_MIN -1 : 0*WIDTH_MIN ] = in[4*WIDTH_MIN -1 : 3*WIDTH_MIN];
    /*
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8] = in[23:16];
    assign out[7:0] = in[31:24];
    */

endmodule

/* testbench with mismatch


*/
