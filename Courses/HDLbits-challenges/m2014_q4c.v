/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/m2014_q4c
module top_module (
    input clk,
    input d, 
    input r,   // synchronous reset
    output q
);
    always @(posedge clk) begin
    	q <= d & ~r; // q <= r ? 1'b0: d; 	
    end

endmodule

/* testbench with mismatch


*/
