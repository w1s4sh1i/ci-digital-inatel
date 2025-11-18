/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-010
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux2x1_rtl2_tb;

	localparam DELAY = 15; 
	reg in1, in2, select;
	wire out;

	mux2x1_rtl2 UUT (
		.in1(in1), .in2(in2), .select(select),
		.out(out)
	);

	initial begin
	
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A010-3.vcd"); 
        $dumpvars(0, mux2x1_rtl2_tb); 
        
		// Editar
		$display("|input 1|input 2|select |out |");
		$monitor("|%b |%b |%b | %b |", in1, in2, select, out);
		
		// select = 0
		{select, in2, in1} = 3'b001;
		#DELAY;
		
		{select, in2, in1} = 3'b010;
		#DELAY;
		
		{select, in2, in1} = 3'b011;
		#DELAY;
		
		// select = 1
		{select, in2, in1} = 3'b101;
		#DELAY;
		
		{select, in2, in1} = 3'b110;
		#DELAY;
		
		{select, in2, in1} = 3'b111;
		#DELAY;
		
		$finish;
	end
                          
endmodule






