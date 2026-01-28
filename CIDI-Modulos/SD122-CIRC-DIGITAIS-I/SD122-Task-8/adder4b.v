/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-108
Type: Laboratory
Data: november, 15 2025
*/

`timescale 1 ns / 1ps

module adder4b (
    input a, b, cin,
    output sum, cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & ( a ^ b));

endmodule
