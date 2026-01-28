/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-201
Type: Laboratory
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

module registrador_4bits (
    input wire clk,
    input wire clear_n,   
    input wire preset_n,  // Preset assíncrono ativo baixo (0 para carregar 1010)
    input wire [3:0] d,   
    output reg [3:0] q    
);

	always @(posedge clk or negedge clear_n or negedge preset_n) begin
		if (!clear_n)
			q <= 4'b0000;      // Clear assíncrono: zera saída
		else if (!preset_n)
			q <= 4'b1010;      // Preset assíncrono: carrega 1010
		else
			q <= d;            // Carrega o dado na borda de subida do clock
	end

endmodule
