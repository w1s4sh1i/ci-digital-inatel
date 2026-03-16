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
    reg cin;
    reg [2:0] seletor;
    wire [3:0] resultado;
    wire carry_out, Z;

    ula DUT (
        .A(A), .B(B), .carry_in(cin), .seletor(seletor),
        .resultado(resultado), .carry_out(carry_out), .Z(Z)
    );
	
	initial begin
		
		$dumpfile("CIDI-SD122-A112-4.vcd");
        $dumpvars(0, ula_tb);

		$display("|A	|B	|Cin|Select	|Result	|Z |");
		$monitor("|%b	|%b	|%b  |%b	|%b	|%b |",
			A, B, cin, seletor, resultado, Z
		);
	end

    initial begin

        seletor = 3'b100;
		cin = 0;
		
		A = 4'b0000; B = 4'b0000;  
		#DELAY;

		A = 4'b0001; B = 4'b0001; 
		#DELAY;

		A = 4'b0011; B = 4'b0101;
		#DELAY;

		cin = 1;
		A = 4'b1010; B = 4'b0101;  
		#DELAY;

		A = 4'b1111; B = 4'b1111;
		#DELAY;

		seletor = 3'b000; 
		A = 4'b1010; B = 4'b1100; 
		#DELAY;

		seletor = 3'b001; 
		A = 4'b0011; B = 4'b0101; 
		#DELAY;

		seletor = 3'b101; 
		A = 4'b1001; B = 4'b0100;
		#DELAY;

        $finish;
    end
endmodule
