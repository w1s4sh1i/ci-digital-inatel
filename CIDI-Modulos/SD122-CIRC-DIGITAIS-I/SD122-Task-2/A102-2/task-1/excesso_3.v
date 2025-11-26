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

// Excesso 3

module excesso_3 ( // #(parameter N = 4)(
	input [3:0] bcd_8421,
	output reg [3:0] excesso_3
);

	always@(*) begin
		case(bcd_8421) // entra bcd_8421
			4'b0000: excesso_3 = 4'b0011; // 3
			4'b0001: excesso_3 = 4'b0100; // 4
			4'b0010: excesso_3 = 4'b0101; // 5
			4'b0011: excesso_3 = 4'b0110; // 6
			4'b0100: excesso_3 = 4'b0111; // 7
			4'b0101: excesso_3 = 4'b1000; // 8
			4'b0110: excesso_3 = 4'b1001; // 9
			4'b0111: excesso_3 = 4'b1010; // 10
			4'b1000: excesso_3 = 4'b1011; // 11
			4'b1001: excesso_3 = 4'b1100; // 12
			4'b1010: excesso_3 = 4'b1101; // 13
			4'b1011: excesso_3 = 4'b1110; // 14
			4'b1100: excesso_3 = 4'b1111; // 15
			default: excesso_3 = 4'bxxxx;
		endcase
	end

endmodule
