/*
Program: CI Digital T2/2025
Class: Circuito Digitais III 
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306
Type: Laboratory
Data: febuary, 03 2026

TODO:
[X] 1 - Apenas um ciclo de clock;
[X] 2 - Para que seja possivel trabalhar com números maiores, já que a saída de uma múltiplicação entre dois números de 8 bits é 16 bits.
[X] 3 - 66051 operações -> 2^16 + 2^8 + 2^8 + 2^1 + 2^0

*/

`timescale 1 ns / 1 ps;

module MAC #(
	parameter	WIDHT_IN = 8, 
				WIDHT_OUT = 32
)(
    input						clk, rst,
    input	[WIDHT_IN-1  : 0]	A, B,
    output	[WIDHT_OUT-1 : 0]	result
);
 
	wire signed [WIDHT_IN*2-1 : 0] product;
	wire signed [WIDHT_OUT-1  : 0] sum;

	reg  signed [WIDHT_OUT-1  : 0] accumulator;

	// Multiplicador 
	assign product = $signed(A) * $signed(B); 
	
	// Somador
	assign sum = accumulator + product; 
	
	// Saída do acumulador
	assign result = accumulator;
	
	always @( posedge clk or posedge rst ) begin
		
		accumulator <= (rst) ? {WIDHT_OUT{1'b0}} : sum;
			
	end

endmodule

