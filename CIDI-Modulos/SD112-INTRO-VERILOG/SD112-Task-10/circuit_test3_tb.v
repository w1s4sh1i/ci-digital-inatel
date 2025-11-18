/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-010
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;
  
module circuit_test3_tb;

	localparam DELAY = 10; // , SAMPLES = 16;  
	reg a, b,c, d;
	wire s;

	circuit_test3 UUT (
		.a(a), .b(b), .c(c), .d(d),
		.s(s)
	);

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A010-4.vcd"); 
		$dumpvars(0, circuit_test3_tb); 
		
		// for(i = 0; i < SAMPLES-1; i = i + 1) begin 
		// 		{a,b,c,d} = 4'di; #DELAY;
		// ... end
		
		{a,b,c,d} = 4'b0001;
		#DELAY; 
		
		{a,b,c,d} = 4'b0010;
		#DELAY; 
		
		{a,b,c,d} = 4'b0100;
		#DELAY; 
		
		{a,b,c,d} = 4'b0101;
		#DELAY; 
		
		{a,b,c,d} = 4'b0110;
		#DELAY; 
		
		{a,b,c,d} = 4'b0111;
		#DELAY; 
		
		{a,b,c,d} = 4'b1000;
		#DELAY;
		
		{a,b,c,d} = 4'b1001;
		#DELAY; 
		
		{a,b,c,d} = 4'b1010;
		#DELAY; 
		
		{a,b,c,d} = 4'b1100;
		#DELAY; 
		
		{a,b,c,d} = 4'b1101;
		#DELAY; 
		
		{a,b,c,d} = 4'b1110;
		#DELAY; 
		
		{a,b,c,d} = 4'b1111;
		#DELAY; 
		
		$finish;
	end
                
endmodule

