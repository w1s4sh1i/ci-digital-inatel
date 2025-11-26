/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-2
Type: Testbench
Data: november, 5 2025
*/

`timescale 1ns/1ps

module excesso_3_tb();

	localparam DELAY = 10, WIDTH = 4;
    	reg  [WIDTH-1 : 0] binario;
    	wire [WIDTH-1 : 0] out;

    excesso_3 UUT (
        .bcd_8421(binario),
        .excesso_3(out)
    );

    initial begin
    
    	$dumpfile("CIDI-SD122-A102-2-2-ex3.vcd");
	$dumpvars(0, excesso_3_tb);

	$display("|Input	|Excess 3	|");
	$monitor("|%b	|%b		|", binario, out);
		
        binario = 4'b0000; #DELAY;
        binario = 4'b0001; #DELAY;
        binario = 4'b0010; #DELAY;
        binario = 4'b0011; #DELAY;
        binario = 4'b0100; #DELAY;
        binario = 4'b0101; #DELAY;
        binario = 4'b0110; #DELAY;
        binario = 4'b0111; #DELAY;
        binario = 4'b1000; #DELAY;
        binario = 4'b1001; #DELAY;
        binario = 4'b1010; #DELAY;
        binario = 4'b1011; #DELAY;
        binario = 4'b1100; #DELAY;

        $finish;

    end

endmodule
