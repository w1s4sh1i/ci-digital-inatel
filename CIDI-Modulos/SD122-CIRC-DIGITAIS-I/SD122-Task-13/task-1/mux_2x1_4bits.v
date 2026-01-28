/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Laboratory
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module mux_2x1_4bits (
    input  [3:0] in0, in1,
    input        sel,
    output [3:0] out
);
    assign out = (sel) ? in1 : in0;
endmodule
