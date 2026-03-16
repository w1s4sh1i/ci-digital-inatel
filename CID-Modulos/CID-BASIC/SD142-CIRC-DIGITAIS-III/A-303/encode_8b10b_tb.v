/* header */

module encoder_tb;

	localparam DELAY = 10; 
	
	reg clk, reset, load, dispin;
	reg [7:0] datain;

	wire [9:0] dataout_encode;
	wire dispout_encode;

	integer i; 
	
	encode_8b10b  encode_8b10b_inst (
		.datain(datain),
		.dispin(dispin),
		.dataout(dataout_encode),
		.dispout(dispout_encode)
	);

	wire data_out_piso;

	PISO_reg # (
	.num_bits(10)
	) PISO_reg_inst (
		.reset(reset),
		.clk(clk),
		.load(load),
		.dir(1'b1),
		.data_in(dataout_encode),
		.data_out(data_out_piso)
	);

  always #5  clk = ! clk;

	// [ ] Data export

	initial begin
		reset <= 1'b1;
		clk <= 1'b0;
		#DELAY;
		
		reset <= 1'b0;
		load <= 1'b1; 
		datain <= 8'b00011100;
		dispin = 1'b0;
		
		#DELAY; 
		load <= 1'b0; 
	end

endmodule




