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

// Atividade A-010-1

module mux2x1_rtl1(
	input in1,in2,select,
	output out
);
	wire n_select, and1, and2;

	not g1 (n_select, select);
	and g2 (and1, n_select, in1);
	and g3 (and2, select, in2);
	or  g4 (out, and1, and2);
	
endmodule
