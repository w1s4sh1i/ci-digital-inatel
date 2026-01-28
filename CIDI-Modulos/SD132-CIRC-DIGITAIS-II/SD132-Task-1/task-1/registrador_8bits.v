/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-20X
Type: Laboratory
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

module registrador_8bits (
    input 				clk, rst_n,   
    input 		[7:0]	d, 
    output reg	[7:0]	q  
);

	always @(posedge clk or negedge rst_n) begin
		q <= (!rst_n) ? 8'b0 : d; 
	end

endmodule
