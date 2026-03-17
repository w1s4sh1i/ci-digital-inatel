/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-109
Type: Laboratory
6Data: november, 16 2025
*/

`timescale 1 ns / 1 ps;

module rtl_4bit_carry_look_ahead_adder (
    input  [3:0] A, B,
    input        Cin,
    output [3:0] Sum,
    output       Cout
);

    // Sinais de propagação e geração
    wire [3:0] P, G;
    wire [3:1] C; // [3:0] C

    // Propagação (P = A XOR B)
    xor (P[0], A[0], B[0]);
    xor (P[1], A[1], B[1]);
    xor (P[2], A[2], B[2]);
    xor (P[3], A[3], B[3]);

    // Geração (G = A AND B)
    and (G[0], A[0], B[0]);
    and (G[1], A[1], B[1]);
    and (G[2], A[2], B[2]);
    and (G[3], A[3], B[3]);

    wire t1, t2, t3, t4, t5, t6, t7, t8, t9, t10; // t [9:0]

    // C[1] = G[0] + (P[0] & Cin)
    // C[0] = Cin
    
    and (t1, P[0], Cin); 
    
    or  (C[1], G[0], t1);

    // C[2] = G[1] + (P[1] & G[0]) + (P[1] & P[0] & Cin)
    // C[2] = G[1] + P[1] & (G[0] + P[0] & Cin)
    and (t2, P[1], G[0]);
    and (t3, P[1], P[0], Cin);

    or  (C[2], G[1], t2, t3);

    // C[3] = G[2] + (P[2] & G[1]) + (P[2] & P[1] & G[0]) + (P[2] & P[1] & P[0] & Cin)
    // C[3] = G[2] + P[2] & (G[1] + P[1] & (G[0] + P[0] & Cin))
    
    and (t4, P[2], G[1]);
    and (t5, P[2], P[1], G[0]);
    and (t6, P[2], P[1], P[0], Cin);

    or  (C[3], G[2], t4, t5, t6);

    // Carry Out
    // Cout = G[3] + (P[3] & G[2]) +i (P[3] & P[2] & G[1]) +
    //        (P[3] & P[2] & P[1] & G[0]) + (P[3] & P[2] & P[1] & P[0] & Cin)
    // C[3] = G[3] + P[3] & (G[2] + P[2] & (G[1] + P[1] & (G[0] + P[0] & Cin)))
    and (t7,  P[3], G[2]);
    and (t8,  P[3], P[2], G[1]);
    and (t9,  P[3], P[2], P[1], G[0]);
    and (t10, P[3], P[2], P[1], P[0], Cin);

    or  (Cout, G[3], t7, t8, t9, t10);

    // Sum = P XOR C
    xor (Sum[0], P[0], Cin);
    xor (Sum[1], P[1], C[1]);
    xor (Sum[2], P[2], C[2]);
    xor (Sum[3], P[3], C[3]);

endmodule
