/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-310)
Type: Testbench
Data: febuary, 9 2026
*/

`timescale 1 ns / 1 ps

module uart_tb;

	localparam WIDTH = 8, DELAY = 10, REPEAT = 5; 

	reg  clk, reset;

	// RX Data
	wire [WIDTH-1 : 0] data_out;
	wire rx_done;
	//reg  rx;

	// TX Data
	reg [WIDTH-1 : 0] data_in;
	reg  tx_start;
	wire  tx, tx_done;

	uart_tx  uart_tx_inst (
		.clk(clk), .reset(reset),
		.data_in(data_in),
		.tx_start(tx_start),
		.tx(tx),
		.tx_done(tx_done)
	);

	uart_rx  uart_rx_inst (
		.clk(clk), .reset(reset),
		.rx(tx),
		.rx_done(rx_done),
		.data_out(data_out)
	);

	// [x] Alterar para $monitor;
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD142-A310-uart.vcd"); 
		$dumpvars(0, uart_tb); 

		// Editar
		$display("|TIME|START |DATA IN |DATA OUT |");
		$monitor("|%0t |%b |%b |%b |", 
			  $time, tx_start, data_in, data_out
		); 
	end

	always #(DELAY/2) clk = ~clk;

	initial begin
		{clk, reset} = {1'b0, 1'b0};
	end

	integer i;
	
	initial begin
		
		#(DELAY*2);
		reset = 1'b1;
		
		#(DELAY*2);
		reset = 1'b0;

		for (i = 0; i < REPEAT; i = i+1) begin
			
			data_in <= $random;
			
			@(posedge clk);
			tx_start <= 1'b1;
			
			@(posedge clk);
			tx_start <= 1'b0;

			while (tx_done !== 1'b1)
			@(posedge clk);

			while (rx_done !== 1'b1)
			@(posedge clk);

			while (tx_done !== 1'b0 || rx_done !== 1'b0)
			@(posedge clk);

			#(DELAY*50);

		end
	
		#(DELAY*10);
		$finish;
	
	end

endmodule

