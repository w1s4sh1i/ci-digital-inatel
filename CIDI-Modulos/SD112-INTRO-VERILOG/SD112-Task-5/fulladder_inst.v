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

module fulladder_inst (
	input a, b, cin,
	output sum, carry_out
);
	wire wsum1, wcarry1, wcarry2;

	halfadder hf1(.a(a), .b(b), .carry(wcarry1), .sum(wsum1));
	halfadder hf2(.a(wsum1), .b(cin), .sum(sum), .carry(wcarry2));
	or o1 (carry_out, wcarry2, wcarry1);

endmodule
