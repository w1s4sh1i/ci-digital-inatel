`timescale 1ns / 1ps
`include "demux_1x8.v"

module demux_1x8_tb();
    reg sel;
    reg [2:0] addr;
    reg in;
    wire [7:0] out;

    demux_1x8 uut (
        .sel(sel),
        .addr(addr),
        .in(in),
        .out(out)
    );

    initial begin

        $dumpfile("demux_1x8_tb.vcd");
        $dumpvars(0, demux_1x8_tb);
        // Test case 1: sel = 0, all outputs should be 0
        sel = 0; addr = 3'b000; in = 1'b1;
        #10;

        // Test case 2: sel = 1, addr = 3'b000
        sel = 1; addr = 3'b000; in = 1'b1;
        #10;

        // Test case 3: sel = 1, addr = 3'b101
        sel = 1; addr = 3'b101; in = 1'b1;
        #10;

        // Test case 4: sel = 1, addr = 3'b111
        sel = 1; addr = 3'b111; in = 1'b1;
        #10;

        // Test case 5: sel = 1, addr = 3'b010, in = 0
        sel = 1; addr = 3'b010; in = 1'b0;
        #10;

        $finish;
    end


endmodule