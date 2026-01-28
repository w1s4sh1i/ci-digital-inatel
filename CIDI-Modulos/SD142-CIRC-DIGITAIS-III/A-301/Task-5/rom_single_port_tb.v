
module single_port_rom_tb;

  // Parameters
  localparam	DATA_WIDTH	= 8,
  				ADDR_WIDTH	= 6,
  				DELAY		= 10;
  				SAMPLES		= 2**ADDR_WIDTH;

  //Ports
  reg	[ADDR_WIDTH-1 : 0]	addr;
  reg						clk;
  wire	[DATA_WIDTH-1 : 0]	q;

	single_port_rom 
	#(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
	)
	UUT (
		.addr(addr),
		.clk(clk),
		.q(q)
	);

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
