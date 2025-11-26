/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-1
Type: Laboratory
Data: november, 5 2025
*/

`timescale 1 ns / 1 ps;

module S_D(
	input H,G,
	output D
);
	assign D = H & G;

endmodule

module S_C(
	input H,G,E,
	output C
);
	assign C = (!H & G & E) | (H & !G); // (E & !H & G ) | (H & !G);

endmodule

module S_B(
	input H,G,F,E,
	output B
);
	assign B = (!H & G & !E) | (!G & F) | (H & !G); 
	// (G & !H & !E) | (!G & (F | H))

endmodule

module S_A(
	input H,G,F,E,
	output A
);
	assign A = (!H & !G & !F & E) | (!H & G & !E) | (G & F) | (H & G & E) | (H & F);
	// !H & ((!F & !G & E) | (G & !E)) | (G & F) | (H & (G & E | F));
endmodule

module top(
    input  H,G,F,E,
    output D,C,B,A
);
    S_D sd(.H(H), .G(G), .D(D)		    );
    S_C sc(.H(H), .G(G), .E(E), .C(C)	    );
    S_B sb(.H(H), .G(G), .F(F), .E(E), .B(B));
    S_A sa(.H(H), .G(G), .F(F), .E(E), .A(A));

endmodule
