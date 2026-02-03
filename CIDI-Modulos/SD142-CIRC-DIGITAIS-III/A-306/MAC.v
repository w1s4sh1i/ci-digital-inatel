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

module MAC #(parameter WIDHT_IN = 8, WIDHT_OUT = 32, DEFAULT = {WIDHT_OUT-1{0}}) (
    input						clk, rst,
    input	[WIDHT_IN-1  : 0]	A, B,
    output	[WIDHT_OUT-1 : 0]	result
);
 
	wire signed [WIDHT_IN*2-1 : 0] product;
	wire signed [WIDHT_OUT-1  : 0] sum;
	reg  signed [WIDHT_OUT-1  : 0] accumulator;

	assign product = $signed(A) * $signed(B); // Multiplicador 
	assign sum = accumulator + product; // Somador
	assign result = accumulator; // Saída do acumulador
	
	always @( posedge clk or posedge rst ) begin
		if (en) // Acumulador
			accumulator <= sum; 
		else if (rst)
			accumulator <= {WIDHT_OUT-1{0}};
		else 
			accumulator <= DEFAULT;
		end
	end

endmodule
