/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-305 (A-308)
Type: Testbench
Data: febuary, 6 2026
*/

module crossbar_switch_4x4_tb;
	// Parameters
	localparam DELAY = 5;
	//Ports
	reg		[1:0] select;
	reg		[7:0] in1, in2, in3, in4;
	wire	[7:0] out1, out2, out3, out4;

	crossbar_switch_4x4  crossbar_switch_4x4_inst (
		.select(select),
    	.in1(in1), .in2(in2), .in3(in3), .in4(in4),
        .out1(out1), .out2(out2), .out3(out3), .out4(out4)
    );

	// Alterar para $monitor
	task expect;
		input [31:0] expected_out;
		if ({out1,out2,out3,out4} !== expected_out) begin
		  $display("TEST FAILED! At time %0d out=%b, out should be %b",
				   $time, {out1,out2,out3,out4}, expected_out);
		  //$finish;
		end else begin
		  $display(" > At time %0d out = %b",
				   $time, {out1,out2,out3,out4});
		end
		
	endtask

	initial begin
    
		select = 0;
		in1 = $random;
		in2 = $random;
		in3 = $random;
		in4 = $random;
		#(DELAY/5);
		
		expect({in1,in2,in3,in4});
		#DELAY;
		
		select = 1;
		in1 = $random;
		in2 = $random;
		in3 = $random;
		in4 = $random;
		#(DELAY/5);
		
		expect({in2,in1,in4,in3});
		#DELAY;
		
		select = 2;
		in1 = $random;
		in2 = $random;
		in3 = $random;
		in4 = $random;
		#(DELAY/5);
		
		expect({in3,in4,in1,in2});
		#DELAY;
		
		select = 3;
		in1 = $random;
		in2 = $random;
		in3 = $random;
		in4 = $random;
		#(DELAY/5);
		
		expect({in4,in3,in2,in1});
		#DELAY;
		
		$finish;
	  
	end

endmodule
