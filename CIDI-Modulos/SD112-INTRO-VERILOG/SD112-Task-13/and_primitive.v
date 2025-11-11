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

module  and_primitive (
    input a, b,
    output y
); 
    supply1 vdd; 
    supply0 gnd; 

    wire out_1, nmos_con;

    pmos (out_1, vdd, a);
    pmos (out_1, vdd, b);
    
    nmos (out_1, nmos_con, a); 
    nmos (nmos_con, gnd, b);

    pmos (y, vdd, out_1); 
    nmos (y, gnd, out_1); 

endmodule
