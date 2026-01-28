/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-109
Type: Testbench
6Data: november, 16 2025
*/

`timescale 1 ns / 1 ps

module carry_look_ahead_adder_tb;

	localparam DELAY = 10; 
	reg [3:0] A, B;
	reg Cin;

	wire [3:0] S;
	wire Cout;

	carry_look_ahead_adder #(.N(4)) DUT (
		.A(A), .B(B), .Cin(Cin),
		.S(S), .Cout(Cout)
	);

	initial begin
		
		$dumpfile("CIDI-SD122-A109-2.vcd"); 

        	$dumpvars(0, carry_look_ahead_adder_tb); 

		$display("|A	|B	|Cin	|Cout	|Sum	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|", A, B, Cin, Cout, S );
	end

	initial begin

		A = 4'b1011; 
		B = 4'b1101; 
		Cin = 0;
		#DELAY;

		A = 4'b0101; 
		B = 4'b0011; 
		Cin = 0;
		#DELAY;

		A = 4'b1110; 
		B = 4'b0001; 
		Cin = 0;
		#DELAY;

		A = 4'b1001;
		B = 4'b0110;
		Cin = 1;
		#DELAY;

		A = 4'b1111;
		B = 4'b1111; 
		Cin = 0;
		#DELAY;

		$finish;    
	end

endmodule 
