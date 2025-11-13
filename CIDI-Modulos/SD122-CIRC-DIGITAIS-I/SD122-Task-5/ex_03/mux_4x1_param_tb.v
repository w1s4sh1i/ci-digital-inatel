`timescale 1ns / 1ps
`include "mux_4x1_param.v"

module mux_4x1_param_tb;
    parameter N = 4;
    reg  [3:0] in0,in1,in2,in3;
    reg  [1:0]  sel;
    wire [3:0]  out;
    
    mux_4x1_param #(.N(N)) mux (
    .in0(in0),.in1(in1),.in2(in2),.in3(in3),
    .sel(sel),.out(out));

    initial begin
        $dumpfile("mux_4x1_param_tb.vcd");
        $dumpvars(0, mux_4x1_param_tb);

        in0 = 4'b0101;
        in1 = 4'b0011;
        in2 = 4'b0100;
        in3 = 4'b1000;

        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;

    end

endmodule