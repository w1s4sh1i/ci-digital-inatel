/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vector1

module top_module #(parameter WIDTH_MIN = 8, WIDTH_MAX = 16)( 
	input wire [WIDTH_MAX-1:0] in,
	output wire [WIDTH_MIN-1:0] out_hi,
	output wire [WIDTH_MIN-1:0] out_lo
);
	assign out_lo = in[WIDTH_MIN-1:0];
	assign out_hi = in[WIDTH_MAX-1:WIDTH_MIN];
	// assign (out_lo, out_hi) = in; 

endmodule


/* testbench with mismatch


*/
