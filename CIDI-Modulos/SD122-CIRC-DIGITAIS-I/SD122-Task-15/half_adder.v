/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-115
Type: Laboratory
Data: november, 21 2025
*/

`timescale 1ns / 1ps

module half_adder (
    input a, b,
    output sum, carry
);
	// xor (sum, a, b);
	// and (carry, a, b);
	assign sum = a ^ b;
	assign carry = a & b;

endmodule
