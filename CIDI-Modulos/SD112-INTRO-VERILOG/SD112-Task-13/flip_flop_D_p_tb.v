/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Testbench
Data: octuber, 27 2025
*/

`timescale 1 ns / 1 ps;

module flip_flop_D_p_tb;

	localparam DELAY = 10;
	reg d, clk, rst;
    	wire q;

    	flip_flop_D_p UUT (q, d, clk, rst);

	// always  #(DELAY/2) clk = ~clk;	
    
    	initial begin
        	clk = 0;
        	forever #5 clk = ~clk; 
    	end


    	initial begin
    	
    	// Specify the VCD file name
		$dumpfile("CIDI-SD112-A013-2-ffd.vcd"); 
        	$dumpvars(0, flip_flop_D_p_tb); 
		
		$display("|Clock  |Reset  |D |Q |");
		$monitor("|%b	|%b	|%b |%b |", clk, rst, d, q);
		
		{rst,d} = 2'b11; 
		#DELAY;
		
		rst = 1'b0;
		#DELAY;

		d = 1'b1; 
		#DELAY;
		
		d = 1'b0; 
		#DELAY;
		
		#(DELAY*2);
		$finish;
	end

endmodule
