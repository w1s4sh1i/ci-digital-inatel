/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-004
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1ns / 1ps

module halfadder (
    input a, b,
    output sum, carry
);
	// xor (sum, a, b);
	// and (carry, a, b);
	assign sum = a ^ b;
	assign carry = a & b;

endmodule
