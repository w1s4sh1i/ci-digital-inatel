/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-105
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux_4x1_param_tb;

	localparam DELAY = 10, N = 4;
	reg  [N-1 : 0] 	in0, in1, in2, in3;
	reg  [1:0]  	sel;
	wire [N-1 : 0] 	out;

	mux_4x1_param #(.N(N)) UUD (
		.in0(in0),.in1(in1),.in2(in2),.in3(in3),
		.sel(sel),.out(out)
	);

	initial begin
     	
     		$dumpfile("CIDI-SD122-A105-3.vcd");
        	$dumpvars(0, mux_4x1_param_tb);

		$display("|Input 0|Input 1|Input 2|Input 3|Sel|Out	|");
		$monitor("|%b	|%b	|%b	|%b	|%b |%b	|", in0, in1, in2, in3, sel, out);

		in0 = 4'b0101; // 5
		in1 = 4'b0011; // 3
		in2 = 4'b0100; // 4
		in3 = 4'b1000; // 8

		sel = 2'b00; #DELAY;
		sel = 2'b01; #DELAY;
		sel = 2'b10; #DELAY;
		sel = 2'b11; #DELAY;

	end

endmodule
