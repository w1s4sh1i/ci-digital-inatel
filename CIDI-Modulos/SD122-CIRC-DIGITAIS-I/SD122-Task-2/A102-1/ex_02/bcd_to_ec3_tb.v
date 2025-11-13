`timescale 1ns/1ps
`include "bcd_to_ex3.v"

module bcd_to_ec3_tb();

    reg a,b,c,d;
    wire s0, s1, s2, s3;

    integer i;

    bcd_to_ex3 upp(
        .a(a), .b(b), .c(c), .d(d),
        .s0(s0), .s1(s1), .s2(s2), .s3(s3)
    );

    initial begin
        $dumpfile("bcd_to_ec3_tb.vcd");
        $dumpvars(0, bcd_to_ec3_tb);

        for (i = 0; i < 10; i = i + 1) begin
            {a, b, c, d} = i[3:0];
            #10;
        end
        $finish;
    end

endmodule