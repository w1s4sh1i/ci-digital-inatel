`timescale 1ns / 1ps

module mux8x1_tb;
  reg [7:0] data_in_tb;
  reg [2:0]  sel_tb;
  wire       out_tb;
  integer     i;
  
  mux_8x1 uut (.D(data_in_tb), .S(sel_tb) ,.Y(out_tb));
  
  initial begin
    data_in_tb = 7'b0;
    sel_tb     = 3'b0;
    #1;

    for (i = 0; i < 8; i = i + 1) begin
      sel_tb = i;
      data_in_tb = (1 << i);  
      #10;
    end

    $finish;
  end
endmodule