/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-114
Type:  Laboratory
Data: november, 21 2025
*/

`timescale 1 ns / 1 ps;

module q4_4_adder_subtractor(
    input  [7:0] A, B,      
    input        SUB,    
    output [7:0] Result,  
    output       Overflow 
);
    wire [8:0] B_mod;
    wire [8:0] Sum;

    assign B_mod = SUB ? {1'b0, ~B} + 9'b1 : {1'b0, B};
    assign Sum = {A[7], A} + B_mod;
    assign Result = Sum[7:0];
    assign Overflow = (A[7] == B_mod[7]) && (Sum[7] != Sum[8]);

endmodule
