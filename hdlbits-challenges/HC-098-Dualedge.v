/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Dualedge

// Module

module top_module (
    input clk, d,
    output q
);
    reg q1, q2;
    
    always @(posedge clk) begin
    	q1 <= d;
    end
    
    always @(negedge clk) begin
    	q2 <= d;
    end
    
    assign q = clk ? q1 : q2;
    
endmodule

/* [ ] testbench with mismatch */
