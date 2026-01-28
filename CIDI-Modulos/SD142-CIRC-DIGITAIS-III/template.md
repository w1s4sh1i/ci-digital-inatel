/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-30x
Type: Testbench
Data: january, 28 2025
*/

`timescale 1 ns / 1 ps

module tb_sequencia_aleatoria;

	localparam DELAY = 10;
	
	initial begin
	
		$dumpfile("CIDI-SD142-A30x.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|	|	|		|");
		$monitor("|%b 	|%b	|%b	|", );
	
	end

    always #(DELAY/2) clk = ~clk;
    
endmodule
