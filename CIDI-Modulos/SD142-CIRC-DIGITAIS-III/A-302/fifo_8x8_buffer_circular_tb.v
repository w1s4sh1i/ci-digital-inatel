/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-302)
Type: TestBench
Data: febuary, 2 2026
*/

`timescale 1 ns / 1 ps

module fifo_8x8_buffer_circular_tb;

	localparam WIDTH = 8; 
	
	reg clk, reset, rd, wr;
	reg [WIDTH-1 : 0] w_data;
	
	wire full, empty;
	wire [WIDTH-1 : 0] r_data;

	fifo_8x8_buffer_circular UUT (
		.clk(clk), .reset(reset), .rd(rd), .wr(wr),
		.w_data(w_data),
		.full(full), .empty(empty),
		.r_data(r_data)
	);
 
	always #5  clk = ! clk;
	
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD142-A301-ff8x8.vcd");
		$dumpvars(0, fifo_8x8_buffer_circular_tb);
			
		$display("|TIME	|STORAGE |DATA (write)|DATA (read) |");
		$monitor("|%0t	|%d	 |%b |%b |", 
			  $time, full, w_data, r_data
		);
		
	end

	integer i; 

	initial begin

		clk <= 1'b0; 
		reset <= 1'b1; 
		wr <= 1'b0; 
		rd <= 1'b0; 

		#5; 
		reset <= 1'b0; 
		wr <= 1'b1; 
		
		i = 0;

		$display("---Writing data---");

		// Task: Processing with 
		for (i = 0; i < WIDTH; i = i+1 ) begin
			@(posedge clk);
			w_data <= $random;
			#5; 
		end

		wr <= 1'b0; 

		// [ ] Analisar possibilidade de resgate por referência (mensagem);
		$display("---Reading Data---");

		rd <= 1'b1;

		for (i = 0; i < WIDTH; i = i+1 ) begin
			@(posedge clk);
			#5; 
		end

		#10;
		$finish;

	end

endmodule
