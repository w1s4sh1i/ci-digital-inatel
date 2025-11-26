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

module decoderNxM_tb;
    
    localparam DELAY = 10; 
    parameter N = 4;
    parameter M = (1 << N); // log(N) 

    reg  [N-1:0] in;
    wire [M-1:0] out;

    // Instancia o decodificador
    decoderNxM #(N) DUT (
        .in(in),
        .out(out)
    );

    initial begin
       
		// Specify the VCD file name
		$dumpfile("CIDI-SD122-A104-2.vcd"); 
        	$dumpvars(0, decoderNxM_tb); 
		
		// Editar
		$display("|Input	|Out			|");
		$monitor("|%b	|%b	|", in, out);

		// Testa todas as combinações
		in = 0;  #DELAY;
		in = 1;  #DELAY;
		in = 3;  #DELAY;
		in = 7;  #DELAY;
		in = 13; #DELAY;
		$finish;
	end

endmodule
