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

//Descrição RTL 1
module meio_subtrator_rtl1 (
    input	A, B,
    output 	D, Borrow // Empréstimo
);
    // A XOR B (diff)
    assign D = A ^ B;
    // Borrow: NOT(A) AND B
    assign Borrow = ~A & B;

endmodule
