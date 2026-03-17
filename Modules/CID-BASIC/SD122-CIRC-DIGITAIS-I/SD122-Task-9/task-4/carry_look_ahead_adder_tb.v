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

	localparam DELAY = 10; 
	reg  [7:0] A, B;
	reg        Cin;
	wire [7:0] Sum;
	wire       Cout;

	// Instancia o módulo parametrizado
	behave_param_carry_look_ahead_adder #(.N(8)) DUT (
		.A(A), .B(B), .Cin(Cin),
		.Sum(Sum), .Cout(Cout)
	);

	initial begin
		
		$dumpfile("CIDI-SD122-A109-4.vcd"); 
        $dumpvars(0, carry_look_ahead_adder_tb); 
		
		$display("|A	 |B	  |Cin|Cout|Sum		|");
		$monitor("|%b|%b|%b  |%b   |%b	|", A, B, Cin, Cout, Sum);
	
	end

	initial begin 
		// Testes de 8 bits
		A = 8'b00011011; 
		B = 8'b00001101; 
		Cin = 0; 
		#DELAY;  // 27 + 13 = 40
		
		A = 8'b11110000; 
		B = 8'b00001111; 
		Cin = 0; 
		#DELAY;  // 240 + 15 = 255
		
		A = 8'b11111111;
		B = 8'b00000001; 
		Cin = 0;
		#DELAY;  // 255 + 1 = 0 (Cout=1)
		
		A = 8'b10101010;
		B = 8'b01010101;
		Cin = 1; 
		#DELAY;  // 170 + 85 + 1 = 256
		
		A = 8'b00000000;
		B = 8'b11111111;
		Cin = 0;
		#DELAY;  // 0 + 255 = 255

		$finish;
	end

endmodule
