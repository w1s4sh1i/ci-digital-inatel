/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-107-1
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decodificador_2x4 ( // #(parameter ... = ...) (
    input A, B,
    output Y0, Y1, Y2, Y3 // [3:0] Y;
);
    assign Y0 = ~A & ~B; // ~ (A | B); 
    assign Y1 = ~A &  B;
    assign Y2 =  A & ~B;
    assign Y3 =  A &  B;

endmodule
