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

module q5_3_multiplier (
    input  signed [7:0] A, B,   
    output signed [7:0] P    
);
    wire signed [15:0] mult_temp;

    assign mult_temp = A * B;
    assign P = mult_temp[10:3]; // 8 bits ajustados (mantendo sinal)
    
endmodule
