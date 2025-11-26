/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-208
Type: Testbench-Example
Data: november, 26 2025
*/

`timescale 1 ns / 1 ps;

module mult4x4_tb;

	localparam DELAY = 1; 
	reg clk;
	reg St;
	reg [3:0] Mplier;
	reg [3:0] Mcand;
	
	wire Done;
	wire [8:0] ACC;

	mult4x4 UUT (
		.clk(clk), .St(St), .Mplier(Mplier), .Mcand(Mcand),
		.Done(Done), .ACC(ACC)
	);
	
	always #DELAY clk = ~clk; 

	initial begin // add samples
		
		clk = 1'b1; 
		St = 1'b1;
		Mplier = 4'b0010;
		Mcand  = 4'b0010;
		#(DELAY*15); 

		$finish; 
	end
	
	initial begin
		// Specify the VCD file name
		$dumpfile("CIDI-SD132-A208-1.vcd"); 
		$dumpvars(0, mult4x4_tb); 
		
		// Editar
		$display("|Clock  |ST |Mplier	|Mcand	|Done	|ACC		|");
		$monitor("|%b	|%b  |%b	|%b	|%b	|%b	|", 
			  clk, St, Mplier, Mcand, Done, ACC
		); 
	end
	
endmodule

