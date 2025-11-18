/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-011
Type: Testbench
Data: octuber, 25 2025
*/

`timescale 1 ns / 1 ps;

module A11_1_tb;

	reg clk, rst;
	wire out;

	A11_1 U2 (.clk(clk),.rst(rst),
		     .out(out)
	);

	always #10 clk = ~clk;

	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A011.vcd"); 
        $dumpvars(0, A11_1_tb); 
		
		// Editar
		$display("|Clock |Reset |Out |");
		$monitor("|%b |%b | %b |", clk, rst, out);
		
		{clk,rst} = 2'b01; 
		#600; 
		
		rst = 1'b1;
		#200;
		
		#30
		$finish;
	end

endmodule
