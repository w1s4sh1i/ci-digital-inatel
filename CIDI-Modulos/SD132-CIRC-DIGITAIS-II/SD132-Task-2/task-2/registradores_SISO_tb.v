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
`timescale 1 ns / 1 ps

module tb_registradores_SISO;

    localparam DELAY = 10, N = 8;
    reg clk, reset, enable, dir, serial_in;
    wire serial_out;

    registradores_SISO #(.N(N)) uut (
        .clk(clk),
        .reset(reset),
        .enable(enable),
        .dir(dir),
        .serial_in(serial_in),
        .serial_out(serial_out)
    );

	initial begin
	
		$dumpfile("CIDI-SD132-A202-2.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", A, B, prod);
	
	end
	
    always #5 clk = ~clk;

    initial begin
    	
    	clk = 0;
        reset = 1;
        enable = 0;
        dir = 0;
        serial_in = 0;
        #DELAY; 
        
        reset = 0;
        // Teste shift direita
        enable = 1; 
        dir = 0;
        
        // Make task or function 
        repeat(N) begin
            serial_in = $random % 2;
            #DELAY;
        end

        // Reset
        reset = 1; 
        #DELAY; 
        
        reset = 0;
        // Teste shift esquerda
        enable = 1; 
        dir = 1;
        #DELAY;
        
        repeat(N) begin
            serial_in = $random % 2;
            #DELAY;
        end

        // Teste pausa de enable
        enable = 0; 
        #(DELAY*2);
        
        serial_in = 1; 
        #DELAY;

        $finish;
    end

endmodule
