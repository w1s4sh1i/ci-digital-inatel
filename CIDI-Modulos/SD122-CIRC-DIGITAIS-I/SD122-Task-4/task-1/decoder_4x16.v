/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-104
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decoder_4to16 (
	input  enable,
	input [3:0] binary_in,
	output reg [15:0] decoder_out
);

	always @ (enable or binary_in) begin
	  if (enable) begin
		case (binary_in)
		  4'h0 : 	decoder_out = 16'h0001;
		  4'h1 : 	decoder_out = 16'h0002;
		  4'h2 : 	decoder_out = 16'h0004;
		  4'h3 : 	decoder_out = 16'h0008;
		  4'h4 : 	decoder_out = 16'h0010;
		  4'h5 : 	decoder_out = 16'h0020;
		  4'h6 : 	decoder_out = 16'h0040;
		  4'h7 : 	decoder_out = 16'h0080;
		  4'h8 : 	decoder_out = 16'h0100;
		  4'h9 : 	decoder_out = 16'h0200;
		  4'hA : 	decoder_out = 16'h0400;
		  4'hB : 	decoder_out = 16'h0800;
		  4'hC : 	decoder_out = 16'h1000;
		  4'hD : 	decoder_out = 16'h2000;
		  4'hE : 	decoder_out = 16'h4000;
		  4'hF : 	decoder_out = 16'h8000;
		  default:	decoder_out = 16'h0000;
		endcase
	  end else begin
		decoder_out = 16'h0000;
	  end
	end

endmodule
