/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-105
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module mux16x1 #(parameter N = 16, M = 4)(
    output reg out, // Alterar 
    input [N-1 : 0] in, 
    input [M-1 : 0] sel
);
    // -> Bloco combinacional: sensível a qualquer alteração nas entradas.
    always @(*) begin

    	// out = in[sel];     	
        case (sel)
            4'b0000:   out = in[0];
            4'b0001:   out = in[1];
            4'b0010:   out = in[2];
            4'b0011:   out = in[3];
            4'b0100:   out = in[4];
            4'b0101:   out = in[5];
            4'b0110:   out = in[6];
            4'b0111:   out = in[7];
            4'b1000:   out = in[8];
            4'b1001:   out = in[9];
            4'b1010:   out = in[10];
            4'b1011:   out = in[11];
            4'b1100:   out = in[12];
            4'b1101:   out = in[13];
            4'b1110:   out = in[14];
            4'b1111:   out = in[15];
            default: out = 1'b0; // Valor padrão para evitar a inferência de um latch.
        endcase
    end
endmodule
