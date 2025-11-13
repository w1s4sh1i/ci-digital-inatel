`timescale 1ps/1ps
`include "display_7seg.v"

module display_7seg_tb();

    reg [3:0] in;
    wire [6:0] out;

    integer i;

    display_7seg ss_tb(
        .in(in), .out(out)
    );

    initial begin
        $dumpfile("display_7seg_tb.vcd");
        $dumpvars(0, display_7seg_tb);
    
        for(i =0; i< 10; i = i + 1) begin
            in = i;
            #10;
        end

        $finish;
    end

endmodule