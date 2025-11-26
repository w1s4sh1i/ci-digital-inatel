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

module conversor_binario_grey_tb();

	localparam DELAY = 10, WIDTH = 4;
    reg  [WIDTH-1 : 0] binario;
    wire [WIDTH-1 : 0] gray;

    conversor_binario_grey UUT (
        .binario(binario),
        .gray(gray)
    );

    initial begin
    	
    	$dumpfile("CIDI-SD122-A102-2-1-cbg.vcd");
		$dumpvars(0, conversor_binario_grey_tb);

		$display("|Binary	|Gray code	|");
		$monitor("|%b	|%b		|", binario, gray);
		
		// for () ... binario = binario + 1'b1; 
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
