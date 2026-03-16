/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Testbench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module csa_adder_tb;

	localparam DELAY = 10;
  reg [3:0] A,B, C;
  wire  Cout;
  wire [3:0] Sum;

  csa_adder  csa_adder_inst (
    .A(A), .B(B), .C(C),
    .Cout(Cout), .Sum(Sum)
  );

	initial begin
		
		$dumpfile("CIDI-SD122-A113-3-1.vcd"); 
        	$dumpvars(0, csa_adder_tb); 
		
		$display("|A	|B	|C	|Cout	|Sum	|");
		$monitor("|%b	|%b	|%b	|%b	|%b	|",
			A, B, C, Cout, Sum
		);
	end
	
	/* Testing 
    	task //expect;
		input [3:0] exp_out;
		if (Sum !== exp_out) begin // Reformular uso dos recursos
		  //$display("TEST FAILED");
		  //$display("At time %0d A=%b B=%b C=%b Sum=%b, //expected value = %b",
		  //         $time, A, B, C, Sum, exp_out);
		  $finish;
		end
	   else begin
		  $display("At time %0d A=%b B=%b C=%b Sum=%b, //expected value = %b",
		           $time, A, B, C, Sum, exp_out);
	   end
	endtask
	// */
	
	initial begin
	
		A <= 4'b0001;
		B<= 4'b0001;
		C<= 4'b0001;
		#DELAY;
		//expect(A+B+C);
		
		A <= 4'b0010;
		B<= 4'b0010;
		C<= 4'b0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 4'b1000;
		B<= 4'b1000;
		C<= 4'b0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 4'b0000;
		B<= 4'b0000;
		C<= 4'b0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 4'b0000;
		B<= 4'b0000;
		C<= 4'b0000;
		#DELAY;
		//expect(A+B+C);
	end 

endmodule
