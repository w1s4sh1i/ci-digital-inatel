/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-004
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1ns / 1ps

module halfadder_tb;

	localparam DELAY = 10; 
	reg a, b;         
	wire sum, carry;      

	halfadder U1 (
		.a(a),
		.b(b),
		.sum(sum),
		.carry(carry)
	);

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CID-SD112-A004.vcd"); 
        	$dumpvars(0, halfadder_tb); 	
		
		$display("|a	|b	|sum	|carry	|");  
		$monitor ("|%b	|%b	|%b	|%b	|", a , b, sum, carry);
		
		// for() begin ... end >>> X2 i, j;
		// [ ] Increase a and b for samples generate. 

		a = 1'b0; 
		b = 1'b0; 
		#DELAY;

		a = 1'b0; 
		b = 1'b1; 
		#DELAY;

		a = 1'b1; 
		b = 1'b0; 
		#DELAY;

		a = 1'b1; 
		b = 1'b1; 
		#DELAY;

		$finish;
	end
endmodule
