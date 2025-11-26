/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-103
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module excess3_10x4_tb;
	
	localparam DELAY = 10; 
	reg  [9:0] in;
	wire [3:0] out;

	excess3_10x4 UUT (
		.in(in),
		.out(out)
	);
	
	initial begin
		
		$dumpfile("CIDI-SD122-A103-2.vcd");
		$dumpvars(0, excess3_10x4_tb);

		$display("|In		|Out	|");
		$monitor("|%b	|%b	|", in, out);

		in = 10'b0000000001; #DELAY;
		in = 10'b0000000010; #DELAY;
		in = 10'b0000000100; #DELAY; 
		in = 10'b0000001000; #DELAY;
		in = 10'b0000010000; #DELAY;
		in = 10'b0000100000; #DELAY;
		in = 10'b0001000000; #DELAY;
		in = 10'b0010000000; #DELAY; 
		in = 10'b0100000000; #DELAY;
		in = 10'b1000000000; #DELAY;
		$finish;
	end
endmodule
