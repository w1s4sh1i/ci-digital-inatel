//

module ram_simple_dual_port_single_clock_tb;

  // Parameters
  localparam	DATA_WIDTH = 8;
  				ADDR_WIDTH = 6;
  				DELAY 	   = 10;

  reg  [DATA_WIDTH-1:0] data;
  reg  [ADDR_WIDTH-1:0] read_addr, write_addr,
  reg 					we, clk;
  wire [ADDR_WIDTH-1:0] q;

	ram_single_port 
		#(
			.DATA_WIDTH(DATA_WIDTH),
			.ADDR_WIDTH(ADDR_WIDTH)
		) UUT(
			.data(data),
			.read_addr(read_addr), 
			.write_addr(write_addr),
			.we(we),
			.clk(clk),
			.q(q)
  	);

	initial begin
	
		// dump

		$monitor("At time: %0t - %s adress: %b - data: %b",
				$time, addr,
					if (action) "written to", data
			  		else 		"reding the", q
		);
	
	end 

	always #(DELAY/2)  clk = ! clk;
	integer i; 

	initial begin
		we <= 1'b1; 
		clk <= 1'b0; 

		// TODO: Modificar para adicionar sinais
		// Writing data 

		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 ) begin
			@(posedge clk);
			addr = i;
			
			data = $random;
			
			// display 
			#DELAY; 
		end

		#DELAY; 
		we <= 1'b0;  

		// Reading data
		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 ) begin
			@(posedge clk);
			addr = i;
			
			// display
			#DELAY;
		end

		$finish; 
	end   

endmodule
