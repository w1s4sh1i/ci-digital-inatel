/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Edgedetect

// Module

module top_module(
	input clk,
	input [7:0] in,
	output reg [7:0] pedge
);
	
    reg [7:0] reg_in;
			
	always @(posedge clk) begin
        pedge <= in & ~ reg_in;	// [x] A positive edge occurred if input was 0 and is now 1.
        reg_in <= in;			// [x] Remember the state of the previous cycle
	end
	
endmodule

/* [ ] testbench with mismatch */
