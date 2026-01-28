/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4

// Module

module top_module (
    input clk, x,
    output z
); 
    reg [2:0] Q;
    assign z = ~| Q;
    always @(posedge clk) begin
        Q <= {~ Q[2] | x, ~ Q[1] & x, Q[0] ^ x};
    end
endmodule

/* testbench with mismatch


*/
