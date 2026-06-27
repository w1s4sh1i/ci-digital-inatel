`timescale 1ns / 1ps

module cdc_3stage_sync_tb;

	localparam	WIDTH = 8, PRECISION = 3;  
	localparam 	real	FREQ_SRC = (1.0/250.0) * (10**PRECISION),
				FREQ_DEST = (1.0/491.52) * (10**PRECISION);

	reg              src_clk;
	reg              src_arstn;
	reg  [WIDTH-1:0] src_data;

	reg              dest_clk;
	reg              dest_arstn;

	wire [WIDTH-1:0] dest_data;

	cdc_3stage_sync #(
		.WIDTH(WIDTH)
	) DUT_cdc_3ss (
		.src_clk(src_clk),
		.src_arstn(src_arstn),
		.src_data(src_data),
		.dest_clk(dest_clk),
		.dest_arstn(dest_arstn),
		.dest_data(dest_data)
	);
	
	// Monitoramento
	initial begin
		$dumpfile("cdc_3ss-sim.vcd");
		$dumpvars(0, cdc_3stage_sync_tb);
		$display("|Time	|src_data	|dest_data	|");
		$monitor("|%0t	|%h 		|%h		|", $time, src_data, dest_data);
	end

	// Geração de Clocks Assíncronos (Origem - source)
	always #(FREQ_SRC/2) src_clk = ~src_clk;

	// Geração de Clocks Assíncronos (Destino - destiny)
	always #(FREQ_DEST/2) dest_clk = ~dest_clk;

	// Estímulos de Teste
	initial begin
		// Inicialização e Resets
		src_clk		= 1'b0;
		dest_clk	= 1'b0;
		src_arstn 	= 1'b0;
		dest_arstn	= 1'b0;
		src_data	= 1'b0;

		// Liberação dos resets após alguns ciclos
		#10; 
		src_arstn  = 1'b1;
		dest_arstn = 1'b1;

		// Injeção de dados: domínio de origem
		@(posedge src_clk);
		src_data = 8'hAA;

		#15;
		@(posedge src_clk);
		src_data = 8'h55;

		#20;
		@(posedge src_clk);
		src_data = 8'hFF;

		#10;
		src_arstn 	= 1'b0;
		dest_arstn	= 1'b0;
		
		#10;
		$finish;
	end

endmodule
