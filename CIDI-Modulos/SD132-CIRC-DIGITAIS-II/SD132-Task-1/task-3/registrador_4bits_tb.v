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

module registrador_4bits_tb;
	
	localparam	DELAY = 10;
    reg 		clk;
    reg 		clear_n;
    reg 		preset_n;
    reg  [3:0] 	d;
    wire [3:0]	q;
    
    registrador_4bits UUT (
        .clk(clk),
        .clear_n(clear_n),
        .preset_n(preset_n),
        .d(d),
        .q(q)
    );
    
     initial begin
	
		$dumpfile("CIDI-SD132-A201-3.vcd"); 
		$dumpvars(0, registrador_4bits_tb); 	
		
		// Editar 
		$display("|clk|clear|preset|D|Q	|");
		$monitor("|%b|%b|%b|%b|%b|", clk, clear_n, preset_n, d, q);
	
	end
    // Gerador de clock (período 10 unidades)
    always #(DELAY/2) clk = ~clk;
    
    initial begin
    	clk = 0;
        clear_n = 1; 
        preset_n = 1; 
        d = 4'b0000;
        #DELAY;
        
        clear_n = 0; 
        preset_n = 1; 
        #DELAY;
        
        clear_n = 1; 
        #DELAY;// Ativa clear (reset) assíncrono
        d = 4'b1100; 
        #DELAY;
        
        preset_n = 0; 
        #DELAY;
        
        preset_n = 1; 
        d = 4'b0011; 
        #DELAY;// Ativa preset assíncrono
        $finish; 
    end

endmodule

