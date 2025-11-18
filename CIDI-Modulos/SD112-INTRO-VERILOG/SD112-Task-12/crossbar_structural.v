/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-012
Type: Laboratory
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module crossbar_structural(
	input in1, in2, select,
	output out1, out2
);

	mux2x1_rtl_1 mux1(in1, in2, select, out1);
	mux2x1_rtl_1 mux2(in2, in1, select, out2);

endmodule
