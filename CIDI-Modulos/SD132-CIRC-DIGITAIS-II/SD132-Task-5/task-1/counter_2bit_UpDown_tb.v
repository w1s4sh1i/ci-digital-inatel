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

`timescale 1ns / 1ps

module counter_2bit_UpDown_tb;

    localparam DELAY = 10;
    reg clk, rst, up;

    // Saída
    wire [1:0] CNT;

    // Instanciação do módulo a ser testado
    counter_2bit_UpDown UUT (
        .CNT(CNT), .clk(clk), .rst(rst),
        .up(up)
    );
	
	initial begin
	
		$dumpfile("CIDI-SD132-A205.vcd"); 
		$dumpvars(0, counter_2bit_UpDown_tb); 	
		
		// Editar 
		$display("|	|	|		|");
		$monitor("|%b 	|%b	|%b	|", reset, clk, Q2, Q1, decimal_value);
	
	end
    // Geração do clk: 100 MHz → 10ns período
    always #5 clk = ~clk;

    // Sequência de estímulos
    initial begin

		clk = 0;
        // Inicializa sinais
        rst = 0;
        up = 1;

        // Espera uma borda de clk para aplicar rst
        @(posedge clk);
        rst = 0;
        @(posedge clk);
        rst = 1;

        // Contagem crescente
        repeat (5) @(posedge clk);

        // Contagem decrescente
        up = 0;
        repeat (5) @(posedge clk);

        // rst novamente
        rst = 0;
        @(posedge clk);
        rst = 1;
        up = 1;

        // Contagem crescente novamente
        repeat (4) @(posedge clk);

        $finish;
    end
    
endmodule
