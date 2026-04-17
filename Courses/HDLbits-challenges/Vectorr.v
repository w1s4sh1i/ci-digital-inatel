/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vectorr

module top_module #(parameter WIDTH = 8)( 
    input [WIDTH-1 :0] in,
    output [WIDTH-1 :0] out
);
    always @(*) begin
        for(integer i = 0; i < WIDTH; ++i) begin
            out[WIDTH-1-i] <= in[i];
        end    
    end     
endmodule

/* testbench with mismatch


*/
