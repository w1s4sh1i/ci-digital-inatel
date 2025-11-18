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

module tb_crossbar_structural;

	reg in1, in2, select;
	wire out1, out2;

	crossbar_structural U1 (
		.in1(in1), .in2(in2), .select(select),
		.out1(out1),.out2(out2)
	);

	initial begin
		
		select = 0;
		in1 = 1; in2 = 0;
		#15;
		in1 = 0; in2 = 1;
		#15;
		
		select = 1; 
		in1 = 1; in2 = 0;
		#15;
		in1 = 0; in2 = 1;
		#15;
		
		$finish;
	end
                
endmodule






