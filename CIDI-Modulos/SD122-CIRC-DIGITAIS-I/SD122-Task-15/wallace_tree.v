/*
Program: CI Digital T2/2025
Class: Circuito Digital 1  
Class-ID: D122
Advisor: Felipe Rocha 
Devicer-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A115
Type: Laboratory
Data: november, 17 2025
*/

`timescale 1 ns / 10 ps

// Versão 1.0

module wallace #(parameter N = 4, M = 8)(
    //inputs and outputs
    input  [N-1 : 0] A,B,
    output [M-1 : 0] prod
);
    //internal variables.
	wire s11,s12,s13,s14,s15;
	wire s22,s23,s24,s25,s26;
	wire s32,s33,s34,s35,s36,s37;
    wire c11,c12,c13,c14,c15;
	wire c22,c23,c24,c25,c26;
	wire c32,c33,c34,c35,c36,c37;
    wire [6:0] p0,p1,p2,p3;

	//initialize the p's
	// genarate ... endgenarate
	assign  p0 = A & {4{B[0]}};
	assign  p1 = A & {4{B[1]}};
	assign  p2 = A & {4{B[2]}};
	assign  p3 = A & {4{B[3]}};

	//final product assignments    
	assign prod = {s37, s36, s34, s32, s22, s11, p0[0]};
	
	//first stage
	half_adder ha11 (p0[1],p1[0],s11,c11);
	
	full_adder fa12 (p0[2], p1[1], p2[0], s12,c12);
	full_adder fa13 (p0[3], p1[2], p2[1], s13,c13);
	full_adder fa14 (p1[3], p2[2], p3[1], s14,c14);
	
	half_adder ha15 (p2[3], p3[2], s15, c15);

	//second stage
	half_adder ha22 (c11,s12,s22,c22);
	
	full_adder fa23 (p3[0], c12,  s13, s23, c23);
	full_adder fa24 (  c13, c32,  s14, s24, c24);
	full_adder fa25 (  c14, c24,  s15, s25, c25);
	full_adder fa26 (  c15, c25,p3[3], s26, c26);

	//third stage
	half_adder ha32 (c22,s23,s32,c32);
	half_adder ha34 (c23,s24,s34,c34);
	half_adder ha35 (c34,s25,s35,c35);
	half_adder ha36 (c35,s26,s36,c36);
	half_adder ha37 (c36,c26,s37,c37);

endmodule
