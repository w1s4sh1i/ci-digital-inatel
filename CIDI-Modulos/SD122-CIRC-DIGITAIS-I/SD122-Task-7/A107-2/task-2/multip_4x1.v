/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-107-2
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module f_function (
    input A, B,
    output f // Y
);
	wire E0 = 1'b1;
	wire E1 = 1'b0;
	wire E2 = 1'b1;
	wire E3 = 1'b0;
    
    multiplex_4x1 MUX (
        .S1(A), .S0(B),
        .E0(E0), .E1(E1), .E2(E2), .E3(E3),
        .Y(f)
    );
    
    // assign f = Y & ~B // Alternative  

endmodule
