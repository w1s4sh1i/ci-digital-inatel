/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-105
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux16x1_tb;
	
	localparam DELAY = 10; 
    reg  [15:0] data_in_tb;
    reg  [3:0]  sel_tb;
    wire        out_tb;
    integer     i;

    mux16x1 UUT (
        .out(out_tb),
        .in	(data_in_tb),
        .sel(sel_tb)
    );

    initial begin
    
    	$dumpfile("CIDI-SD122-A105-1.vcd");
    	$dumpvars(0, mux16x1_tb);

	$display("|Data in		|Select |Out	|");
	$monitor("|%b	|%b	|%b	|", data_in_tb, sel_tb, out_tb);

        // Inicializar os sinais
        data_in_tb = 16'b0;
        sel_tb     = 4'b0;
        #DELAY;

        for (i = 0; i < 16; i = i + 1) begin
            sel_tb = i;
            data_in_tb = (1 << i);  // Deslocar o bit de referência
            #DELAY;
        end

        $finish;
    end
endmodule
