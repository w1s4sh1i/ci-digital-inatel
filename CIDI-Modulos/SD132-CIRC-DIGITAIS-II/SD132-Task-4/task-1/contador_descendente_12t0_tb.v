/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-204
Type: Testbench
Data: november, 25 2025
*/

`timescale 1 ns / 1 ps

module contador_descendente_12t0_tb;

	localparam DELAY = 10;
    reg clk, rst;
    wire [3:0] Q;

    contador_descendente_12t0 DUT (
        .clk(clk), .rst(rst),
        .Q(Q)
    );

	initial begin
	
		$dumpfile("CIDI-SD132-A204-1.vcd"); 
		$dumpvars(0, contador_descendente_12t0_tb); 	
		
		// Editar 
		$display("|Clk	|Reset	|Q bin	|Q dec	|");
		$monitor("|%b	|%b	|%04b	|%0d	|", clk, rst, Q, Q);
	
	end
	
    always #5 clk = ~clk;

    initial begin
        
        {clk, rst} = 2'b01;
        #DELAY; 
        
        rst = 1'b0;
        #(DELAY*15);

        $finish;
    end

endmodule
