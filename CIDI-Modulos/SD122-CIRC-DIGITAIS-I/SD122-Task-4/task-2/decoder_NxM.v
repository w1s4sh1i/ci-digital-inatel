/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-104
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module decoder_NxM #(
    parameter N = 4,                 // número de bits de entrada
    parameter M = (1 << N)           // número de bits de saída = 2^N
)(
    input  wire [N-1:0] in,          // entrada binária
    output reg  [M-1:0] out          // saídas decodificadas
);
	 
    // Lógica combinacional
    always @(*) begin
        out = 0; // out = {(M-1){1'b0}};                     // zera todas as saídas
        out[in] = 1'b1; // ativa a linha correspondente
    end

endmodule
