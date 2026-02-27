/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-305 (A-308)
Type: Testbench
Data: febuary, 6 2026
*/
// testbench
module arbiter_tb;

	// Parameters

	//Ports
	reg	[2 : 0] r;
	reg	resetn ;
	reg	clock;
	wire	[2 : 0] g;

	arbiter arbiter_inst (
	.r(r),
	.resetn(resetn),
	.clock(clock),
	.g(g)
	);

	always #5  clock = ! clock ;


	reg [15*8-1 : 0] string_vector [3 : 0];
	initial begin
		string_vector = {"Idle", "gnt1", "gnt2", "gnt3"};
	end

	integer i,seed;

	// [ ] Data expors - alterar   
	always @(posedge clock) begin
		$display("At time: %t Current State: %s, r: %b, g: %b",$time,string_vector[arbiter_inst.Y],r,g);
		seed = $time;
		r = $random(seed); 
	end

	initial begin
		resetn = 1'b1; 
		clock = 1'b0; 

		#5;

		resetn = 1'b0; 
		#500;

		$finish;
	end

endmodule
