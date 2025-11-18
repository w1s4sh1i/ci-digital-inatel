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

module mux_2x1(
    input S, // Sinal de seleção
    input D0, // Entrada 0
    input D1, // Entrada 1
    output reg Y // Saída
);
    always@(*) begin
        case(S)
            1'b0: Y = D0;
            1'b1: Y = D1;
            default: Y = 1'bx; // 1'b0; 
        endcase
    end
endmodule

module mux_4x1 (
    input [1:0] S,
    input [2:0] D0, D1, D2, D3,
    output reg [2:0] Y
);
    always @(*) begin
        case (S)
            2'b00: Y = D0;
            2'b01: Y = D1;
            2'b10: Y = D2;
            2'b11: Y = D3;
            default: Y = 2'bxx;
        endcase
    end

endmodule

module mux_8x1(
    input [2:0] S,
    input [7:0] D,
    output Y
);
    wire out_y1, out_y2;

    mux_4x1 mux1(
        .S(S[1:0]), .D0(D[0]), .D1(D[1]), .D2(D[2]), .D3(D[3]),
        .Y(out_y1)
    );

    mux_4x1 mux2(
        .S(S[1:0]), .D0(D[4]), .D1(D[5]), .D2(D[6]), .D3(D[7]),
        .Y(out_y2)
    );

    mux_2x1 mux3(
        .S(S[2]), .D0(out_y1), .D1(out_y2), 
        .Y(Y)
    );

endmodule
