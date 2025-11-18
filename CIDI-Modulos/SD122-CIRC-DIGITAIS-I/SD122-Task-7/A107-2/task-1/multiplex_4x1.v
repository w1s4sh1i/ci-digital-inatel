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

`timescale 1 ns / 1 ps

module multiplex_4x1( // #(parameter N =)
    input S1, S0,		// 1'b   
    input E0, E1, E2, E3, 	// 1'b
    output Y
);
	// Replicar o exemplo dos slides
    assign Y = ~S1 & ( (~S0 & E0) | (S0 & E1) ) |
                S1 & ( (~S0 & E2) | (S0 & E3) );

endmodule
