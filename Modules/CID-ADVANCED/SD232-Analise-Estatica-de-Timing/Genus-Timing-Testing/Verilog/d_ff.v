module d_ff (
	input  clk,
	input  rst_n,
	input  d,
	output q, q_n
);
	reg aux; 
	always @(negedge clk or negedge rst_n) begin
		if (!rst_n) begin
		    aux <= 1'b0;
		end else begin
		    aux <= d;
		end
	end

	assign q = aux; 
	assign q_n = ~aux;

endmodule

