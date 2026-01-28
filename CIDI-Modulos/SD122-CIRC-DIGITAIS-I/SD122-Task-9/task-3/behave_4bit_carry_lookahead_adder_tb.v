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

`timescale 1 ns / 1 ps;

module behave_4bit_carry_lookahead_adder_tb;

	localparam DELAY = 10; 
	reg [3:0] A, B;
	reg Cin;

	wire [3:0] Sb, Sr;
	wire Coutb, Coutr;

	behave_4bit_carry_lookahead_adder DUT0 (
		.A(A), .B(B), .Cin(Cin),
		.Sum(Sb), .Cout(Coutb)
	);

	rtl_4bit_carry_look_ahead_adder DUT1 (
		.A(A), .B(B), .Cin(Cin),
		.Sum(Sr), .Cout(Coutr)
	);

	initial begin
		
		$dumpfile("CIDI-SD122-A109-3.vcd"); 
        $dumpvars(0, behave_4bit_carry_lookahead_adder_tb); 
		
		$display("|A	|B	|Cin|Cout-Behave|Cout-RTL|SumB	|SumR	|");
		$monitor("|%b	|%b	|%b  |%b		|%b	 |%b	|%b	|", A, B, Cin, Coutb, Coutr, Sb, Sr );
	
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
