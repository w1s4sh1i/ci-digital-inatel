/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;
module demux_3x8_tb;

	localparam DELAY = 10;
    	reg [2:0] in;
    	wire [7:0] out;

    	demux_3x8 U1 (
        	.in(in),
        	.out(out)
    	);

	initial begin
    
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A014-3-dmux.vcd"); 
		$dumpvars(0, demux_3x8_tb); 
			
		$display("|Input	|Ouput	  |");
		$monitor("|%b	|%b |", in, out);
			
		in = 3'b000;
		#DELAY

		in = 3'b001;
		#DELAY

		in = 3'b010;
		#DELAY

		in = 3'b011;
		#DELAY

		in = 3'b100;
		#DELAY

		in = 3'b101; 
		#DELAY

		in = 3'b110; 
		#DELAY

		in = 3'b111; 
		#DELAY

		#DELAY 
		$finish; 
	end

endmodule
