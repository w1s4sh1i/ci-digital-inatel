/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Laboratory
Data: november, 18 2025
*/

`timescale 1 ns / 1 ps;

module top_module_tb;

	localparam DELAY = 10; 
    reg A, B;
    wire D3, D2, D1, D0;
    wire B3, B2, B1, B0;
	
	top_module UUT (
	    .A(A), .B(B),
	    .D_out1(D0), .D_out2(D1), .D_out3(D2), .D_out4(D3),
	    .B_out1(B0), .B_out2(B1), .B_out3(B2), .B_out4(B3)
	);
	
	 initial begin
		
		$dumpfile("CIDI-SD122-A111-1.vcd"); 
        $dumpvars(0, top_module_tb); 
		
		$display("|A|B|Dout   |Bout   |");
		$monitor("|%b|%b|%b %b %b %b|%b %b %b %b|", 
				A, B, D3, D2, D1, D0, B3, B2, B1, B0);
	end
	
	initial begin
		{A, B} <= 2'b00; #DELAY; 
		{A, B} <= 2'b01; #DELAY;   
		{A, B} <= 2'b10; #DELAY;   
		{A, B} <= 2'b11; #DELAY;    
  	end

endmodule
