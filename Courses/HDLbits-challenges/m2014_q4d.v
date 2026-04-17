/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/m2014_q4d

module top_module (
    input clk,
    input in, 
    output out
);
    wire d; 
    
    assign d = in ^ out;
    
    always @(posedge clk) begin
    	out <= d;  
    end 

endmodule


/* testbench with mismatch


*/
