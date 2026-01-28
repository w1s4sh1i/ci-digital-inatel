/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-203
Type: Testbench
Data: november, 24 2025
*/

`timescale 1 ns / 1 ps

module tb_contador_ascendente_4bits;

	localparam DELAY = 10;
    reg clk, reset;
    wire [3:0] Q;

    contador_ascendente_4bits uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );
	initial begin
	
		$dumpfile("CIDI-SD132-A203-2.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", A, B, prod);
	
	end
	
	always #5 clk = ~clk; // clock com período de 10 unidades
	
    initial begin
        clk = 0; reset = 1;
        #10 reset = 0;   // libera reset
        #200 $finish;    // encerra simulação
    end

endmodule
