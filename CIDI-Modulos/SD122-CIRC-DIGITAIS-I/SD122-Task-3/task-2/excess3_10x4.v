/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-103
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module excess3_10x4 #(parameter N = 10, M = 4)(
    input wire [N-1 :0] in,
    output reg [M-1 :0] out
);

	always @(*) begin
		case (in)
			10'b0000000001  : out = 4'b0011; // 3
			10'b0000000010  : out = 4'b0100; // 4
			10'b0000000100  : out = 4'b0101; 
			10'b0000001000  : out = 4'b0110;
			10'b0000010000  : out = 4'b0111; 
			10'b0000100000  : out = 4'b1000;
			10'b0001000000  : out = 4'b1001;
			10'b0010000000  : out = 4'b1010;
			10'b0100000000  : out = 4'b1011;
			10'b1000000000  : out = 4'b1100; 
			default         : out = 4'b0000;
		endcase
	end
endmodule
