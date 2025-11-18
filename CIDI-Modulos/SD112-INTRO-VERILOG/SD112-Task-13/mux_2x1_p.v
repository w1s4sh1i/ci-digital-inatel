/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Laboratory
Data: octuber, 27 2025
*/

`timescale 1 ns / 1 ps;

primitive mux_2x1_p (
	output y,
	input in1, in2, sel
);	

	table
	//	   in1 in2 sel  :   out
		0	?   1	:	0;
		1   ?	1	:	1;
		?	0   0	:	0;
		?   1	0	:	1;
		0	0	?	:	0;
		1	1	?	:	1;
		
	endtable

endprimitive
