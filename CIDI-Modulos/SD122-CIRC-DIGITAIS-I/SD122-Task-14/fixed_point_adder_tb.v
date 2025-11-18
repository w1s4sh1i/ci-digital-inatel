/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-114
Type: Testbench
Data: november, 13 2025
*/

`timescale 1 ns / 1 ps;

module fixed_point_adder_tb;

	// parâmetros
	localparam DELAY = 10, SAMPLES = 10;
	localparam N = 8, M = 4;
	
	reg [N-1:0] a;
	reg [N-1:0] b;

	// Outputs
	wire [N-1:0] c;
	integer i; 

	// Instantiate the Unit Under Test (UUT)
	fixed_point_adder #(M+3,N) uut (
		.a(a), 
		.b(b), 
		.c(c)
	);

	//	These are to monitor the values...
	wire	[N-2:0]	c_out;
	wire	[N-2:0]	a_in;
	wire	[N-2:0]	b_in;
	wire	a_sign;
	wire	b_sign;
	wire	c_sign;
	
	
	assign	a_in = a[N-2:0];
	assign	b_in = b[N-2:0];
	assign	c_out = c[N-2:0];
	assign	a_sign = a[N-1];
	assign	b_sign = b[N-1];
	assign	c_sign = c[N-1];
	
	
	initial begin
		
		// Specify the VCD file name
		$dumpfile("CID-SD122-A114-fixed-point-adder.vcd"); 
        	$dumpvars(0, fixed_point_adder_tb); 
		
		// Atualizar vizualização dos dados
		$display("|i 	|a	|b	|c	|");
		$monitor("|%d	|%d	|%d	|%d	|", i, a, b, c);

		// Initialize Inputs
		a[N-2 : 0] = 0; // Zerar a referência
		a[N-1] = 0; 

		b[N-1] = 1'b0;
		b[N-2:0] = 3'b001;

		// Wait 100 ns for global reset to finish
        
		// Add stimulus here
		 for (i = 0; i < SAMPLES; i = i + 1) begin
			
			#DELAY; 
			a = a + 5;			//	why not?
			a[N-1] = 0;					//	a is negative...
			b[N-1] = 1;
			
			
			if (a[N-2 : 0] > 2.1E4) begin // Definir parameter
			// input will always be "positive"
				
				a = 0; // {N{0}};
				b[N-1] = 1;
				
				// b is negative... 
				// [ ] Corrigir valor de referência
				// Inverter o sistema o valor de b
				b[N-2 : 0] = ~b[N-2 : 0] + 1; // para 2.1E9 -> 3779351;
			end
		end
		
		#DELAY; 
		$finish; 
	end
	 
endmodule
