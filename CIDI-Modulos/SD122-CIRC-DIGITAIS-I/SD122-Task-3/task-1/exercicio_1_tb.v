/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-103
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module codificador_prio_tb();

	locaparam DELAY = 10; 
    reg [15:0] in;
    wire [3:0] out;

    Codificador_Prioridade PRIORITY_TB(
        .in(in),
        .out(out)
    );

    initial begin
    
    	$dumpfile("CID-SD122-A103-1.vcd");
		$dumpvars(0, codificador_prio_tb);

		$display("|In	|Out	|");
		$monitor("|%b	|%b	|", in, out);

        in = 16'b100000000000000; #DELAY;
        in = 16'b010000000000000; #DELAY;
        in = 16'b001000000000000; #DELAY;
        in = 16'b000100000000000; #DELAY;
        in = 16'b000010000000000; #DELAY;
        in = 16'b000001000000000; #DELAY;
        in = 16'b000000100000000; #DELAY;
        in = 16'b000000010000000; #DELAY;
        in = 16'b000000001000000; #DELAY;
        in = 16'b000000000100000; #DELAY;
        in = 16'b000000000010000; #DELAY;
        in = 16'b000000000001000; #DELAY;
        in = 16'b000000000000100; #DELAY;
        in = 16'b000000000000010; #DELAY;
        in = 16'b000000000000001; #DELAY;
        in = 16'b000000000000000; #DELAY;
        $finish;
    end
    

endmodule
