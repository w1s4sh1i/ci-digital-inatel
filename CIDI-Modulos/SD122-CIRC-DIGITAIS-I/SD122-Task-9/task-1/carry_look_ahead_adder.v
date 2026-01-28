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

module carry_look_ahead_adder #(parameter N = 4)(
	input	[N-1:0] A, B,
	input	Cin, 
	output	[N-1:0] S, 
	output	Cout
);

	integer i;

	wire [N-1:0] G, P; 
	reg  [N	 :0] C;

	assign G = A & B; // G[i] = A[i] AND B[i]
	assign P = A ^ B; // P[i] = A[i] XOR B[i]

	// Calcular a soma
	assign S = A ^ B ^ C[N-1:0]; // S[i] = A[i] XOR B[i] XOR C[i]

	// Carry Out
	assign Cout = C[N];
	
	// Calcular os carries intermediários
	always @(*) begin
		C[0] <= Cin; 
		for(i = 0; i < N; i = i + 1) begin
			C[i+1] <= G[i] | (P[i] & C[i]);
		end
	end

endmodule
