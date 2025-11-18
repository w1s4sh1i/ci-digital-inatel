/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-007
Type: Testbench
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

module debounce_tb;

	localparam DELAY = 50;
	reg button;
	reg clk;
	reg reset;

	wire result;

    // Instancia o módulo sob teste (UUT)
    debounce uut ( // unit under testing 
        .clk(clk),
        .rst(reset),
        .noisy_in(button),
        .clean_out(result)
    );

    // clock
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // Período do clock T = 20 ns
    end

    initial begin
    
	// Specify the VCD file name
	$dumpfile("CID-SD112-A007.vcd"); 
        $dumpvars(0, debounce_tb); 
	
	// Editar
	$display("|Clock	|Button	|Reset	|Result	|");
	$monitor("|%b	|%b	|%b	|%b	|", button, clk, reset, result);
        
        button = 0;
        reset = 1;
        #DELAY; 
        
        reset = 0;
        #6000;
        
        button = 0;
        #DELAY;  
        
        button = 1;  // Glitch / bounce
        #200; 
        
        button = 0;
        #DELAY;  
        
        button = 1;  // Glitch / bounce
        #150; 
        
        button = 0;
        #100;
        
        button = 1;  // Botão pressionado (estável)
        #8000;
        
        button = 0;
        #DELAY;  
        
        button = 1;  // Glitch / bounce
        #200;
         
        button = 0;
        #DELAY;  
        
        button = 1;  // Glitch / bounce
        #200; 
        
        button = 0;  // Botão solto (estável)
	#DELAY;

        $finish; 
    end

endmodule
