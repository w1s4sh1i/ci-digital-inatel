/*
Program: HDLbits challenges <https://hdlbits.01xz.net/wiki/Main_Page>
Development: André Bezerra <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/<challenge title>

// Vector1
module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 16)( 
	input wire [WIDTH_MAX-1:0] in,
	output wire [WIDTH_MIN-1:0] out_hi,
	output wire [WIDTH_MIN-1:0] out_lo
);
	assign out_lo = in[WIDTH_MIN-1:0];
	assign out_hi = in[WIDTH_MAX-1:WIDTH_MIN];
	// assign (out_lo, out_hi) = in; 
endmodule

// Vector2

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 32)( 
    input [WIDTH_MAX-1:0] in,
    output [WIDTH_MAX-1:0] out
);//
	
    assign out[4*WIDTH_MIN - 1 : 3*WIDTH_MIN ] = in[1*WIDTH_MIN -1 : 0*WIDTH_MIN];
    assign out[3*WIDTH_MIN - 1 : 2*WIDTH_MIN ] = in[2*WIDTH_MIN -1 : 1*WIDTH_MIN];
    assign out[2*WIDTH_MIN - 1 : 1*WIDTH_MIN ] = in[3*WIDTH_MIN -1 : 2*WIDTH_MIN];
    assign out[1*WIDTH_MIN - 1 : 0*WIDTH_MIN ] = in[4*WIDTH_MIN -1 : 3*WIDTH_MIN];
    /*
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8] = in[23:16];
    assign out[7:0] = in[31:24];
    */

endmodule

// Vectorgates

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

// Gates4

module top_module( 
    input [3:0] in,
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

// 
