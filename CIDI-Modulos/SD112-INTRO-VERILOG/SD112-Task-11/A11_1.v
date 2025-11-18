/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-011
Type: Laboratory
Data: octuber, 25 2025
*/

`timescale 1 ns / 1 ps;

module A11_1 #(parameter CONST = 10)(
    input clk, rst,
    output  reg out
);
reg [3:0] out_counter;
reg en;

	always @ (posedge clk, posedge rst) begin
		
		if (rst)begin
		     out_counter <= 4'b0000;
		     en <= 1'b0;
		end else if (!en) begin
		      out_counter <= out_counter + 1;
		end else begin
		      out_counter <= out_counter;
		end
		   
	end
	
	always @(posedge clk, posedge rst) begin
		if (rst) begin
		    out <= 1'b0;
		end else begin
		    out <= en;
		end
	end

	always @ (out_counter) begin
		
		if (CONST == out_counter) begin
		    en <= 1'b1;
		end else
		    en <= 1'b0;
	
	end
	
endmodule
