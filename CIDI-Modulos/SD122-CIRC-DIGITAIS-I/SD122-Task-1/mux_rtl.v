/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: D122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-101
Type: Laboratory
Data: octuber, 29 2025
*/

`timescale 1 ns / 1 ps;

// [ ] Realizar análise de testes integrados;

/* 
1 - RTL          	-> portas lógicas
2 - Estrutural   	-> instancias 
3 - Comportamental	-> always or initial
*/

// 3 
module mux_rtl (
    input a, b, sel,
    output y
);
    wire n_sel, and1, and2;

    assign n_sel = ~sel;
    assign and1 = a & sel;
    assign and2 = n_sel & b;
    assign y = and1 | and2;

endmodule
