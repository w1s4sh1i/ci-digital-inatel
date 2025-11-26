/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-106
Type: Laboratory
Data: november, 25 2025
*/

`timescale 1 ns / 1 ps;

module moore_pass( // #(parameter PASS = 3'b101)(
    input 	clk,
    input 	rst_n,
    input 	x,
    output reg  z // Moore - Latch 
);

    // Definição dos estados
    localparam [1:0] S0 = 2'b00;
    localparam [1:0] S1 = 2'b01;
    localparam [1:0] S2 = 2'b10;
    localparam [1:0] S3 = 2'b11;

    reg [1:0] estado_atual, proximo_estado;

    // Lógica de transição de estados (sequencial)
    always @(posedge clk or negedge rst_n) begin
    
    	estado_atual <= (!rst_n) ? S0 : proximo_estado;
    
    end

    // Lógica do próximo estado (combinacional)
    always @(*) begin
        case (estado_atual)
			// Check pass;
			S0: proximo_estado = (x == 1'b1) ? S1 : S0;
			S1: proximo_estado = (x == 1'b0) ? S2 : S1;
			S2: proximo_estado = (x == 1'b1) ? S3 : S0;
			// Checa sobreposição (Analisar sequencia de ativação)
			S3: proximo_estado = (x == 1'b0) ? S2 : S1; // S1:S0
            default: proximo_estado = S0;
        endcase
    end

    // Lógica de saída (característica de Moore)
    always @(*) begin
        z <= (estado_atual == S3);  
    end

endmodule


