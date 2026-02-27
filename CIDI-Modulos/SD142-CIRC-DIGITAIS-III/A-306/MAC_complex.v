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
Type: Laboratory
Data: febuary, 03 2026
*/
`timescale 1 ns / 1 ps

module MAC_complex #(
	parameter	WIDHT_IN = 8, 
				WIDHT_OUT = 32,	
				DEFAULT_RE = {WIDHT_OUT{1'b0}},	
				DEFAULT_IM = {WIDHT_OUT{1'b0}}
)(
    input 						clk, rst, en,
    input	[WIDHT_IN-1  : 0]	reA, reB, imA, imB,

    output	[WIDHT_OUT-1 : 0]	X, Y
);

    wire signed [WIDHT_IN*2-1 : 0]	product1_re,
									product2_re,
									product1_im,
									product2_im;

    wire signed [WIDHT_OUT-1 : 0] sum_re, 
    							  sum_im; 

    reg signed [WIDHT_OUT-1 : 0] accumulator_re,
    							 accumulator_im;

	// Parte Real
    assign product1_re = $signed(reA) * $signed(reB);
    
    assign product2_re = $signed(imA) * $signed(imB); 
    
    assign sum_re = accumulator_re + product1_re + product2_re;
    
    // Parte Imaginária
    assign product1_im = $signed(reA) * $signed(imB);
    
    assign product2_im = $signed(imA) * $signed(reB);
    
    assign sum_im = accumulator_im + product1_im + product2_im; 

	// Saída
	assign X = accumulator_re;
    assign Y = accumulator_im;
    
    always @(posedge clk) begin
        
		if (en) begin
            accumulator_re <= sum_re; 
            accumulator_im <= sum_im;
		end else if (rst) begin
            accumulator_re <= {WIDHT_OUT{1'b0}}; 
            accumulator_im <= {WIDHT_OUT{1'b0}};
		end else begin
            accumulator_re <= DEFAULT_RE; 
            accumulator_im <= DEFAULT_IM;
		end

    end

endmodule
