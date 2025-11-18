/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;
module paridade_tb;

    localparam WIDTH = 8, DELAY = 10;

    reg [WIDTH-1:0] in;
    wire            out;

    paridade #(.WIDTH(WIDTH)) U1 (
        .in(in),
        .out(out)
    );

    initial begin
        
		in = 8'b00000000;
		#DELAY
		
		in = 8'b00000001;
		#DELAY

		in = 8'b10000010;
		#DELAY
		
		in = 8'b00000011;
		#DELAY

		in = 8'b10101010;
		#DELAY
		
		in = 8'b00101010;
		#DELAY

		in = 8'b01110001;
		#DELAY
		
		in = 8'b11100011;
		#DELAY

		in = 8'b10001010;
		#DELAY
		
		in = 8'b11111111;
		#(DELAY*2);
        $finish; 
        
    end

endmodule
