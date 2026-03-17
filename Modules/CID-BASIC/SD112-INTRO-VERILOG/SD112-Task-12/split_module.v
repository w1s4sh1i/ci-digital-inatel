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

// Atividade 12 - 4

module split_module #(parameter CONST = 10, WIDTH = 8)(
	input clk,rst,
	output out,
	output [WIDTH-1:0] out_counter
);
	wire out_comp;
	// wire [WIDTH-1:0] out_counter;

	contador_8bits #(.WIDTH (8))	C1 (
		.clk(clk), .rst(rst), 
		.en(out_comp), .out(out_counter)
	);
	comparador #(.CONST(CONST), .WIDTH(8))	C2 (
		.in(out_counter),
		.result(out_comp)
	);
	ffd_r	C3  (
		.clk(clk), .rst(rst),
		.D(out_comp), .Q(out)
	);

endmodule
