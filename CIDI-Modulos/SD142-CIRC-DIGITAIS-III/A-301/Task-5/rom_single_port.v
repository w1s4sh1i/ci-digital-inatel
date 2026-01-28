module single_port_rom 
#(
	parameter	DATA_WIDTH = 8,
				ADDR_WIDTH = 8
)(
	input 		[ADDR_WIDTH-1 : 0]	addr,
	input 							clk,
	output reg	[DATA_WIDTH-1 : 0]	q
);
	localparam SAMPLES = 2**ADDR_WIDTH; 
	reg [DATA_WIDTH-1:0] rom [SAMPLES-1:0];

	initial begin
		$readmemb("rom_single_port_init.txt", rom);
	end

	always @ (posedge clk) begin
		q <= rom[addr];
	end

endmodule
