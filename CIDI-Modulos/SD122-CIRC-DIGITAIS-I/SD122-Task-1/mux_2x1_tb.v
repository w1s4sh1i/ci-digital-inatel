/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-101
Type: Testbench
Data: octuber, 29 2025
*/

`timescale 1 ns / 1 ps;

module mux2x1_tb;

	localparam DELAY = 10;
	reg  [1:0] D; 
	reg sel;
	wire [4:0] y;
    
	// [x] All mux_2x1 testing;

	mux2 UUT0 (
    		.a(D[1]), .b(D[0]), .sel(sel),
    		.y(y[0])
	);
	
	mux3 UUT1 (
		.D(D), .sel(sel),
    		.y(y[1])
	);
	
	mux_est UUT2 ( 
		.a(D[1]), .b(D[0]), .sel(sel),
    		.y(y[2])
	);
	
	mux_rtl UUT3 (
		.a(D[1]), .b(D[0]), .sel(sel),
    		.y(y[3])
	);
	
	mux4_comport UUT4 (
		.a(D[1]), .b(D[0]), .sel(sel),
    		.y(y[4])
	);
	
	// Execução em paralelo
    	always #1 D[0] = !D[0];
    	always #2 D[1] = !D[1];
    	always #4  sel =  !sel;

    	initial begin
			// Specify the VCD file name
			$dumpfile("CIDI-SD122-A101-1.vcd"); 
        	$dumpvars(0, mux2x1_tb);
		
			$display("|A |B |Select	|M0|M1|M2|M3|M4|");
			$monitor("|%b |%b |%b 	|%b |%b |%b |%b |%b |",D[1], D[0], sel, y[0], y[1], y[2], y[3], y[4]);
      
     	 	// se 1 -> a, 0 -> b
      		sel = 1'b0;
      
			//{a,b} = 2'b00;
			D = 2'd0;
	      
			#DELAY;
			$finish;
		end

endmodule
