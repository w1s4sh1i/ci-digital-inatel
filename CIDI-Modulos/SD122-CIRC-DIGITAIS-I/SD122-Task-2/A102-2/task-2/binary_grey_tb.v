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

module conversor_binary_grey_tb();

	localparam DELAY = 10;
    reg [3:0] binario;
    wire [3:0] gray;

    conversor_binario_grey GREY_TB(
        .binario(binario),
        .gray(gray)
    );

    initial begin
    	
    	$dumpfile("CIDI-SD122-A102-3-1.vcd");
	$dumpvars(0, conversor_binary_grey_tb);

	$display(">|Binary	|Gray code	|");
	$monitor(" |%b		|%b		|", binario, gray);
		
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
        binario = 4'b1101; #DELAY;
        binario = 4'b1110; #DELAY;
        binario = 4'b1111; #DELAY;
        
        $finish;
    end
    

endmodule
