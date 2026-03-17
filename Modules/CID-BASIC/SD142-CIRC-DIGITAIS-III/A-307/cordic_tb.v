/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-310)
Type: Testbench
Data: febuary, 9 2026
*/

`include "testbench_lib.v"

module cordic_tb;

	localparam WIDTH = 16;
	localparam real FREQUENCY = 100e6;      // Clock frequency in Hz

	reg         clk, rst;
	reg  [WIDTH-1 : 0] X, Y,Z;
	wire [WIDTH-1 : 0] abs, tan; 

	cordic_serial_abs #(WIDTH) cordic(
		.clk(clk), .rst(rst), .data_X(X), .data_Y(Y), .data_Z(Z), 
		.abs(abs), .tan(tan)
	);

	always #5  clk = ! clk;

	// [x] Alterar para $monitor;
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD142-A303-cordic.vcd"); 
		$dumpvars(0, cordic_tb); 

		// Editar
		$display("|at time |X |Y |is abs |");
		$monitor("|%0t |%b |%b |%b |", 
				$time, X, Y, abs
		); 
	end

	// Alterar para $monitor
	always @(posedge clk) begin
	  if (cordic.iter_val == 6) begin // Check the condition
		 $display("Abs value for X:%d , Y:%d is abs:%d at time %0t", X, Y, abs, $time); 
	  end
	end

	/* Initialization of simulation values and reset */
	initial begin
	  
	  clk <= 1'b0;
	  rst <= 1'b1;       // initiate with reset asserted
	  
	  #20 
	  rst <= 1'b0;    // release reset
	  X <= 16'd31;
	  Y <= 16'd63;
	  Z <= 16'd0; 
	  
	  #200 X <= 16'd100; Y <= 16'd100;
	  #200 X <= 16'd287; Y <= 16'd31;
	  #200 X <= 16'd152; Y <= 16'd358;
	  #200 X <= 16'd181; Y <= 16'd500;
	  
	  #200;
	  $finish; 
	end

	// 100 + 100j, 287 − 31j, −152 − 358j e −181 + 500j.
	/* Clock generators for the testbench - defines frequency and initial polarity */
	//clock_generator #(FREQUENCY, 1) CLOCK100M(.clk(clk));

endmodule
