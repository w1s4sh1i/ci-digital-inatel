/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-012
Type: Testbench
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module tb_counter_24;

	reg clk,reset,en;
    wire [23:0] count;

	counter_24 U1 (
		.clk(clk),.reset(reset), .en(en),
		.count(count)
	);

    

  always #5 clk = ~clk;
  
    initial begin
    clk = 0;
    reset = 1;
    en = 0;     
    #20;
    reset = 0;
    #1000;       
    $finish;
    end

    

                
endmodule






