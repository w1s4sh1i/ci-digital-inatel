/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-1
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module bin_to_grey_tb ();
    
	localparam DELAY = 10, SAMPLES = 16;
	reg b0, b1, b2, b3;  // [3:0] b
	wire g0, g1, g2, g3; // [3:0] g
	integer i;

	bin_to_grey UUT (
        	.b0(b0), .b1(b1), .b2(b2), .b3(b3),
        	.g0(g0), .g1(g1), .g2(g2), .g3(g3)
	);

	initial begin
        
        	$dumpfile("CIDI-SD122-A102-1-3.vcd");
		$dumpvars(0, bin_to_grey_tb);

		$display("|b3 b2 b1 b0	|g3 g2 g1 g0	|");
		$monitor("|%b %b %b %b	|%b %b %b %b	|", b3, b2, b1, b0, g3, g2, g1, g0);

		for (i = 0; i < SAMPLES; i = i + 1) begin
		    {b3, b2, b1, b0} = i;  // atribuindo valor binário
		    #DELAY;                     // espera 10 ns
		end

		$finish;
	end

endmodule
