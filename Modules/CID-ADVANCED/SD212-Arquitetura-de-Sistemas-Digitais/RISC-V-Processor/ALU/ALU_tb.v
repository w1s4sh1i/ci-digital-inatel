`include "ALU.v"

`timescale 1 ns / 1 ps 

module stimulus ();
    
    reg [31: 0] A, B;
    reg [ 3: 0] ALUControl;
    
    wire 	ZERO;
    wire [31:0] ALUResult;

    // Instantiating modules
	ALU ALU_module(
	    	.in1(A),
	    	.in2(B),
	    	.alu_control(ALUControl),
	    	.zero_flag(ZERO),
	    	.alu_result(ALUResult)
	);

	// Setting up waveform
	initial begin
		// Format: scale to ns (-9, 2 decimal digits, min width of 10 chars;
		$timeformat( -9, 2, "", 10);
		
		$dumpfile("ALU_wave.vcd");
		$dumpvars(0, stimulus);
	 	
	 	// Display and Monitoring changing values; 
	 	$display("|time (ns)|Input_1	|Input_2	|ALU_control	|ALU_result				|Zero_flag|");
	 	$monitor("|%0t	  |%0d		|%0d		|%b		|%b	|%0d	  |",
	 			$realtime, A, B, ALUControl, ALUResult, ZERO);

	end
	// Finish after 150 clock cycles
	initial #150 $finish;
    
	// Test conditions
	initial begin
		
		A = 23; B = 42;  ALUControl = 4'b0000;
		#20; 
		A = 23; B = 42;  ALUControl = 4'b0001;
		#20;
		A = 23; B = 42;  ALUControl = 4'b0010;
		#20;
		A = 23; B = 42;  ALUControl = 4'b0100;
		#20;
		A = 23; B = 42;  ALUControl = 4'b1000;
		#20;
		A = 42; B = 23;  ALUControl = 4'b1000;
		#20;
		A = 42; B = 23;  ALUControl = 4'b0100;
	end

endmodule
