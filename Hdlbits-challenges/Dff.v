/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Dff

module top_module (
    input clk,    // Clocks are used in sequential circuits
    input d,
    output reg q 
);//

    always @(posedge clk) begin
        q = d;  
    end 

endmodule


/* testbench with mismatch


*/
