/*
Program: CI Digital 02/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-110
Type: Testbench
Data: november, 17 2025
*/

`timescale 1ns / 1ps

module adder_bcd_tb;

    // Parâmetros de referência
    localparam DELAY = 10;
	reg [3:0] A, B;
    reg Cin;

    // Parâmetros de saída
    wire [3:0] S;
    wire Cout;

    // Instanciação do módulo somador_bcd
    adder_bcd DUT (
        .A(A), .B(B), .Cin(Cin),
    	.S(S), .Cout(Cout)
    );

    // Procedimento inicial para aplicar os testes
    initial begin
		
		$dumpfile("CIDI-SD122-A110-1.vcd"); 
        $dumpvars(0, adder_bcd_tb); 
		
		$display("|A	|B	|Cin	|Cout	|Sum	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|", A, B, Cin, Cout, S);
	end

	initial begin

        A = 4'd0; 
		B = 4'd0; 
		Cin = 1'b0; 
		#DELAY; // Test 0: 00 + 00 = 00
        
		A = 4'd6; 
		B = 4'd9; 
		Cin = 1'b0; 
		#DELAY; // Test 1: 69 + 00 = 69

        A = 4'd03; 
		B = 4'd03; 
		Cin = 1'b1; 
		#DELAY; // Test 2: 33 + 01 = 34
        
		A = 4'd04;
		B = 4'd05;
		Cin = 1'b0;
		#DELAY; // Test 3: 45 + 00 = 45

        A = 4'd9;
		B = 4'd9; 
		Cin = 1'b1; 
		#DELAY;// Teste 4: 99 + 01 = 100
        
		A = 4'd8;
		B = 4'd2; 
		Cin = 1'b0; 
		#DELAY; // Test 5: 82 + 00 = 82
        
		A = 4'd9;
		B = 4'd9; 
		Cin = 1'b0; 
		#DELAY; // Test 6: 99 + 00 = 99

        $finish;
    end

endmodule
