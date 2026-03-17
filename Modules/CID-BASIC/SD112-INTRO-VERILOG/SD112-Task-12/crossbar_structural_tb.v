/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-012
Type: Testbench
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module crossbar_structural_tb;
	
	localparam DELAY = 15; 
	reg in2, in1, select;
	wire out2, out1;

	crossbar_structural UUT (
		.in1(in1), .in2(in2), .select(select),
		.out1(out1),.out2(out2)
	);

	initial begin

		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A012-1-crb.vcd"); 
        $dumpvars(0, crossbar_structural_tb); 

		$display("|Input 2 1	|Select |Output 2 1	|"); 
		$monitor("|	%b %b	|%b	|	%b %b	|", in2, in1, select, out2, out1); 

		{select, in2, in1} = 3'b001;
		#DELAY;

		{select, in2, in1} = 3'b010;
		#DELAY;
		
		{select, in2, in1} = 3'b101;
		#DELAY;

		{select, in2, in1} = 3'b110;
		#DELAY;
		
		$finish;
	end
                
endmodule






