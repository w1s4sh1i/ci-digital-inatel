/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Vector5

module top_module #(parameter WIDTH_MIN = 5, WIDTH_MAX = 25, REPEAT = WIDTH_MAX / WIDTH_MIN)(
    input a, b, c, d, e,
    output [WIDTH_MAX-1 : 0] out 
);
    wire [WIDTH_MIN-1 : 0] data_in = {a, b, c, d, e};
    
    genvar i;
    generate
        for (i = 0; i < WIDTH_MIN; i = i + 1) begin : rep_block
            assign out[WIDTH_MIN*(i+1)-1 : WIDTH_MIN*i] = ~{REPEAT{data_in[i]}} ^ data_in; 
        end
    endgenerate                            

endmodule


/* testbench with mismatch


*/
