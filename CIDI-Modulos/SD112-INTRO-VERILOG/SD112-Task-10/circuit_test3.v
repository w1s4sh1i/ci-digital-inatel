/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-010
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

// Atividade A-010-3

module circuit_test3 ( // Definir função
	input a, b, c, d,
	output s 
);
	
	wire n_a, n_b, n_c, n_d, and_1, or_1, nor_1, nor_2;

 	not n1 (n_a, a);
 	not n2 (n_b, b);
 	not n3 (n_c, c);
 	not n4 (n_d, d);
 	
	// Reavaliar o circuito; 
 	and a1 (and_1, n_a, b);
 	or  o1 (or_1, c, n_d);
 	nor nr1 (nor_1, n_b, d);
 	
 	nor nr2 (nor_2, and_1, or_1);

 	nand nd1 (s, nor_2, nor_1);
 	
 endmodule
