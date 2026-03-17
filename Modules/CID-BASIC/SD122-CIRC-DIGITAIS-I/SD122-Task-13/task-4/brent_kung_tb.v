/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Testbench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

// Brent Kung
module brent_kung_tb; 
    reg [15:0] a,b,
    reg carry_in,
    wire carry_out,
    wire [15:0] sum

);

	brent_kung DUT (
	
	);

	initial begin
		
		$dumpfile("CIDI-SD122-A113-4-1.vcd"); 
        $dumpvars(0, slanky_tb); 
		
		// Editar 
		$display("|A	 |B	  |C	   |Cout|Sum		|");
		$monitor("|%b|%b|%b|%b   |%b	|",
			A, B, C, Cout, Sum
		);
	end
	
	initial begin
		
		$finish;
	end
  
endmodule
