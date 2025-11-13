/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-107-2
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps

module multiplex_4x1_tb;
    
    localparam DELAY = 10;
    reg S1, S0;
    reg E0, E1, E2, E3;
    wire Y;

    // Instancia o MUX
    multiplex_4x1 DUT (
        .S1(S1), .S0(S0),
        .E0(E0), .E1(E1), .E2(E2), .E3(E3),
        .Y(Y)
    );

    initial begin
    
        $dumpfile("CID-SD122-A107-2-1.vcd");
        $dumpvars(0, multiplex_4x1_tb);
	
	$display("|S1	|S0	|E3	|E2	|E1	|E0	|Y	|"); 
	$monitor("|%b	|%b	|%b	|%b	|%b	|%b	|%b	|", S1, S0, E0, E1, E2, E3, Y);

        // Entradas: quaisquer sinais
        {E0, E1, E2, E3} = 4'b0101;

        // Sequência da seleção conforme a figura
        {S1,S0} = 2'b00; 
        #DELAY; // seleciona E0
        
        {S1,S0} = 2'b01; 
        #DELAY; // seleciona E1
        
        {S1,S0} = 2'b10; 
        #DELAY; // seleciona E2
        
        {S1,S0} = 2'b11; 
        #DELAY; // seleciona E3

        $finish;
    end
endmodule
