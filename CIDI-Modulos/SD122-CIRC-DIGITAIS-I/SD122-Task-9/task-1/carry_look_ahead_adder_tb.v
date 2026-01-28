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

module carry_look_ahead_adder_tb;
	
	localparam DELAY = 10, WIDTH = 8; 
	reg [WIDTH-1 : 0] A, B;
	reg Cin;

	wire [WIDTH-1 :0] S;
	wire Cout;

	carry_look_ahead_adder #(.N(4)) DUT (
		.A(A), .B(B), .Cin(Cin),
		.S(S), .Cout(Cout)
	);
	
	initial begin
		
		$dumpfile("CIDI-SD122-A109-1.vcd"); 
        $dumpvars(0, carry_look_ahead_adder_tb); 
		
		$display("|A		|B		|Cin	|Cout	|Sum	  |");
		$monitor("|%b	|%b	|%b	|%b	|%b |", A, B, Cin, Cout, S );
	
	end
	
	initial begin
	
		// [ ] Definir testes completo com UVM.

		A = 8'b10110000; 
		B = 8'b11010000; 
		Cin = 0;
		#DELAY;
		
		A = 8'b01010000; 
		B = 8'b00110000; 
		Cin = 0;
		#DELAY;
		
		A = 8'b11100000;
		B = 8'b00010000;
		Cin = 0;
		#DELAY;
		
		A = 8'b10010000;
		B = 8'b01100000;
		Cin = 1;
		#DELAY;
		
		A = 8'b11111111;
		B = 8'b11111111;
		Cin = 0;
		#DELAY;
		
		$finish;    
	end
endmodule 
