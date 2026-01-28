/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-201
Type: Testbench
Data: november, 22 2025
*/

`timescale 1 ns / 1 ps;

module registrador_8bits_tb;
	
	localparam DELAY = 10;
    reg			clk, rst_n;
    reg  [7:0]	d;
    wire [7:0]	q;
    
    // Instancia o DUT
    registrador_8bits DUT (
        .clk(clk), .rst_n(rst_n), .d(d),
        .q(q)
    );
    
    initial begin
	
		$dumpfile("CIDI-SD132-A201-1.vcd"); 
		$dumpvars(0, registrador_8bits_tb); 	
		
		$display("|clk	|rst	|d	|q	|");
		$monitor("|%b	|%b	|%b|%b|", clk, rst_n, d, q);
	
	end
    
    // Geração de clock
    always #5 clk = ~clk;

    initial begin
    	
    	clk = 0;
        
        rst_n = 0; 
        d = 8'h00; 
        #DELAY;    // reset ativo
        
        rst_n = 1; 
        #DELAY;     // reset desativado
        
        d = 8'hAA; 
        #DELAY;
        
        d = 8'h55; 
        #DELAY;  
        
        d = 8'hFF; 
        #DELAY;
		
		rst_n = 0;
		#DELAY; // com reset, de novo zera a saída
        
        d = 8'h00; 
        #DELAY;
    
        $finish;
    end

endmodule
