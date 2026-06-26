`include "d_ff.v"

module async_counter #(
	parameter WIDTH = 4 
)(
    input       	 clk, rst_n, 
    output [WIDTH-1 : 0] count  
);

    wire [WIDTH-1 : 0] q_n;

    // TODO: Generate for n bits;  
    d_ff ff0 (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (q_n[0]),
        
        .q     (count[0]),
        .q_n   (q_n[0])
    );

    d_ff ff1 (
        .clk   (count[0]),
        .rst_n (rst_n),
        .d     (q_n[1]),
        .q     (count[1]),
        .q_n   (q_n[1])
    );

    d_ff ff2 (
        .clk   (count[1]),
        .rst_n (rst_n),
        .d     (q_n[2]),
        .q     (count[2]),
        .q_n   (q_n[2])
    );

    d_ff ff3 (
        .clk   (count[2]),
        .rst_n (rst_n),
        .d     (q_n[3]),
        .q     (count[3]),
        .q_n   (q_n[3])
    );

endmodule
