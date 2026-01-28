/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-114
Type:  Testbench
Data: november, 21 2025
*/

`timescale 1 ns / 1 ps;

module ieee754_subtractor (
    input [31:0] a,
    input [31:0] b,
    output [31:0] result
);

    reg [23:0] mantissa_a, mantissa_b;
    reg [24:0] mantissa_diff;
    reg [7:0] exp_diff;
    reg [7:0] expoente_maior, expoente_final;
    reg [4:0] shift; // até 24 posições
    reg sign;

    always @(*) begin
        // Extrai mantissas com bit implícito
        mantissa_a = {1'b1, a[22:0]};
        mantissa_b = {1'b1, b[22:0]};
        sign = 0; // resultado positivo por padrão

        // Alinhamento de expoentes
        if (a[30:23] >= b[30:23]) begin
            exp_diff = a[30:23] - b[30:23];
            expoente_maior = a[30:23];
            mantissa_b = mantissa_b >> exp_diff;
        end else begin
            exp_diff = b[30:23] - a[30:23];
            expoente_maior = b[30:23];
            mantissa_a = mantissa_a >> exp_diff;
        end

        // Subtração das mantissas
        if (mantissa_a >= mantissa_b) begin
            mantissa_diff = mantissa_a - mantissa_b;
            sign = 0; // positivo
        end else begin
            mantissa_diff = mantissa_b - mantissa_a;
            sign = 1; // negativo
        end

        // Normalização
        if (mantissa_diff == 0) begin
            shift = 0;
            expoente_final = 0;
        end else begin
            shift = 0;
            while (mantissa_diff[23 - shift] == 0 && shift < 23) begin
                shift = shift + 1;
            end
            mantissa_diff = mantissa_diff << shift;
            expoente_final = expoente_maior - shift;
        end
    end

    assign result[31] = sign;
    assign result[30:23] = expoente_final;
    assign result[22:0] = mantissa_diff[22:0];

endmodule
