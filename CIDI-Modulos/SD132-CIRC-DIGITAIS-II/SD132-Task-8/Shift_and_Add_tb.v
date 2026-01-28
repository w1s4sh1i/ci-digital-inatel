/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-208
Type: Testbench
Data: november, 29 2025
*/

`timescale 1 ns / 1 ps

module Shift_and_Add_tb;

	localparam DELAY = 10, N = 4;
    reg 			clk;
    reg 			St;
    reg  [N-1:0]	Mplier, Mcand; 
    wire 			K;
    wire [2*N:0] 	ACC;

    Shift_and_Add #(.N(N)) DUT (
    	.clk(clk),.St(St), .Mplier(Mplier), .Mcand(Mcand),
    	.ACC(ACC), .K(K)
    );
    
    initial begin
	
		$dumpfile("CIDI-SD132-A208.vcd"); 
		$dumpvars(0, Shift_and_Add_tb); 	
		
		// Editar 
		$display("|St	|Mplier	|Mcand	|ACC		|K	|");
		$monitor("|%b 	|%b	|%b	|%b	|%b	|", St, Mplier, Mcand, ACC, K);
	
	end
    
    always #5 clk = ~clk;
    
    initial begin
        
        clk = 1'b0;
        
        Mplier = 4'b1101; 
        Mcand = 4'b1011;
        
        St = 1'b0; 
        #DELAY;
        
        St = 1'b1; #(DELAY*10);
        
        $finish;
    end

endmodule
