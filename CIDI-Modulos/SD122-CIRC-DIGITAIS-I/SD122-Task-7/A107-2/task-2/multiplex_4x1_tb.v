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

`timescale 1 ns / 1 ps;

module multiplex_4x1_tb;
    
    localparam DELAY = 10;
    reg A, B;
    wire f;

    f_function DUT (.A(A), .B(B), .f(f));

    initial begin
    
        $dumpfile("CID-SD122-A107-2-2.vcd");
        $dumpvars(0, multiplex_4x1_tb);

	$display("|A	|B	|f	|");
	$monitor("|%b	|%b	|%b	|", A, B, f);
		
        {A,B} = 2'b00;
        #DELAY
        
        {A,B} = 2'b01;
        #DELAY
        
        {A,B} = 2'b10;
        #DELAY
        
        {A,B} = 2'b11;
        #DELAY
        
        $finish;
    end
endmodule
