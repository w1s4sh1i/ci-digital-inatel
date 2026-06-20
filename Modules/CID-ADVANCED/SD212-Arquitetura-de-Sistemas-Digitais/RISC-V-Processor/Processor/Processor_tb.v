`include "PROCESSOR.v"

module stimulus ();

	reg clock, reset;
	wire zero;

	// Instantiating the processor!
	PROCESSOR test_processor(clock,reset,zero);
	
	always #20 clock = ~clock;
	
	initial begin
		$dumpfile("processor_wave.vcd");
		$dumpvars(0, stimulus);
	end
	
	initial #300 $finish;
	
	initial begin
		
		clock = 1'b0;
		reset = 1'b1;
		
		#50 
		reset = 1'b0;
	end
	
endmodule
