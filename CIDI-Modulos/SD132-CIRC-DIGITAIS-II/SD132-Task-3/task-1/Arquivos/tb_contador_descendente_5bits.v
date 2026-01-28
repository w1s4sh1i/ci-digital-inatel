/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-203
Type: Testbench
Data: november, 24 2025
*/

`timescale 1 ns / 1 ps

module tb_contador_descendente_5bits;
	
	localparam DELAY = 10;
    reg clk, reset;
    wire [4:0] Q;

    // Instancia o contador
    contador_descendente_5bits uut (
        .clk(clk),
        .reset(reset),
        .Q(Q)
    );
	
	initial begin
	
		$dumpfile("CIDI-SD132-A203-1.vcd"); 
		$dumpvars(0, <>_tb); 	
		
		// Editar 
		$display("|A	|B	|PROD		|");
		$monitor("|%b 	|%b	|%b	|", A, B, prod);
	
	end
	
	// Geração de clock (período de 10 unidades)
    always #5 clk = ~clk;

    initial begin
        // Inicialização
        clk = 0; 
        reset = 1;
        #DELAY 
        
        reset = 0;  // libera o reset após 10 unidades de tempo

        #(DELAY*20) // Simulação por 200 unidades de tempo
        $finish;
    end
    
endmodule
