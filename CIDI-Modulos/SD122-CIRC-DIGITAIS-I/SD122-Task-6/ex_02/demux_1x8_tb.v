`timescale 1ns/1ps
`include "demux_1x8.v"

module demux_1x8_tb;
    reg din;
    reg [2:0] sel;
    wire [7:0] y;

    demux_1x8 uut(.d(din), .sel(sel), .y(y));

    initial begin
        $dumpfile("demux_1x8_tb.vcd");
        $dumpvars(0, demux_1x8_tb);

        din = 1'b1;
        
        sel = 3'b000; #5; 
        sel = 3'b001; #5; 
        sel = 3'b010; #5; 
        sel = 3'b011; #5; 
        sel = 3'b100; #5; 
        sel = 3'b101; #5; 
        sel = 3'b110; #5; 
        sel = 3'b111; #5; 

        $finish;
    end
endmodule
