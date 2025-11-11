/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

primitive flip_flop_D_primitive (q, d, clk, rst);
    output q;
    input  d, clk, rst;
    reg    q;

    table
    // d  clk  rst  : q : q+
       ?   ?    1  : ? : 0;   
       0  (01)  0  : ? : 0;   
       1  (01)  0  : ? : 1;   
       ?  (?0)  0  : ? : -;   
       
    endtable
endprimitive
