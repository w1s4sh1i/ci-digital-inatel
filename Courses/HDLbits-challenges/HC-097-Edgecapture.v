/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Edgecapture

// Module

module top_module #(parameter WIDTH = 32)( 
    input clk, reset,
    input [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
    reg [WIDTH-1:0] reg_in;
    
    always @(posedge clk) begin
        // out <= reset ? {WIDTH{1'b0}} : ~ (~ reg_in | in ) | out; // p -> q
        out <= reset ? {WIDTH{1'b0}} : (reg_in & ~ in ) | out; 
        reg_in <= in;
    end
    
endmodule

/* [ ] testbench with mismatch */
