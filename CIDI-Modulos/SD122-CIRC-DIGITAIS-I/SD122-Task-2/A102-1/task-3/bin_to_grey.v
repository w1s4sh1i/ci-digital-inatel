/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

/*
G3 = B3
G2 = B3 ⊕ B2
G1 = B2 ⊕ B1
G0 = B1 ⊕ B0
*/

module bin_to_grey(
    input b0, b1, b2, b3,
    output g0, g1, g2, g3
);

    assign g3 = b3;
    assign g2 = b3 ^ b2;
    assign g1 = b2 ^ b1;
    assign g0 = b1 ^ b0;

endmodule
