/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module demux1x8_tb;

	localparam DELAY = 10;
	reg din;
	reg [2:0] sel;
	wire [7:0] y;

	demux1x8 UUT (
	    .d(din), .sel(sel), 
	    .y(y)
	);

	initial begin
    
		$dumpfile("CIDI-SD122-A106-2.vcd");
        	$dumpvars(0, demux1x8_tb);

		$display("|Din	|Sel	|Y	 |");
		$monitor("|%b	|%b	|%b|", din, sel, y);

		din = 1'b1;
		
		sel = 3'b000; #DELAY; 
		sel = 3'b001; #DELAY; 
		sel = 3'b010; #DELAY; 
		sel = 3'b011; #DELAY; 
		sel = 3'b100; #DELAY; 
		sel = 3'b101; #DELAY; 
		sel = 3'b110; #DELAY; 
		sel = 3'b111; #DELAY; 

		$finish;
    end
endmodule
