/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-003
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module gate_not_tb;
	
	reg data_in;
	wire data_outl, data_outi;
	integer i; 
	
	localparam DELAY = 1, TEST_NUMBER = 5; 
	
	gate_not n1 (
		.signal(data_in),
		.not_logic(data_outl), .not_instance(data_outi)
	); 
	
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD112-A003.vcd"); 
        $dumpvars(0, gate_not_tb); 
		
		$display("|Sample	|Time	|signal	|not-signal	|~	|not	|");
		$monitor("|%d	|%0t	|%b	|->	|%b	|%b	|"
			, i, $time, data_in, data_outl, data_outi
		);

		data_in = 1'b0; 
		// #DELAY;		
		// sv -> for(integer i = 0; i < TEST_NUMBER; ++i)
		for(i = 1; i < TEST_NUMBER; i = i + 1) begin
        	data_in = ~data_in;
			#DELAY;
		end
	end

endmodule
