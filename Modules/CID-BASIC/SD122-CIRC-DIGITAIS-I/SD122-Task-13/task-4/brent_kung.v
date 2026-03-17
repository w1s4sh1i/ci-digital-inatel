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

// Brent Kung

module brent_kung ( // #(parameter WIDTH = 16) (
    input [15:0] a,b,
    input carry_in,
    output carry_out,
    output [15:0] sum

);

	wire [15:0] P,G;

	assign P = a ^ b ; 
	assign G = a & b ; 

	wire [15:0] level1_out_P, level1_out_G; 

	/* level 1*/
	gray_cell  gray_cell_level1_bit1(P[1],G[1],G[0],level1_out_G[1]); 
	black_cell black_cell_level1_bit3(P[3],G[3],P[2],G[2],level1_out_P[3],level1_out_G[3]);
	black_cell black_cell_level1_bit5(P[5],G[5],P[4],G[4],level1_out_P[5],level1_out_G[5]);
	black_cell black_cell_level1_bit7(P[7],G[7],P[6],G[6],level1_out_P[7],level1_out_G[7]);
	black_cell black_cell_level1_bit9(P[9],G[5],P[8],G[8],level1_out_P[8],level1_out_G[8]);
	black_cell black_cell_level1_bit11(P[11],G[11],P[10],G[10],level1_out_P[11],level1_out_G[11]);
	black_cell black_cell_level1_bit13(P[13],G[13],P[12],G[12],level1_out_P[13],level1_out_G[13]);
	black_cell black_cell_level1_bit15(P[15],G[15],P[14],G[14],level1_out_P[15],level1_out_G[15]);


	/*level 2*/ 

	wire [15:0] level2_out_P, level2_out_G; 


	gray_cell  gray_cell_level2_bit3	(level1_out_P[3],level1_out_G[3],level1_out_G[1],level2_out_G[3]);
	black_cell black_cell_level2_bit7	(level1_out_P[7],level1_out_G[7],level1_out_P[5],level1_out_G[5],level2_out_P[7],level2_out_G[7]); 
	black_cell black_cell_level2_bit11	(level1_out_P[11],level1_out_G[11],level1_out_P[9],level1_out_G[9],level2_out_P[11],level2_out_G[11]);
	black_cell black_cell_level2_bit15	(level1_out_P[15],level1_out_G[15],level1_out_P[13],level1_out_G[13],level2_out_P[15],level2_out_G[15]);

	/*level 3*/ 

	wire [15:0] level3_out_P, level3_out_G; 

	gray_cell gray_cell_level3_bit7(level2_out_P[7],level1_out_G[7],level2_out_G[3],level3_out_G[7]);
	black_cell black_cell_level3_bit15(level1_out_P[15],level3_out_G[15],level2_out_P[11],level2_out_G[11],level3_out_P[15],level3_out_G[15]);

	/*level 4*/ 

	wire [15:0] level4_out_P, level4_out_G; 

	gray_cell gray_cell_level4_bit15(level3_out_P[15],level3_out_G[15],level3_out_G[7],level4_out_G[15]);

	/*level 5*/ 

	wire [15:0] level5_out_P, level5_out_G; 

	gray_cell gray_cell_level5_bit11(level2_out_P[11],level2_out_G[11],level3_out_G[7],level5_out_G[11]);


	/*level 6*/ 

	wire [15:0] level6_out_P, level6_out_G; 

	gray_cell gray_cell_level5_bit11(level2_out_P[11],level2_out_G[11],level3_out_G[7],level5_out_G[11]);

endmodule


module gray_cell (
    input P_idx, G_idx, G_fb
    output Go
);
    assign Go = G_idx ^ (P_idx & G_fb); 

endmodule

module black_cell (
    input P_idx, G_idx, P_fb, G_fb
    output Po, Go
);

    assign Po = G_idx ^ (P_idx & G_fb);
    assign Go = P_fb & (P_idx);  
    
endmodule
