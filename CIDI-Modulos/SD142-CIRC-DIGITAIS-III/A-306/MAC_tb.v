/*
Program: CI Digital T2/2025
Class: Circuito Digitais III 
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306
Type: Testbench
Data: febuary, 03 2026
*/

`timescale 1 ns / 1 ps;

module MAC_tb; 

	localparam	WIDHT_IN = 8,	
				WIDHT_OUT = 32,
				DELAY = 10,
				REPEAT = 10;
    reg							clk, rst;
    reg		[WIDHT_IN-1  : 0]	A, B;
    wire	[WIDHT_OUT-1 : 0]	result;
 	
 	integer seed1, seed2, seed3, seed4, i; 
 	
 	MAC MAC_testbench (
		.clk(clk), .rst(rst),
		.A(A), .B(B),
		.result(result)
	);
	
	// Exposição dos dados
 	
 	initial begin
		
		$dumpfile("CIDI-SD142-A306-mac.vcd"); 
        $dumpvars(0, MAC_tb); 
		
		$display("|clk	|A * B = Result	|");
		$monitor("|%d	|%d * %d = %d	|",clk, A, B, result);
		
	end
	
	always #1  clk = !clk;
	
	always @(posedge clk) begin
		seed1 <= $time +  0; 
		seed2 <= $time + 100; 
		seed3 <= $time + 200; 
		seed4 <= $time + 300;
	end
	
 	initial begin
 		
 		{clk, rst} <= {1'b0, 1'b1};
 		{A, B} <= {8'b0, 8'b0}; 
 		#(DELAY/5); 

		rst <= 1'b0;
		
		for (i = 0; i < REPEAT; i = i + 1 ) begin
			
			@(posedge clk);
			A <= $random(seed1) + $random(seed3);
			B <= $random(seed2) + $random(seed4);   
			#(DELAY/2);
			/*
			@(posedge clk);
			rst <= 1'b1;
			
			@(posedge clk);
			rst <= 1'b0;	
			*/
		end 
		
		rst <= 1'b1;
		#DELAY;
		
		$finish;
	
	end
	
endmodule
