/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-012
Type: Laboratory
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module	counter_24 #(parameter W = 24) (
	input clk, reset, en,
	output reg [W-1:0] count
);
	// localparam DIGIT = W / 3;
	wire carry2, carry1, carry0; // [2:0] carry; 
	wire [7:0] c1, c2, c3; // [DIGIT-1:0] c [2:0]

	counter #(.WIDTH(8)) C1 (
		.clk(clk), .reset(reset), .en(en), 
		.count(c1), .carry(carry0)
	);
	
	counter #(.WIDTH(8)) C2 (
		.clk(clk), .reset(reset), .en(~carry0), 
		.count(c2), .carry(carry1)
	);

	counter #(.WIDTH(8)) C3 (
		.clk(clk), .reset(reset), .en(~carry1), 
		.count(c3), .carry(carry2)
	);
	
	// Analisar condição inicial de contagem
	always @(posedge clk or posedge reset) begin // Analisar transição
		
		// count <= {c3, c2, c1} & (~reset);
		if (reset)
			count <= 0;
		else
			count <= {c3, c2, c1};
	end

endmodule
