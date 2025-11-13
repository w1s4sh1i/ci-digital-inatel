`timescale 1ns/1ps
`include "decoder_8x3.v"

module decoder_8x3_tb;

    reg [15:0] in;
    wire [3:0] out;

    // Instancia do módulo topo
    top uut(
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("decoder_8x3_tb.vcd");
        $dumpvars(0, decoder_8x3_tb);

        // Testando todos os bits
        in = 16'b0000000000000001; #10;
        in = 16'b0000000000000010; #10;
        in = 16'b0000000000000100; #10;
        in = 16'b0000000000001000; #10;
        in = 16'b0000000000010000; #10;
        in = 16'b0000000000100000; #10;
        in = 16'b0000000001000000; #10;
        in = 16'b0000000010000000; #10;
        in = 16'b0000000100000000; #10;
        in = 16'b0000001000000000; #10;
        in = 16'b0000010000000000; #10;
        in = 16'b0000100000000000; #10;
        in = 16'b0001000000000000; #10;
        in = 16'b0010000000000000; #10;
        in = 16'b0100000000000000; #10;
        in = 16'b1000000000000000; #10;

        $finish;
    end

endmodule
