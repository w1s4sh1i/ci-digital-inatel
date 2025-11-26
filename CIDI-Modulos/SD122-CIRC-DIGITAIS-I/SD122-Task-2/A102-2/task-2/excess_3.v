/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-2
Type: Laboratory
Data: november, 5 2025
*/

`timescale 1 ns / 1 ps;

module excess_3 ( // bcd_5311 para bcd_8421
	input [3:0] binario,
	output reg [3:0] excesso_3,
	output reg carry
);
	always @(*) begin
		{carry, excesso_3} <= binario + 4'b0011; // Máximo 12  
	end
	
endmodule













