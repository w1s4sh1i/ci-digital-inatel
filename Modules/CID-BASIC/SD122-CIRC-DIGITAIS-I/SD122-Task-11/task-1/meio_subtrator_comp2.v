/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Laboratory
Data: november, 18 2025
*/

`timescale 1 ns / 1 ps;

//Descrição comportamental 2 (4)
module meio_subtrator_comp2 (
    input 		A, B,
    output reg	D, // Diferença (A - B)
    output reg	Borrow
);
    always @(*) begin
        D <= A - B; 
        Borrow <= (A < B) ? 1'b1: 1'b0;
    end
endmodule
