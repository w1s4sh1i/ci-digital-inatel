/*
Program: CI Digital T2/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps 

module demux1x2(
    input din,
    input sel,
    output y0, y1
);
    assign {y0,y1} = {2{din}} & {~sel, sel};

endmodule

module demux1x8( // #(parameter N = 1, M = 8, SEL = $clog(M)) (
    input 	 d,
    input  [2:0] sel,
    output [7:0] y
);
    wire [1:0] m;
    wire [3:0] n;

    // genvar i; generate ... endgenerate
    // Nível 1: primeiro demux
    demux1x2 n00 (
	    .din(d), .sel(sel[2]), 
	    .y0(m[0]), .y1(m[1])
    );
    
    // Nível 2: cada saída do nível 1 vai para outro demux
    demux1x2 n10 (
	    .din(m[0]), .sel(sel[1]),
	    .y0(n[0]), .y1(n[1])
    );

    demux1x2 n11 (
	    .din(m[1]), .sel(sel[1]), 
	    .y0(n[2]), .y1(n[3])
    );  

    // Nível 3: cada saída do nível 2 vai para outro demux
    demux1x2 n20 (
	    .din(n[0]), .sel(sel[0]), 
	    .y0(y[0]), .y1(y[1])
    );
    
    demux1x2 n21 (
	    .din(n[1]), .sel(sel[0]), 
	    .y0(y[2]), .y1(y[3])
    );
    
    demux1x2 n22 (
	    .din(n[2]), .sel(sel[0]), 
	    .y0(y[4]), .y1(y[5])
    );
    
    demux1x2 n23 (
	    .din(n[3]), .sel(sel[0]), 
	    .y0(y[6]), .y1(y[7])
    );

endmodule
