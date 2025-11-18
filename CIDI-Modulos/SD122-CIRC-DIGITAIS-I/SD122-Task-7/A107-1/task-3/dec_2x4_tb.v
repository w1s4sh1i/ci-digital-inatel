/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-107-1
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module dec_2x4_tb;

	localparam DELAY = 10; 
    reg A, B, C;
    wire f;

    f_function DUT(
    	.A(A),
    	.B(B),
    	.C(C),
    	.f(f)
    );

    initial begin
        
        $dumpfile("CID-SD122-A107-1-3.vcd");
        $dumpvars(0, dec_2x4_tb);
		
		$display("|A	|B	|C	|f	|");
		$monitor("|%b	|%b	|%b	|%b	|", A, B, C, f);
		
        {A,B,C} = 3'b000; 
        #DELAY;
        
        {A,B,C} = 3'b001; 
        #DELAY;
        
        {A,B,C} = 3'b010; 
        #DELAY;
        
        {A,B,C} = 3'b011; 
        #DELAY;
        
        {A,B,C} = 3'b100; 
        #DELAY;
        
        {A,B,C} = 3'b101; 
        #DELAY;
        
        {A,B,C} = 3'b110; 
        #DELAY;
        
        {A,B,C} = 3'b111; 
        #DELAY;

        $finish;
    end
endmodule
