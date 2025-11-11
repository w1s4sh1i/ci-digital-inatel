/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-115
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module <>_tb;
	reg data_in;
	wire data_outl, data_outi;
	integer i = 1; 
	
	localparam DELAY = 1, TEST_NUMBER = 5; 
	
	<> n1 (
		.signal(data_in),
		.not_logic(data_outl), .not_instance(data_outi)
	); 
	
	initial begin
		
		// Specify the VCD file name
		$dumpfile("cid-SD122-A115.vcd"); 
        $dumpvars(0, <>_tb); 
		
		// Editar
		$display("| Time | signal | not-signal |  ~ | not |";
		$monitor("| %d | %0t | %b | %b | %b |");
			, i, $time, data_in, data_outl, data_outi
		);

		data_in = 1'b0; 
		
		// sv -> for(integer i = 0; i < TEST_NUMBER; ++i)
		for(; i < TEST_NUMBER; i = i + 1) begin
			#DELAY;                                                      
			data_in = ~data_in;
		end
	end

endmodule
