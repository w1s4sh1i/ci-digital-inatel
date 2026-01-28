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

module registrador_16bits (
    input wire clk,
    input wire rst,       
    input wire [15:0] d,  
    output reg [15:0] q   
);

	always @(negedge clk) begin
		if (rst)
			q <= 16'b0; 
		else
			q <= d;
	end

endmodule
