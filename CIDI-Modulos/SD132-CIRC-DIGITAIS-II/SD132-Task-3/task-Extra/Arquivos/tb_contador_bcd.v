/*
Program: CI Digital 02/2025
Class: Circuito Digitais II
Class-ID: SD132
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

module tb_contador_bcd;

	localparam DELAY = 10;
    reg clk;
    reg reset;

    wire [3:0] Q1, Q2;

    contador_bcd DUT (
        .clk(clk),
        .reset(reset),
        .Q1(Q1),
        .Q2(Q2)
    );
    
	initial begin
	
		$dumpfile("CIDI-SD132-A203-3.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", reset, clk, Q2, Q1, decimal_value);
	
	end
	
    always #(DELAY/2) clk = ~clk;

	wire [4:0] decimal_value;
    assign decimal_value = Q2 * 10 + Q1;

    initial begin
        clk = 0;
        reset = 1;
        #(DELAY*2);
        reset = 0;

        #(DELAY*30);
        $finish;
    end
    
endmodule
