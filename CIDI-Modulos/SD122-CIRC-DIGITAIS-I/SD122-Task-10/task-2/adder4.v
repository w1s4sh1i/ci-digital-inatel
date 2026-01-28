/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-110
Type: Laboratory
Data: november, 17 2025
*/

`timescale 1 ns / 1 ps;

module adder4 ( // #(parameter WIDTH = 4)(
    input 	[3:0]	A, B,
    input 			Cin,
    output	[3:0]	S,
    output 			Cout
);
    assign S = A ^ B ^ Cin;
    assign Cout = (A & B) | ((A ^ B) & Cin);

endmodule
