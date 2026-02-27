/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T5)
Type: Laboratory
Data: febuary, 2 2026
*/

module single_port_rom #(
	parameter	DATA_WIDTH = 8,
				ADDR_WIDTH = 8
)(
	input 							clk,
	input 		[ADDR_WIDTH-1 : 0]	addr,
	output reg	[DATA_WIDTH-1 : 0]	q
);

	localparam SAMPLES = 2**ADDR_WIDTH; 

	reg [DATA_WIDTH-1:0] rom [SAMPLES-1:0];

	initial begin
		$readmemb("rom_single_port_init.txt", rom);
	end

	always @ (posedge clk) begin
		q <= rom[addr];
	end

endmodule
