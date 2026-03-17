/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-205
Type: Testbench
Data: november, 26 2025
*/

`timescale 1 ns / 1 ps

module tb_sequencia_aleatoria;

	localparam DELAY = 10;
	
	initial begin
	
		$dumpfile("CIDI-SD132-A205.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", reset, clk, Q2, Q1, decimal_value);
	
	end

    always #5 clk = ~clk;
    
endmodule
