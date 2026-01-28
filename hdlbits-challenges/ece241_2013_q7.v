/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q7

// Module

module top_module (
    input clk, j, k,
    output Q
); 
    always @(posedge clk) begin
        case({j, k})
            2'b00: Q = Q;
            2'b01: Q = 1'b0;
            2'b10: Q = 1'b1;
            2'b11: Q = ~Q;
        endcase
    end
endmodule

/* testbench with mismatch


*/
