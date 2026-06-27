`timescale 1ns / 1ps

module cdc_mcp_handshake_tb;

	localparam	WIDTH = 8, PRECISION = 3;  
	localparam 	real	FREQ_SRC = (1.0/250.0) * (10**PRECISION),
				FREQ_DEST = (1.0/491.52) * (10**PRECISION);

	reg             src_clk;
	reg             src_arstn;
	reg             src_valid;
	reg [WIDTH-1:0] src_data;
	wire            src_ready;

	reg             dest_clk;
	reg             dest_arstn;
	wire             dest_valid;
	wire [WIDTH-1:0] dest_data;

	cdc_mcp_handshake #(.WIDTH(WIDTH)) dut (.*);

	// Geração de Clocks (Frequências descorrelacionadas)

	always #(FREQ_SRC/2) src_clk = ~src_clk;
	always #(FREQ_DEST/2) dest_clk = ~dest_clk;

	// Tarefa para envio de dados com handshake
	task send_data(
		input [WIDTH-1:0] data
	);
		begin
		    @(posedge src_clk);
		    // Aguarda a liberação do loop anterior
		    wait (src_ready); 
		    src_valid = 1'b1;
		    src_data  = data;
		    @(posedge src_clk);
		    src_valid = 1'b0;
		end
	endtask

	// Procedimento de Teste
	initial begin
		
		src_clk = 1'b0;
		dest_clk = 1'b0;
		
		src_arstn  = 1'b0;
		dest_arstn = 1'b0;
		src_valid  = 1'b0;
		src_data   = 1'b0;

		#10;
		src_arstn  = 1'b1;
		dest_arstn = 1'b1;

		// Inicia transferências
		#5 send_data(8'hAA);
		#10 send_data(8'h55);
		#10 send_data(8'hBE);

		// Aguarda a última transferência cruzar completamente
		wait (dest_data == 8'hBE && dest_valid);
		
		#15; 
		$finish;
	end
	
	// Stopping Early
	initial begin
		#250; 
		$finish;
	end 
	
	// Monitoramento no console
	initial begin
	
		$dumpfile("cdc_handshake-sim.vcd");
		$dumpvars(0, cdc_mcp_handshake_tb);
		$display("|Time	|src_ready	|src_data	||dest_valid	|dest_data	|");
		$monitor("|%0t	|%h 		|%h		||%b		|%h		|", 
						$time, src_data, dest_data, dest_valid, dest_data);
	
	end

endmodule
