/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/2014_q4a

// Module

module top_module (
    input clk, w, R, E, L,
    output Q
);
    wire r0, r1;
    assign Q = r1;
    always @(posedge clk) begin
        r0 = (E) ? w : Q;
        r1 = (L) ? R : r0;
    end
endmodule

/* testbench with mismatch


*/
