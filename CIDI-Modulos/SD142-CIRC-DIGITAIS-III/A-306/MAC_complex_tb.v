/*
Program: CI Digital T2/2025
Class: Circuito Digitais III 
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306
Type: TestBench
Data: febuary, 03 2026
*/

`timescale 1 ns / 1 ps;

module MAC_complex_tb;

	// Parameters
	localparam WIDHT_IN = 8, WIDHT_OUT = 32, DELAY = 5, REPEAT = 10;

	//Ports
	reg 					clk, rst, en;
	reg	 [WIDHT_IN-1 : 0]	reA, reB, imA, imB;
	wire [WIDHT_OUT-1 : 0]	X,Y;

	integer seed1, seed2, seed3, seed4, i; 
	// [3:0] seed;  

	MAC_complex MAC_complex_testbench (
		.clk(clk), .rst(rst), .en(en),
		.reA(reA), .reB(reB),
		.imA(imA), .imB(imB),
		.X(X), .Y(Y)
	);

	always #DELAY  clk = !clk;
	
	always @(posedge clk) begin
		seed1 <= $time; 
		seed2 <= $time + 10; 
		seed3 <= $time + 20; 
		seed4 <= $time + 30; 
	end
	
	initial begin
		
		$dumpfile("CIDI-SD142-A306-B.vcd"); 
        $dumpvars(0, MAC_complex_tb); 
		
		$display("|A		|B		|Result		|";
		$monitor("(%d + j%d )*(%d +j%d) = (%d + j%d)", 
			reA, imA, reB, imB, X, Y
		); 
		
	end

	initial begin
	
		{clk, en, rst} <= {0,1,0}; 
		{reA, reB, imA, imB} <= {8'b0, 8'b0, 8'b0, 8'b0}; // [ ] Ajustar data   
		#DELAY; 

		{rst, en} <= {0, 1};

		for (i = 0; i < REPEAT; i = i + 1 ) begin
			
			@(posedge clk);
			reA <= $random(seed1) + $random(seed4);
			reB <= $random(seed2) + $random(seed3);
			imA <= $random(seed3);
			imB <= $random(seed4);   
			
			@(posedge clk);
			rst <= 1; 
			
			@(posedge clk);
			rst <= 0; 
		end 
		
		$finish;

	end
endmodule
