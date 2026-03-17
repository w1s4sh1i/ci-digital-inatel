/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-206
Type: Testbench
Data: november, 25 2025
*/

`timescale 1 ns / 1 ps;

module analysis_tb;

    // Sinais do Testbench
    reg clk;
    reg rst_n;
    reg x;

    // Fios para conectar aos módulos
    wire z_moore;
    wire z_mealy;

    // Instanciação dos Módulos (DUT - Device Under Test)
    moore_pass DUT0 (
        .clk(clk), .rst_n(rst_n), .x(x),
        .z(z_moore)
    );

    mealy_pass DUT1 (
        .clk(clk), .rst_n(rst_n), .x(x),
        .z(z_mealy)
    );

	// Geração de Clock
	always #1 clk = ~clk; // Período de 10ns

    // Sequência de Teste
    initial begin
        // 1. Reset
        {rst_n, x, clk} = 3'b000;
        #5;
        
	rst_n = 1'b1;

        // Enviar sequência de teste: 
	// sequence = 16b'0000000010101101
	// always @(posedge clk) x <= sequence[i]; i = i + 1'b1; 
        @(posedge clk) x <= 1'b0; 
        @(posedge clk) x <= 1'b1; 
        @(posedge clk) x <= 1'b1; 
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1; 
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b0; // Stopping here
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b0;
        @(posedge clk) x <= 1'b1;
        @(posedge clk) x <= 1'b0;

        // Finaliza a simulação
        @(posedge clk);
        
	#10;
        $finish;
    end

	// Monitorar os sinais para visualização
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD132-A206-mome.vcd"); 
        	$dumpvars(0, analysis_tb);

		$display("|Time	|Reset	|Input	|Moore	 |Mealy	  |");
        	$monitor("|%0t	|%b	|%b	|st:%d z:%b|st:%d z:%b|",
            		$time, rst_n, x,
            		DUT0.estado_atual, z_moore,
        	    	DUT1.estado_atual, z_mealy
		);
	end

endmodule
