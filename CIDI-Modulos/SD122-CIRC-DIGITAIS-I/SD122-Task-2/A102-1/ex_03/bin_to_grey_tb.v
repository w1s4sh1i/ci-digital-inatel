`timescale 1ns/1ps
`include "bin_to_grey.v"

module bin_to_grey_tb ();
    
    reg b0, b1, b2, b3;
    wire g0, g1, g2, g3;
    integer i;

    bin_to_grey uup(
        .b0(b0), .b1(b1), .b2(b2), .b3(b3),
        .g0(g0), .g1(g1), .g2(g2), .g3(g3)
    );

    initial begin
        $dumpfile("bin_to_grey_tb.vcd");
        $dumpvars(0, bin_to_grey_tb);

        for (i = 0; i < 16; i = i + 1) begin
            {b3, b2, b1, b0} = i;  // atribuindo valor binário
            #10;                     // espera 10 ns
        end
        $finish;
    end
    
endmodule