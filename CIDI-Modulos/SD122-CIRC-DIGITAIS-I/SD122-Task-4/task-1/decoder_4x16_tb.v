/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-104
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decoder_4x16_tb();
	
	localparam DELAY = 10; 
    reg enable;
    reg [3:0] binary_in;
    wire [15:0] decoder_out;

    decoder_4to16 dec_4x16_tb(
        .enable(enable),
        .binary_in(binary_in),
        .decoder_out(decoder_out)
    );

    initial begin
			
		// Specify the VCD file name
		$dumpfile("CIDI-SD122-A104-1.vcd"); 
		$dumpvars(0, decoder_4x16_tb); 
		
		// Editar
		$display("|Input	|Out	|");
		$monitor("|%b		|%b		|", in, out); 
	  
		enable = 1'b1;

		binary_in = 4'h0; 
		#DELAY;
		
		binary_in = 4'h1; 
		#DELAY;
		
		binary_in = 4'h2; 
		#DELAY;
		
		binary_in = 4'h3; 
		#DELAY;
		
		binary_in = 4'h4; 
		#DELAY;
		
		binary_in = 4'h5; 
		#DELAY;
		
		binary_in = 4'h6; 
		#DELAY;
		
		binary_in = 4'h7; 
		#DELAY;
		
		binary_in = 4'h8; 
		#DELAY;
		
		binary_in = 4'h9; 
		#DELAY;
		
		binary_in = 4'hA; 
		#DELAY;
		
		binary_in = 4'hB; 
		#DELAY;
		
		binary_in = 4'hC; 
		#DELAY;
		
		binary_in = 4'hD; 
		#DELAY;
		
		binary_in = 4'hE; 
		#DELAY;
		
		binary_in = 4'hF; 
		#DELAY;

		$finish;
	end


endmodule
