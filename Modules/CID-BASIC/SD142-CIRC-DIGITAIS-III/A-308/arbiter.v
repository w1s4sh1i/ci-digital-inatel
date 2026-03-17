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
Type: Laboratory
Data: febuary, 6 2026
*/

module arbiter ( 
	input resetn, clock,
	input [2 : 0] r,
	output [2 : 0] g
);  
  
  reg [1 : 0] y , Y;
  
  localparam Idle = 2'b00 , gnt1 = 2'b01 , gnt2 = 2'b10 , gnt3 = 2'b11;
  
  // Next state combinational circuit
	always @( r , y ) begin
		case (y) 
			Idle:
				casex (r)
				  3'b000 : Y = Idle;
				  3'b1xx : Y = gnt1;
				  3'b01x : Y = gnt2;
				  3'b001 : Y = gnt3;
				  default : Y = Idle;		
				endcase
			gnt1:
				if (r [0])
					Y = gnt1;
				else
					Y = Idle;
			gnt2 :
				if (r [1])
					Y = gnt2;
				else
					Y = Idle;
			gnt3 :
				if (r[2])
				Y = gnt3;
				else
				Y = Idle;
		default :
		  Y = Idle;
		endcase
	end	

  // Sequential block
	always @( posedge clock ) begin 
		if ( resetn == 0 )
		  y <= Idle;
		else
		  y <= Y;
	end

  // D e fi n e output
  assign g[0] = ( y == gnt1 );
  assign g[1] = ( y == gnt2 );
  assign g[2] = ( y == gnt3 );

endmodule
