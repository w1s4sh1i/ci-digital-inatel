/* header */

module decode_8b10b_tb;

	localparam DELAY = 10; 
	reg clk, reset, load;
	reg [7:0] datain;
  	reg dispin;

	wire [9:0] dataout_decode;
	wire dispout_decode, code_err_decode, disp_err_decode;

	decode_8b10b  decode_8b10b_inst (
	  .data_in(data_out_sipo),
	  .dispin(dispout_encode),
	  .dataout(dataout_decode),
	  .dispout(dispout_decode),
	  .code_err(code_err_decode),
	  .disp_err(disp_err_decode)
	);

	always #(DELAY/2)  clk = ! clk;

	// [ ] Data export

	initial begin
		
		reset <= 1'b1;
		clk <= 1'b0;
		#DELAY;

		reset <= 1'b0;
		load <= 1'b1;
		datain <= 8'b00011100;
		dispin = 1'b1;
		
		#DELAY;
		load <= 1'b0;
	
	end

endmodule
