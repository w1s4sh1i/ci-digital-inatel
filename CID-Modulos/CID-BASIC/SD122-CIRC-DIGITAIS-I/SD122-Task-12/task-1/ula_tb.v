/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-112
Type: Testbench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module ula_tb;

	localparam DELAY = 10;
	reg [3:0] A, B;
	reg [2:0] seletor;
	wire [3:0] resultado;

	ula UUT (
	    .A(A), .B(B), .sel(seletor),
	    .resultado(resultado)
	);
	
	initial begin
		
		$dumpfile("CIDI-SD122-A112-1.vcd");
        $dumpvars(0, ula_tb);

		$display("|A	|B	|Select	|Result	|");
		$monitor("|%b	|%b	|%b	|%b	|",
			A, B, seletor, resultado
		);
	end
	
	initial begin

		A = 4'b0000;
		B = 4'b0000;
		seletor = 3'b000;
		#DELAY;
		
		A = 4'b0010;
		B = 4'b0001;
		seletor = 3'b000;
		#DELAY;
		
		A = 4'b1100;
		B = 4'b1010;
		seletor = 3'b000;
		#DELAY;

		A = 4'b0101;
		B = 4'b0011;
		seletor = 3'b001;
		#DELAY;
		
		A = 4'b1111;
		B = 4'b0001;
		seletor = 3'b001;
		#DELAY;
		
		A = 4'b1001;
		B = 4'b1001;
		seletor = 3'b001;
		#DELAY;

		A = 4'b0011;
		B = 4'b0001;
		seletor = 3'b010;
		#DELAY;
		
		A = 4'b0101;
		B = 4'b0101;
		seletor = 3'b010;
		#DELAY;
		
		A = 4'b1111;
		B = 4'b1111;
		seletor = 3'b010;
		#DELAY;

		A = 4'b0011;
		B = 4'b0101;
		seletor = 3'b011;
		#DELAY;
		
		A = 4'b1010;
		B = 4'b1100;
		seletor = 3'b011;
		#DELAY;
		
		A = 4'b0110;
		B = 4'b0011;
		seletor = 3'b011;
		#DELAY;

		A = 4'b1111;
		B = 4'b0000;
		seletor = 3'b100;
		#DELAY;
		
		A = 4'b1010;
		B = 4'b1111;
		seletor = 3'b100;
		#DELAY;
		
		A = 4'b0101;
		B = 4'b1100;
		seletor = 3'b100;
		#DELAY;

		A = 4'b0001;
		B = 4'b0010;
		seletor = 3'b101;
		#DELAY;
		
		A = 4'b1111;
		B = 4'b0001;
		seletor = 3'b101;
		#DELAY;
		
		A = 4'b1000;
		B = 4'b0111;
		seletor = 3'b101;
		#DELAY;

		$finish;
	end
endmodule
