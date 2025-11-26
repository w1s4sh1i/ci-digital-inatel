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

//2 Estrutural
module mux_est ( 
    input a, b, sel,
    output y
);
    wire w1, w2;

    and a1 (w1,  sel,  a);
    and a2 (w2, !sel,  b);
    or 	o1 ( y,   w1, w2);

endmodule
