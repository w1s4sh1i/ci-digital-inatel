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
Type: Laboratory
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

// Carry-Save Adder

module csa_adder (
    input [3:0] A,B,C,
    output [3:0] Sum,
    output Cout
  );

  wire [3:0] c1,s1,c2;
  genvar i;

  generate
	fulladder fulladder_inst1(A[0],B[0],C[0],s1[0],c1[0]);
	for (i=1; i<3; i= i+1) begin
		fulladder fulladder_inst(A[i], B[i],C[i], s1[i], c1[i]);
	end
    	
	fulladder fulladder_inst_final (A[3],B[3],C[3],s1[3],c1[3]);
    
    	assign Sum[0] = s1[0];

	halfadder halfadder_layer2_inst1(s1[1],c1[0],Sum[1],c2[0]);
    	for (i=1; i<=2; i= i+1) begin
        	fulladder fulladder_layer2_inst(s1[i+1],c1[i],c2[i-1],Sum[i+1],c2[i]);
    	end

    	wire undriven; 
    	
	halfadder halfadder_layer2_inst_final(c1[3],c2[2],Cout,undriven);
  endgenerate


endmodule

// Split files
module fulladder (
    input a,b,cin,
    output sum,carry);
  wire ha_sum1;
  wire ha_sum2;
  wire ha_carry1;
  wire ha_carry2;

  halfadder ha1(a,b,ha_sum1,ha_carry1);
  halfadder ha2(cin,ha_sum1,ha_sum2,ha_carry2);

  assign sum = ha_sum2;
  assign carry = ha_carry1 | ha_carry2;

endmodule

module halfadder(
    input a,b,
    output sum,carry);

  assign sum = a ^ b;
  assign carry = a & b;

endmodule

