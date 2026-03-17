/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T5)
Type: TestBench
Data: febuary, 2 2026
*/

module single_port_rom_tb;

  // Parameters
  localparam	DATA_WIDTH	= 8,
  				ADDR_WIDTH	= 6,
  				DELAY		= 100,
  				SAMPLES		= 2**ADDR_WIDTH;

  //Ports
  reg						clk;
  reg	[ADDR_WIDTH-1 : 0]	addr;
  wire	[DATA_WIDTH-1 : 0]	q;

	single_port_rom #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
	)
	UUT (
		.addr(addr),
		.clk(clk),
		.q(q)
	);
	
	// [x] Alterar para $monitor;
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CIDI-SD142-A301-rom.vcd"); 
		$dumpvars(0, single_port_rom_tb); 

		// Editar
		$display("|TIME|CLK |ADDR |Q |");
		$monitor("|%0t |%b |%b |%b |", 
			  $time, clk, addr, q
		); 
	end

	always #(DELAY/10)  clk = ! clk;

	integer seed,i; 

	always @(posedge clk) seed = $time;

	initial begin
		
		clk = 1'b0;
		#(DELAY/5);
		
		for (i = 0; i < (SAMPLES); i = i + 1) begin
			addr <= $random(seed);
			@(posedge clk);
			// display
			#DELAY;
		end

		$finish;
	end

endmodule
