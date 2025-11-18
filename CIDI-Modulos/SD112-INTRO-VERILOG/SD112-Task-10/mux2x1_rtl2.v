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

module mux2x1_rtl2 (
	input in1, in2, select,
	output out
);
	wire n_select, and1, and2, or1;

	assign n_select = ~select;
	assign and1 = in1 & n_select;
	assign and2 = in2 & select;
	assign or1 = and1 | and2;
	assign out = or1;

endmodule
