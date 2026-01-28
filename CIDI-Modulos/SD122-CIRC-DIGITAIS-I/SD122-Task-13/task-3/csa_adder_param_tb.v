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
Type:  Testbench
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module csa_adder_param_tb;


  localparam DELAY = 10, WIDTH = 8;

  reg [WIDTH-1:0] A,B, C;
  wire  Cout;
  wire [WIDTH-1:0] Sum;


  csa_adder_param #(.WIDTH(WIDTH))  csa_adder_param_inst (
    .A(A), .B(B), .C(C), 
    .Cout(Cout), .Sum(Sum)
  );

	initial begin
		
		$dumpfile("CIDI-SD122-A113-3-2.vcd"); 
        	$dumpvars(0, csa_adder_param_tb); 
		
		$display("|A	 |B	  |C	   |Cout|Sum		|");
		$monitor("|%b|%b|%b|%b   |%b	|",
			A, B, C, Cout, Sum
		);
	end
	
	/*
    task //expect;
    input [WIDTH-1:0] exp_out;
    if (Sum !== exp_out) begin // Atualizar demonstrador para $monitor
      $display("TEST FAILED");
      $display("At time %0d A=%b B=%b C=%b Sum=%b, //expected value = %b",
               $time, A, B, C, Sum, exp_out);
      $finish;
    end
   else begin // Reformular uso dos recursos
      $display("At time %0d A=%b B=%b C=%b Sum=%b, //expected value = %b",
               $time, A, B, C, Sum, exp_out);
   end
  endtask
  */
  
  initial begin
		
		A <= 8'b0001_0001;
		B <= 8'b0000_0001;
		C <= 8'b0000_0001;
		#DELAY;
		//expect(A+B+C);
		
		A <= 8'b0010_0010;
		B <= 8'b0100_0010;
		C <= 8'b0010_0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 8'b1000_1000;
		B <= 8'b0010_1000;
		C <= 8'b0000_0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 8'b0100_0000;
		B <= 8'b0010_0000;
		C <= 8'b0000_0000;
		#DELAY;
		//expect(A+B+C);
		
		A <= 8'b0100_0000;
		B <= 8'b0000_0000;
		C <= 8'b0000_0000;
		#DELAY;
		//expect(A+B+C);
	
	end
  
endmodule
