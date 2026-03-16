/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Laboratory
Data: november, 18 2025
*/

`timescale 1 ns / 1 ps;

//Descrição RTL 2 (2)
module meio_subtrator_rtl2(
    input	A, B,
    output	D, Borrow // Empréstimo
);
    wire not_A;
    wire A_xor_B;
   
    not u1(not_A , A);
    xor u2(D, A, B);
    and u3(Borrow , not_A , B);

endmodule

