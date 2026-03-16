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

module counter_24_tb;

	localparam DELAY = 10, WIDTH = 24;
	reg  clk,reset,en;
	wire [WIDTH-1 : 0] count;

	counter_24 UUT (
		.clk(clk),.reset(reset), .en(en),
		.count(count)
	);

  	always #(DELAY/2) clk = ~clk;
  
	initial begin
	
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A012-2-count.vcd"); 
        $dumpvars(0, counter_24_tb); 
		
		$display("|Reset  |Enable |Count	 |"); 
		$monitor("|%b	|%b	|%d|", reset, en, count);

		{clk, reset, en} = 3'b010;     
		#DELAY;
		
		reset = 1'b0;
		#(DELAY*10);
		
		en = 1'b1;
		#(DELAY*5);

		reset = 1'b1;
		#DELAY; 
		$finish;
	end

endmodule
