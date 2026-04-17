/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Count15

// Module

module top_module #(parameter WIDTH = 4, Z = {WIDTH{1'b0}} )(
    input clk,
    input reset,      // Synchronous active-high reset
    output [WIDTH-1:0] q
);
	
    initial q = Z;
    
    always @(posedge clk) begin
        q <= reset ? Z : q + 1; 
        // [ ] Alternative -> WIDTH'd1 (to check); 
    end
    
endmodule

/* [ ] testbench with mismatch */
