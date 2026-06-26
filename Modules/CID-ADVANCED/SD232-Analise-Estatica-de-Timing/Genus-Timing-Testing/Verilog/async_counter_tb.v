`include "async_counter.v"

module async_counter_tb;

	localparam WIDTH = 4; 
	reg clk;
	reg rst_n;
	wire [WIDTH-1 : 0] count;

	// Instantiate the counter
	async_counter uut (
		.clk(clk),
		.rst_n(rst_n),
		.count(count)
	);

	always #5 clk = ~clk;

	// Monitor output
	// dump and monitor;  
	initial begin
		$dumpfile("async_counter_tb.vcd");
		$dumpvars(0, async_counter_tb);
		$display("|Time	|reset	|q 	|   |");
		$monitor("|%0t	|%b 	|%b	|%d |", $time, rst_n, count, count);
	end

	initial begin

		clk = 1'b0;
		rst_n = 1'b0;

		// Apply reset
		#15;
		rst_n = 1'b1;

		// Let the counter run for a few cycles
		#200;

		$finish;
	end

endmodule

