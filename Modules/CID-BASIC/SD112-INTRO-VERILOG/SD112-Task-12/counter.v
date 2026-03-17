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

module counter #(parameter WIDTH = 8)(
	input clk, reset, en,
	output reg [WIDTH-1:0] count,
	output reg carry
);

	always @(posedge clk) begin
		// [ ] Versão apenas com condições em gate-level.
		// count <= (count + ~en) & ~(count == {WIDTH{1'b1}} ) & ~reset;
		// carry <= (count == {WIDTH{1'b1}})
		if (reset) begin
			count <= {WIDTH{1'b0}};
			carry <= 1'b0;
		end else if (en) begin 
			count <= count;
			carry <= 1'b0; 
		end else begin 
			if (count == {WIDTH{1'b1}}) begin
				count <= {WIDTH{1'b0}};
				carry <= 1'b1;
			end else begin
		    		count <= count + 1'b1;
		    		carry <= 1'b0;
		end
	    end
	end

endmodule
