/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T1)
Type: Laboratory
Data: febuary, 2 2026
*/

`timescale 1 ns / 1ps

module ram_single_port #(
	parameter	DATA_WIDTH = 8,
				ADDR_WIDTH = 6
)(
	input we, clk,
	input [(DATA_WIDTH-1) : 0] data,
	input [(ADDR_WIDTH-1) : 0] addr,
	output [(DATA_WIDTH-1):0] q
);

	reg [DATA_WIDTH-1 : 0] ram [0 : 2**ADDR_WIDTH-1];
	reg [ADDR_WIDTH-1 : 0] addr_reg;
	
	// initial
	
	always @ (posedge clk) begin
		
		ram[addr]	<= we ? data : ram[addr];
		addr_reg	<= we ? addr : addr_reg;
	
	end
	
	assign q = ram[addr_reg];

endmodule
