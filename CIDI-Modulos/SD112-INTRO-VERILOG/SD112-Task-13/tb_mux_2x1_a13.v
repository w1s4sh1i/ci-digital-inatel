/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_2x1_a13_tb;

	reg in1, in2, sel;
	wire y;

	mux_2x1_a13 U1 (y,in1,in2,sel);

	initial begin
		
		sel = 0;
		in1 = 1; in2 = 0;
		#15;
		in1 = 0; in2 = 1;
		#15;
		
		sel = 1; 
		in1 = 1; in2 = 0;
		#15;
		
		in1 = 0; in2 = 1;
		#10;
		
		$finish;
	end
                
endmodule
