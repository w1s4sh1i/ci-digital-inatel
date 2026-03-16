/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-011
Type: Testbench
Data: octuber, 25 2025
*/

`timescale 1 ns / 1 ps;

module delay_action_tb;
	
	localparam DELAY = 10;
	reg clk, rst;
	wire out;
	wire [3:0] counter; 

	delay_action UUT (
		.clk(clk), .rst(rst),
		.out(out), .out_counter(counter)
	);
	
	always #5 clk = ~clk;

	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A011.vcd"); 
        $dumpvars(0, delay_action_tb); 
		
		// Editar
		$display("|Count |Reset	|Out	|");
		$monitor("|%d	|%b	| %b	|", counter, rst, out);
		
		{clk,rst} = 2'b11; 
		#DELAY; 
		
		rst = 1'b0;
		#(DELAY*20);
		
		rst = 1'b1;
		#DELAY;
		
		$finish;
	end

endmodule
