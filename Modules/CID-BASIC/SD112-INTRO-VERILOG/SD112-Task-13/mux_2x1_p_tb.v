/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Testbench
Data: octuber, 27 2025
*/

`timescale 1 ns / 1 ps;

module mux_2x1_p_tb;
	
	localparam DELAY = 15; 
	reg in1, in2, sel;
	wire y;

	mux_2x1_p UUT (y, in1, in2, sel);

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A013-3-mux.vcd"); 
        	$dumpvars(0, mux_2x1_p_tb); 
		
		$display("|Input 1|Input 2|Select |Y |");
		$monitor("|%b	|%b	|%b	|%b |", in1, in2, sel, y);
		
		{sel, in2, in1} = 3'b001;
		#DELAY;
		
		{sel, in2, in1} = 3'b010;
		#DELAY;
		
		{sel, in2, in1} = 3'b011;
		#DELAY;
		
		{sel, in2, in1} = 3'b101;
		#DELAY;
		
		{sel, in2, in1} = 3'b110;
		#DELAY;
		
		{sel, in2, in1} = 3'b111;
		#DELAY;
		
		$finish;
	end
                
endmodule
