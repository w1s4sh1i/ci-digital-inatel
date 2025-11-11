/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-005
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1ps

module fulladder_tb;
	
	localparam DELAY = 10; 
	reg a, b, cin;
	wire sum, carry_out;

	fulladder fa (.a(a), .b(b), .cin(cin), .sum(sum), .carry_out(carry_out));

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CID-SD112-A005-1.vcd"); 
		$dumpvars(0, fulladder_tb); 
	
		$display("|a	|b	|cin	|Sum	|Carry	|"); 
		
		$monitor ("|%b	|%b	|%b	|%b	|%b	|", 
			a, b, cin, sum, carry_out
		);

		// for () begin ... end
		// [ ] Increase a and b for any cin; 

		a = 1'b0; 
		b = 1'b0; 
		cin = 1'b0; 
		#DELAY;

		a = 1'b0; 
		b = 1'b0; 
		cin = 1'b1; 
		#DELAY;

		a = 1'b0; 
		b = 1'b1; 
		cin = 1'b0; 
		#DELAY;

		a = 1'b0;
		b = 1'b1;
		cin = 1'b1; 
		#DELAY;

		a = 1'b1;
		b = 1'b0;
		cin = 1'b0;
		#DELAY;

		a = 1'b1; 
		b = 1'b0; 
		cin = 1'b1; 
		#DELAY;

		a = 1'b1; 
		b = 1'b1; 
		cin = 1'b0; 
		#DELAY;

		a = 1'b1;
		b = 1'b1;
		cin = 1'b1; 
		#DELAY;
		
		$finish;
	
	end
	
endmodule
