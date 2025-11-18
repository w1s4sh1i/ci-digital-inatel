/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-105
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux8x1_tb;
  
  localparam DELAY = 10;
  reg [7:0] data_in_tb;
  reg [2:0]  sel_tb;
  wire       out_tb;
  integer     i;
  
  mux_8x1 uut (
  	.D(data_in_tb), .S(sel_tb) ,
  	.Y(out_tb)
  );
  
  initial begin
  
  	$dumpfile("CID-SD122-A105-2.vcd");
    $dumpvars(0, mux8x1_tb);

	$display("|Data in	|Select |Out	|");
	$monitor("|%b	|%b	|%b	|", data_in_tb, sel_tb, out_tb);

    data_in_tb = 7'b0;
    sel_tb     = 3'b0;
    #1;

    for (i = 0; i < 8; i = i + 1) begin
      sel_tb = i;
      data_in_tb = (1 << i);  
      #DELAY;
    end

    $finish;
  end
endmodule
