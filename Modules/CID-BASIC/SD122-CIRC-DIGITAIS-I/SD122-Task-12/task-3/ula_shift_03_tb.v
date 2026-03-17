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
Type: Testbeinch
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module ula_shift_03_tb;

	localparam DELAY = 10; 
    reg [3:0] A, B;
    reg [2:0] seletor;
    wire [3:0] resultado;

    ula_shift_03 UUT (
        .A(A), .B(B), .sel(seletor),
        .resultado(resultado)
    );

	initial begin
		
		$dumpfile("CIDI-SD122-A112-3.vcd");
        $dumpvars(0, ula_shift_03_tb);

		$display("|A	|B	|Select	|Result	|");
		$monitor("|%b	|%b	|%b	|%b	|",
			A, B, seletor, resultado
		);
	end
	
	initial begin

		seletor = 3'b000;
		
		A = 4'b0000; B = 4'b0000;  
		#DELAY;

		A = 4'b0010; B = 4'b0001;
		#DELAY;

		A = 4'b1100; B = 4'b1010;
		#DELAY;

		seletor = 3'b001;
		A = 4'b0101; B = 4'b0011;  
		#DELAY;

		A = 4'b1111; B = 4'b0001;
		#DELAY;

		A = 4'b1001; B = 4'b1001;
		#DELAY;

		seletor = 3'b010; 
		A = 4'b0011; B = 4'b0001; 
		#DELAY;

		A = 4'b0101; B = 4'b0101; 
		#DELAY;

		A = 4'b1111; B = 4'b1111; 
		#DELAY;

		seletor = 3'b011; 
		A = 4'b0011; B = 4'b0101; 
		#DELAY;

		A = 4'b1010; B = 4'b1100;
		#DELAY;

		A = 4'b0110; B = 4'b0011; 
		#DELAY;

		seletor = 3'b100;
		A = 4'b1111; B = 4'b0000;  
		#DELAY;

		A = 4'b1010; B = 4'b1111;
		#DELAY;

		A = 4'b0101; B = 4'b1100;
		#DELAY;


		seletor = 3'b101; 
		A = 4'b0001; B = 4'b0010; 
		#DELAY;

		A = 4'b1111; B = 4'b0001;
		#DELAY;

		A = 4'b1000; B = 4'b0111; 
		#DELAY;

		seletor = 3'b110; 
		A = 4'b0001; B = 4'b0010; 
		#DELAY;

		A = 4'b1111; B = 4'b0001;
		#DELAY;

		A = 4'b1000; B = 4'b0111;
		#DELAY;

		seletor = 3'b111;
		A = 4'b0001; B = 4'b0010;  
		#DELAY;

		A = 4'b1111; B = 4'b0001;  
		#DELAY;

		A = 4'b1000; B = 4'b0111;  
		#DELAY;

		$finish;

	end
	
endmodule
