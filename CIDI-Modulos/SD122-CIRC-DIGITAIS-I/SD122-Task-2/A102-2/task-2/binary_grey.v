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

module conversor_binario_grey(
	input 		[3:0] binario,
	output reg 	[3:0] gray
); // bcd_5311 para bcd_8421

	always@(*) begin
	    case(binario) // entrada -> bcd_8421
			4'b0000: gray = 4'b0000;
			4'b0001: gray = 4'b0001;
			4'b0010: gray = 4'b0011;
			4'b0011: gray = 4'b0010;
			4'b0100: gray = 4'b0110;
			4'b0101: gray = 4'b0111;
			4'b0110: gray = 4'b0101;
			4'b0111: gray = 4'b0100;
			4'b1000: gray = 4'b1100;
			4'b1001: gray = 4'b1101;
			4'b1010: gray = 4'b1111;
			4'b1011: gray = 4'b1110;
			4'b1100: gray = 4'b1010;
			4'b1101: gray = 4'b1011;
			4'b1110: gray = 4'b1001;
			4'b1111: gray = 4'b1000;
			default: gray = 4'bxxxx;
	    endcase
	end
endmodule













