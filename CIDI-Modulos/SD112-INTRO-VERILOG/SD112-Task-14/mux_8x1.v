/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_8x1 (
    input  wire [7:0] in,
    input  wire [2:0] sel,
    output wire       out
);

    assign out = in[sel];

endmodule
