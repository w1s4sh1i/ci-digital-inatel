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

// [x] Ação de limitação do clock, com base em um valor de referência (CONST) e reativação dependente do reset.  

module delay_action #(parameter CONST = 10)(
	input clk, rst,
	output reg out,
	output reg [3:0] out_counter // controll analysis -> remover 
);
	
	// reg [3:0] out_counter // controll analysis -> remover 
	wire en;
	
	assign en = (CONST == out_counter) & ~rst;

	always @(posedge clk, posedge rst) begin // always @(*) begin
		
		if (rst)begin
		     out_counter <= 4'b0000;
		end else if (!en) begin
		      out_counter <= out_counter + 1;
		end else begin
		      out_counter <= out_counter;
		end
		
		/*
	    	out_counter <= (out_counter + (!en)) & (~rst);
	    	out <= (rst) ? 1'b0 : en;
		*/  
	end
	
	always @(posedge clk, posedge rst) begin
		
		out <= (rst) ? 1'b0 : en;
		
	end
	
endmodule
