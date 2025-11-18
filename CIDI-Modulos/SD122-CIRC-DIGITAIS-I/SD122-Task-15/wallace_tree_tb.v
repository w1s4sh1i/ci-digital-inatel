/*
Program: CI Digital T2/2025
Class: Circuito Digital 1  
Class-ID: SD122
Advisor: Felipe Rocha 
Devicer-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A115
Type: Testbench
Data: november, 17 2025
*/

`timescale 1 ns / 10 ps

// Testing version 
// [x] 1;
// [ ] 2;
 
module wallace_tb;

	localparam DELAY = 10, N = 4, M = 8, L = 16; 	
	reg [N-1 : 0] A;
	reg [N-1 : 0] B;

	wire 	[M-1 : 0] prod;
	integer i, j, error;

	wallace UUT (
		.A(A), 
		.B(B),
		.prod(prod)
	);

	initial begin

		$dumpfile("CIDI-SD122-A115-wallace.vcd"); 
		$dumpvars(0, wallace_tb); 	
		
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", A, B, prod);
		
		// Apply inputs for the whole range of A and B.
		error = 0;
		
		for(i = 0; i <= L-1; i = i+1) begin
			for(j = 0; j <= L-1; j = j+1) begin
				
				A <= i; 
				B <= j;
				#DELAY;
				
				if(prod != A*B) 
					//if the result isnt correct increment "error".
				    error = error + 1;  
			end     
		end
   	end
endmodule
