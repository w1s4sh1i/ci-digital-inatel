/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T1)
Type: TestBench
Data: febuary, 2 2026
*/

`timescale 1 ns / 1ps

module ram_single_port_tb;

  // Parâmetros
  parameter	DATA_WIDTH = 8,
			ADDR_WIDTH = 6;

  // Sinais
  reg we, clk;
  reg [DATA_WIDTH-1:0] data;
  reg [ADDR_WIDTH-1:0] addr;
  wire [DATA_WIDTH-1:0] q;

  // Instanciando a RAM
  ram_single_port #(DATA_WIDTH, ADDR_WIDTH) uut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  // Clock
  initial clk = 0;
  
  always #5 clk = ~clk;  // Clock de 10ns (100MHz)

  // Estímulo
	initial begin

		// Specify the VCD file name	
		$dumpfile("CIDI-SD142-A301-ram.vcd"); 
		$dumpvars(0, ram_single_port_tb);   	

		$monitor("|%0d	    |%b	|%d	|%d	|%d	|",
				  $time, we, addr, data, q
		);
	end 
	
	initial begin
		$display("Iniciando Testbench...");
		$display("|Tempo (ns) |WE	|Addr	|Data in|Data out|");
		// Inicializa sinais
		we = 0;
		addr = 0;
		data = 0;

		// Aguarda reset inicial
		#10;

		// Escreve na posição 3 o valor 42
		addr = 6'd3;
		data = 8'd42;
		we = 1;
		#10;

		// Escreve na posição 10 o valor 99
		addr = 6'd10;
		data = 8'd99;
		#10;

		// Leitura da posição 3
		we = 0;
		addr = 6'd3;
		#10;

		// Leitura da posição 10
		addr = 6'd10;
		#10;

		// Leitura de endereço ainda não escrito (posição 5)
		addr = 6'd5;
		#10;

		$display("Fim da simulação.");
		$finish;
	end

endmodule
