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

module MAC_tb; 

	localparam WIDHT_IN = 8, WIDHT_OUT = 32, DELAY = 5, REPEAT = 10;
    input						clk, rst,
    input	[WIDHT_IN-1  : 0]	A, B,
    output	[WIDHT_OUT-1 : 0]	result
 
 	initial begin
		
		$dumpfile("CIDI-SD142-A306-A.vcd"); 
        $dumpvars(0, MAC_tb); 
		
		$display("|Reset	|A	|B	|Result		|";
		$monitor("%d * %d = %d", 
			rst, A, B, result
		); 
		
	end
	
	always #DELAY  clk = !clk;
	
	always @(posedge clk) begin
		seed1 <= $time; 
		seed2 <= $time + 10; 
	end
	
 	initial begin
 		{clk, rst} <= {0, 1};
 		{A, B} <= {8'b0, 8'b0}; 
 		#DELAY; 

		rst <= 0;
		#DELAY;
		
		for (i = 0; i < REPEAT; i = i + 1 ) begin
			
			@(posedge clk);
			A <= $random(seed1);
			B <= $random(seed2);   
			
			@(posedge clk);
			rst <= 1; 
			
			@(posedge clk);
			rst <= 0; 
		end 
		
		$finish;
	
	end

endmodule
