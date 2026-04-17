/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Mt2015_muxdff

// Module

module top_module (
	input clk, L, r_in, q_in,
	output reg Q
);
    always @(posedge clk) begin
        Q <= L ? r_in : q_in;
    end
    
endmodule

/* testbench with mismatch


*/
