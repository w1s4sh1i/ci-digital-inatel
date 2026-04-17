/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Edgedetect2

// Module

module top_module (
    input clk,
    input [7:0] in,
    output [7:0] anyedge
);

    reg [7:0] reg_in;
    
    always @(posedge clk) begin
        anyedge <= in ^ reg_in;
        reg_in <= in;
    end
endmodule

/* [ ] testbench with mismatch */
