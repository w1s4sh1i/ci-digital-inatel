/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Testbench
Data: octuber, 27 2025
*/

`timescale 1 ns / 1 ps;

// AND primitive build testing

module and_p_tb;
	
	localparam DELAY = 20; 
	reg a,b;
    	wire y, t;

	and_p UUT0 (
		.a(a), .b(b),
		.y(y)
	);
	
	and_ptable UUT1 (
		.a(a), .b(b),
		.y(t)
	);

    initial begin
    	
    	// Specify the VCD file name
	$dumpfile("CIDI-SD112-A013-1-and.vcd"); 
        $dumpvars(0, and_p_tb); 
		
		$display("|A |B |Y |Table	|");
		$monitor("|%b |%b |%b |%b	|", a, b, y, t);
		
        {a, b} = 2'b00;
        #DELAY;
        
        {a, b} = 2'b01;
        #DELAY;
        
        {a, b} = 2'b10;
        #DELAY;
        
        {a, b} = 2'b11;
        #DELAY;          
        
    end
               
endmodule






