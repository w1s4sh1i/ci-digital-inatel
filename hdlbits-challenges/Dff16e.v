/*
Program: [HDLbits challenges](https://hdlbits.01xz.net/wiki/Main_Page)
Development: BEZERRA, André <w1s4sh1i>
Student-Contact: andrefrbezerra@gmail.com
*/

// https://hdlbits.01xz.net/wiki/Dff16e

module top_module #(parameter WIDTH = 16)(
    input  clk,
    input  resetn,
    input  [1:0] byteena,
    input  [WIDTH-1 : 0] d,
    output [WIDTH-1 : 0] q
);
    always @(posedge clk) begin
            
            q[WIDTH-1 : 0] <= {
             	byteena[1] ? d[WIDTH-1   : WIDTH/2]: q[WIDTH-1   : WIDTH/2],
                byteena[0] ? d[WIDTH/2-1 : 	  	 0]: q[WIDTH/2-1 : 	 	 0]
            } & {WIDTH{resetn}};
           
    end

endmodule

/* testbench with mismatch


*/
