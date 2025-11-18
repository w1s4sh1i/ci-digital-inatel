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
S3 = A + B·C + B·D   = A + B·(C + D)
S2 = B ⊕ (C + D)     = B XOR (C OR D)
S1 = C·D + ¬C·¬D     = C XNOR D      (equivalente a ~(C ^ D))
S0 = ¬D
*/

module bcd_to_ex3(
    input a,b,c,d,
    output s0, s1, s2, s3
);

assign s3 = a | (b & (c | d));
assign s2 = b ^ (c | d);      // XOR
assign s1 = ~(c ^ d);         // XNOR
assign s0 = ~d;

endmodule
