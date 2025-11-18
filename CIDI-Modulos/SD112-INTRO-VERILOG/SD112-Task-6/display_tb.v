/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-006
Type: Testbench
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module display_tb; // parameter for alternative testing
	
	localparam DELAY = 10; 
	reg		[3:0]   display_in;
	reg              	dp;
	wire		[6:0]   display_out;

	display U1(.display_in(display_in), .dp(dp), .display_out(display_out)); // 

	initial begin
	    
		// Specify the VCD file name
		$dumpfile("CID-SD112-A006-display.vcd"); 
	    	$dumpvars(0, display_tb); 
		
		// Editar
		$display("|Command	|Display	|DP	|");
		$monitor("|%b		|%b	|%b	|", display_in, display_out, dp);

		// for()begin ... end
		
		dp = 1'b0; // << 
		display_in = 4'b0000; 
		#DELAY;
		
		display_in = 4'b0001; 
		#DELAY;
		
		display_in = 4'b0010; 
		#DELAY;
		
		display_in = 4'b0011; 
		#DELAY;
		
		display_in = 4'b0100; 
		#DELAY;
		
		display_in = 4'b0101; 
		#DELAY;
		
		display_in = 4'b0110; 
		#DELAY;
		
		display_in = 4'b0111; 
		#DELAY;
		
		display_in = 4'b1000; 
		#DELAY;
		
		display_in = 4'b1001; 
		#DELAY;
		
		display_in = 4'b1010; 
		#DELAY;
		
		display_in = 4'b1011; 
		#DELAY;
		
		display_in = 4'b1100; 
		#DELAY;
		
		display_in = 4'b1101; 
		#DELAY;
		
		display_in = 4'b1110; 
		#DELAY;
		
		display_in = 4'b1111; 
		#DELAY;
		
		dp = 1'b1; // << 
		display_in = 4'b111x; 
		#DELAY;
		   
		$finish;

	end
endmodule
