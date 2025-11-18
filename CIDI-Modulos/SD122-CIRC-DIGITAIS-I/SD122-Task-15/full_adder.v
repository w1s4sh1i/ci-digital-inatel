/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-005
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps 

module full_adder (
	input a, b, cin,
	output sum, carry_out
);

	/* 
	xor (sum, a, b, c);
	wire eab, xab;
	and (eab, a, b);
	xor (xab, a, b);
	and (carry_out, eab, xab, cin); 
	*/
 	
	assign sum = a ^ b ^ cin;
	assign carry_out = (a && b) || (a ^ b) && cin;

endmodule
