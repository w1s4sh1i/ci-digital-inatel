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

//Descrição comportamental 1 (3)
module meio_subtrator_comp1(
    input 		A, B,
    output reg	D, Borrow
);
    always @(*) begin
        D <= A ^ B; // A XOR B (diff)
        Borrow <= (~A) & B; // borrow: NOT(A) AND B
    end
endmodule
