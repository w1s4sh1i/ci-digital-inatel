/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-204
Type: Testbench
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

module sequencia_aleatoria (
    input clk,
    input rst,
    output reg [3:0] Q
);

    wire Q3 = Q[3];
    wire Q2 = Q[2];
    wire Q1 = Q[1];
    wire Q0 = Q[0];

    // Equações 
    wire D3 = (!Q3 &  Q2 & !Q1 &  Q0) |
              (!Q3 &  Q2 &  Q1 & !Q0); // !Q3 &  Q2 & (Q1 ^ Q0);

    wire D2 = (!Q2 & !Q1 &  Q0) |
              (!Q3 & !Q2 &  Q1 & !Q0); // !Q2 & (!Q1 & Q0 | !Q3 & Q1 & !Q0)

    wire D1 = (!Q3 & !Q0); // !(Q3 | Q0);

    wire D0 = (!Q3 & !Q2 & !Q1) |
              (!Q3 & !Q2 &  Q0) |
              (!Q3 & !Q1 &  Q0); // !Q3 & ((!Q2 & !Q1) | Q0 & (!Q2 | !Q1));

    // Flip-Flops tipo D
    always @(posedge clk or posedge rst) begin
        Q <= rst ? 4'b0000 : {D3, D2, D1, D0};
    end

endmodule
