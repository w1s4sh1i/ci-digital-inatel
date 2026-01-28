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

module registrador_16bits_tb;

	localparam DELAY = 10; 
    reg clk;
    reg rst;
    reg [15:0] d;
    wire [15:0] q;
    
    // Instancia o DUT
    registrador_16bits UUT (
        .clk(clk),
        .rst(rst),
        .d(d),
        .q(q)
    );
    
    initial begin
	
		$dumpfile("CIDI-SD132-A201-2.vcd"); 
		$dumpvars(0, registrador_16bits_tb); 	
		
		// Editar
		$display("|clk	|reset	|D	|Q	|");
		$monitor("|%b 	|%b	|%b	|%b	|", clk, rst, d, q);
	
	end
    
    // Geração de clock 
    always #(DELAY/2) clk = ~clk;

    initial begin
    	
    	clk = 0;
        rst = 1; // reset ativo síncrono, tudo 0
        d = 16'h0000; 
        #DELAY;    
        
        rst = 0; // reset desativado 
        #DELAY; 
        
        d = 16'hAAAA; 
        #DELAY;             
        d = 16'h5555; 
        #DELAY;             
        d = 16'hFFFF; 
        #DELAY;
        
        rst = 1; 
        #DELAY; // ativa reset novamente
        d = 16'h0000; 
        
        #DELAY;
        $finish;
    end

endmodule
