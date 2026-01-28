/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-202
Type: Testbench
Data: november, 23 2025
*/
`timescale 1ns/1ps

module registradores_PISO_tb;

    localparam			DELAY = 10, BITS_NUM = 8;
    reg 				reset, clk, load, dir;
    reg [BITS_NUM-1:0]	data_in;
    wire 				data_out;

    registradores_PISO #(.num_bits(BITS_NUM)) DUT (
        .reset(reset),
        .clk(clk),
        .load(load),
        .dir(dir),
        .data_in(data_in),
        .data_out(data_out)
    );
	
	initial begin
	
		$dumpfile("CIDI-SD132-A202-1.vcd"); 
		$dumpvars(0, registradores_PISO_tb); 	
		
		// Editar 
		$display("|Data in|Data out|");
		$monitor("|%b 	|%b	|", data_in, data_out);
	
	end
    
    // Estímulo de clock
    always #5 clk = ~clk; 

    initial begin
    	clk = 0;
        reset = 1; 
        load = 0; 
        dir = 0; 
        data_in = 8'b10101100;
        #DELAY; 
        
        reset = 0;
		#DELAY;
        
        load = 1;
        #DELAY;
        
        load = 0;
        dir = 0;
        #(DELAY*BITS_NUM);

        load = 1; data_in = 8'b11001101; #DELAY; load = 0;

        dir = 1;
        #(DELAY*BITS_NUM);

        // Teste de reset
        reset = 1; 
        #DELAY; 
        reset = 0;
        #DELAY; 
        $finish;
    end

endmodule
