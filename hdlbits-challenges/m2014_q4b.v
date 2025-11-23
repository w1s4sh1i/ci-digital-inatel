/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/m2014_q4b
module top_module (
    input clk,
    input d, 
    input ar,   // asynchronous reset
    output q
);

    always @(posedge clk or posedge ar) begin 
        q <= ar ? 1'b0 : d; 
    end     
endmodule

/* testbench with mismatch


*/
