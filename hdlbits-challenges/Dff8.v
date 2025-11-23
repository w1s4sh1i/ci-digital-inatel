/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Dff8

// Apenas o ffd já seria uma boa resposta.

module ffd (
    	input clk, d,
        output q
);
    always @(posedge clk) begin
        q <= d;
    end 
    
endmodule

module top_module (
    input clk,
    input [7:0] d,
    output [7:0] q
);
    genvar i;
    generate
        for (i = 0; i < 8; i = i + 1) begin : block_gen
            ffd (clk, d[i], q[i]);
        end
    endgenerate
    
endmodule

/* testbench with mismatch


*/
