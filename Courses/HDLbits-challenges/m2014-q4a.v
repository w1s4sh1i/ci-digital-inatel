/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Exams/m2014_q4a

module top_module (
    input d, 
    input ena,
    output q
);
    always @(ena) begin 
        q <= ena ? d : q; 
    end     
endmodule

/* testbench with mismatch


*/
