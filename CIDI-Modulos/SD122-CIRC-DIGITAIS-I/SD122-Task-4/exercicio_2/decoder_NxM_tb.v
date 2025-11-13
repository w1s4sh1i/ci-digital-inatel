`timescale 1ns/1ps
`include "decoder_NxM.v"

module decoder_NxM_tb;
    parameter N = 4;
    parameter M = (1 << N);

    reg  [N-1:0] in;
    wire [M-1:0] out;

    // Instancia o decodificador
    decoder_NxM #(N) DUT (
        .in(in),
        .out(out)
    );

    initial begin
        $dumpfile("decoder_NxM_tb.vcd");
        $dumpvars(0, decoder_NxM_tb);

        // Testa todas as combinações
        in = 0;  #10;
        in = 1;  #10;
        in = 3;  #10;
        in = 7;  #10;
        in = 15; #10;
        $finish;
    end
endmodule
