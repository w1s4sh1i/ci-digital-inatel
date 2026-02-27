/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-301-T1)
Type: TestBench
Data: febuary, 2 2026
*/

module ram_single_port_tb;

  // Parameters
  localparam	DATA_WIDTH = 8,
  				ADDR_WIDTH = 6,
  				DELAY 	   = 10;

  reg 					clk, we; 
  reg  [DATA_WIDTH-1:0] data;
  reg  [ADDR_WIDTH-1:0] addr;
  wire [ADDR_WIDTH-1:0] q;

	ram_single_port #(
		.DATA_WIDTH(DATA_WIDTH),
		.ADDR_WIDTH(ADDR_WIDTH)
	) UUT(
		.data(data),
		.addr(addr),
		.we(we),
		.clk(clk),
		.q(q)
  	);

	initial begin
	
		// dump
		// Specify the VCD file name
		$dumpfile("CIDI-SD142-A301-ram.vcd"); 
		$dumpvars(0, ram_single_port_tb); 

		// TODO: [ ] Ajustar funcionamento do monitor;
		$display("|At time	|adress	|Action	|data	|Q	|");
		$monitor("|%0t	|%b	|%s	|%b	|%b	|",
				$time, addr,
				( we ? "written to" : "reding the"),
				data, q	
		);

	end 

	always #(DELAY/2)  clk = ! clk;
	
	integer i; 

	initial begin

		we <= 1'b1; 
		clk <= 1'b0; 

		// Task processing
		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 ) begin
			@(posedge clk);
			addr = i;
			
			// action active 
			data = $random;
			
			#DELAY; 
		end

		#DELAY;
		we <= 1'b0;  
		
		// Reading data
		for (i = 0; i < (2**ADDR_WIDTH); i = i + 1 ) begin
			@(posedge clk);
			addr = i;
			
			// display
			#DELAY;
		end

		$finish; 
	end   

endmodule
