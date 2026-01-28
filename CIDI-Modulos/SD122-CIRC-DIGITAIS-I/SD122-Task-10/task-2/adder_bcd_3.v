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

module adder_bcd_3 ( // #(parameter WIDHT = 4)(
    input  [11:0] A, B,   // BCD 0000_0000_0000 -> 3 digits 
    input         Cin, 
    output [11:0] S,
    output        Cout
);
    wire c1, c2; // c [1:0]

    // Unidades
    adder_bcd DUT0 (
        .A(A[3:0]), .B(B[3:0]), .Cin(Cin),
        .S(S[3:0]), .Cout(c1)
    );

    // Dezenas
    adder_bcd DUT1 (
        .A(A[7:4]), .B(B[7:4]), .Cin(c1),
	.S(S[7:4]), .Cout(c2)
    );

    // Centenas
    adder_bcd DUT2 (
        .A(A[11:8]), .B(B[11:8]), .Cin(c2),
        .S(S[11:8]), .Cout(Cout)
    );

endmodule
