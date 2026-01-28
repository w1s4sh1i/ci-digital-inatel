// Simple Dual Port RAM with separate read/write
// addresses and single read/write clock

module ram_simple_dual_port_single_clock
#(
	parameter	DATA_WIDTH = 8, 
			 	ADDR_WIDTH = 6
)(
	input [DATA_WIDTH-1 : 0] data,
	input [ADDR_WIDTH-1 : 0] read_addr, write_addr,
	input we, clk,
	output reg [(DATA_WIDTH-1):0] q
);
	// Declare the RAM variable
	reg [DATA_WIDTH-1 : 0] ram[2**ADDR_WIDTH-1 : 0];
	always @ (posedge clk) begin
		// Write
		if (we) ram[write_addr] <= data;
		// else 
		q <= ram[read_addr];
	end
endmodule
