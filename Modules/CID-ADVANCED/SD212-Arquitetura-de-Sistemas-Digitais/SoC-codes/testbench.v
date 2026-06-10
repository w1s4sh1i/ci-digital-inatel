`timescale 1 ns / 1 ps

module testbench;
    
	reg	clk 	= 1'b1;
	reg	resetn 	= 1'b0;
	wire	led 	= 1'b0;

	always #5 clk = ~clk;

	// dump and monitor;  
	initial begin
		$dumpfile("fpga_rv32_tb.vcd");
		$dumpvars(0, testbench);
		// $monitor();
	end

	fpga_rv32 # (
		.INIT_RAM_FILE("firmware.hex")
	) soc_inst (
		.clk(clk),
		.resetn(resetn),
		.led(led)
	);
	
	initial begin
		#20 
		resetn = 1'b1;

		#350;
		$display("Timeout atingido: Teste finalizado!");
		$finish;
	end

endmodule
