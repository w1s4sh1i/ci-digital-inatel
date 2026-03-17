/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Devicer-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A013
Type: Testbench
Data: octuber, 23 2025
*/

// A-013: Primitivas


// 13.3-1 - AND (UDP)

/*
and 0 1 x z 
0   0 0	0 0
1   0 1 x x
x   0 x x x
z   0 x x x
*/

// Alternativa 1
primitive and_ptable(
	output y, 
	input a, 
	input b
);

	table
	//  a b : out = y (AND)  
		? 0 : 0;
		0 ? : 0;
		0 0 : 0;
		0 1 : 0;
		1 0 : 0;
		1 1 : 1;

   	endtable

endprimitive
