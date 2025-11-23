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

module split_module_tb;
	
	localparam DELAY = 10, WIDTH = 8;
	reg clk, rst;
	wire out;
	wire [WIDTH-1:0] out_counter;

	split_module #(.CONST(10), .WIDTH (8)) UUT (
		.clk(clk), .rst(rst),
		.out(out), .out_counter(out_counter) 
	);

	always #(DELAY/2) clk = ~clk;

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A012-3-split.vcd"); 
		$dumpvars(0, split_module_tb); 
			
		$display("|Clock	|Reset	|Out	|Count |");
		$monitor("|%b	|%b	|%b	|%d	|", clk, rst, out, out_counter);
		
		clk = 1'b0;
		rst = 1'b1; 
		#DELAY; 

		rst = 1'b0;
		#(DELAY*10); 
		
		rst = 1'b1;
		#DELAY;
		$finish;
	end

endmodule
