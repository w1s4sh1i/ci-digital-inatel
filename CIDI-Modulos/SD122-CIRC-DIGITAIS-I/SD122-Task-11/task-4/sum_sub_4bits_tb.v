/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Testbench
Data: november, 19 2025
*/

`timescale 1 ns / 1 ps;

module sum_sub_4bits_tb;

	// Parameters
	localparam DELAY = 5, WIDTH = 4; 
	//Ports
	reg [3:0] a, b;
	reg sub;
	wire carry_out;
	wire [3:0] result;

 	sum_sub_4bits  UUT (
    	.a(a), .b(b), .sub(sub),
    	.carry_out(carry_out), .result(result)
  	);

	initial begin
		
		$dumpfile("CIDI-SD122-A111-4.vcd"); 
        $dumpvars(0, sum_sub_4bits_tb); 
		
		$display("|A	|B	|Sub|Cout|Result|");
		$monitor("|%b	|%b	|%b  |%b   |%b	|",
				a, b, sub, carry_out, result
		);
	end
	
	integer i,j,k; 
  
	initial begin

		a = 4'h0;
		b = 4'h0;
		sub = 1'b0;

		for ( i = 0; i < WIDTH; i = i + 1) begin
		  a = i;
		  for ( j = 0; j < WIDTH; j = j + 1) begin
			b = j;
			for ( k = 0; k < 2; k = k + 1) begin
			  sub = k;
			  #DELAY;
			end
		  end
		end      

	end

endmodule
