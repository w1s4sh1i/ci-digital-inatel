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

module behave_4bit_carry_lookahead_adder (
    input 	[3:0] 	A, B,
    input 		Cin,
    output reg	[3:0]	Sum,
    output reg 		Cout
);
    reg [3:0] P, G, C; //! Carries internos

    always @(*) begin
        P = A ^ B;
        G = A & B;

        C[0] = Cin;
      
    	// Estruturado -> 
        C[1] = G[0] | (P[0] & C[0]);
        C[2] = G[1] | P[1] & (G[0] | P[0] & C[0]);
        C[3] = G[2] | P[2] & (G[1] | P[1] & (G[0] | P[0] & C[0]));
        Cout = G[3] | P[3] & ((G[2] | P[2] & (G[1] | P[1] & (G[0] | P[0] & C[0]))));
        
        Sum = P ^ C;
    
    end

endmodule
