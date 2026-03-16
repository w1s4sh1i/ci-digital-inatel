/*
Program: CI Digital 02/2025
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

module adder_bcd ( // #(parameter WIDTH = 4)(
    input [3:0] A, B,
    input Cin,
    output [3:0] S,
    output Cout
);
    wire [3:0] sum;
    wire carry_out;
    wire adjust;

    // Somador de 4 bits
    adder4 somador (
        .A(A), .B(B), .Cin(Cin),
        .S(sum), .Cout(carry_out)
    );

    assign adjust = carry_out | (sum > 4'd9); // Verifica se é necessário ajuste BCD
    assign S = adjust ? (sum + 4'd6) : sum; // Ajuste BCD
    assign Cout = adjust;

endmodule
