
module rom_dual_port_tb;

  // Parameters
  localparam	DATA_WIDTH	= 8,
  				ADDR_WIDTH	= 6,
  				DELAY		= 10;
  				SAMPLES		= 2**ADDR_WIDTH;

  //Ports
  reg	[ADDR_WIDTH-1 : 0]	addr_a, addr_b;
  reg						clk;
  wire	[DATA_WIDTH-1 : 0]	q_a, q_b;

	single_port_rom 
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
	)
	UUT (
		.addr_a(addr_a), .addr_b(addr_b),
		.clk(clk),
		.q_a(q_a), .q_b(q_b),
	);

	// dump, display and monitor 
	
	always #(DELAY/2)  clk = ! clk;

	integer seed,i; 

	always @(posedge clk) seed = $time;

	initial begin
		
		clk = 1'b0;
		#(DELAY*5);
		
		for (i = 0; i < (SAMPLES); i = i + 1) begin
			addr <= $random(seed);
			@(posedge clk);

			// display

			#DELAY;
		end

		$finish;
	end

endmodule
