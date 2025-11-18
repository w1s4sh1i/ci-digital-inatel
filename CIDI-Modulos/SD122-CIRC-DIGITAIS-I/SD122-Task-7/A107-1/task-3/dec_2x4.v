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

module f_function (
    input A, B, C,
    output f
);
    wire Y0, Y1, Y2, Y3;

    decodificador_2x4 DEC (
        .A(A), .B(B),
        .Y0(Y0), .Y1(Y1), .Y2(Y2), .Y3(Y3)
    );

    assign f = (Y1 | Y2) & ~C; // f = ~C (A ^ B)

endmodule
