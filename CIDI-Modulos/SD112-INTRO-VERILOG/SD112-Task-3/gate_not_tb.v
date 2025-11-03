/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A003
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module gate_not_tb;
	reg data_in;
	wire data_outl, data_outi;
	integer i = 1; 
	
	localparam DELAY = 1, TEST_NUMBER = 5; 
	
	gate_not n1 (
		.signal(data_in),
		.not_logic(data_outl), .not_instance(data_outi)
	); 
	
	initial begin
		
		$dumpfile("cid-A122-A003.vcd"); // Specify the VCD file name
        $dumpvars(0, gate_not_tb); 
		
		$monitor(
			"%d - Time = %0t | signal = %b -> not-signal: ~ = %b, not = %b"
			, i, $time, data_in, data_outl, data_outi
		);

		data_in = 1'b0; 
		
		for(; i < TEST_NUMBER; i++) begin
			#DELAY;                                                      
			data_in = ~data_in;
		end
	end

endmodule
