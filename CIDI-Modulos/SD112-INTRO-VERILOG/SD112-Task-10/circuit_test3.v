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
	
	wire n_a, n_b, n_d, and_1, or_1, nor_1, nor_2;

 	not (n_a, a);
 	not (n_b, b);
 	not (n_d, d);
 	
 	and (and_1, n_a, b);
 	or	(or_1, c, n_d);
 	nor (nor_1, n_b, d);
 	
 	nor (nor_2, and_1, or_1);

 	nand (s, nor_2, nor_1);
 	
 endmodule
