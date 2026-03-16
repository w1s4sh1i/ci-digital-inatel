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

module contador_descendente_12t0 (
    input clk,
    input rst,
    output reg [3:0] Q
);

    wire D3, D2, D1, D0;
    wire Q3 = Q[3];
    wire Q2 = Q[2];
    wire Q1 = Q[1];
    wire Q0 = Q[0];

    // Expressões lógicas 
    assign D0 = (!Q3 &  Q1 & !Q0) |
                ( Q2 & !Q1 & !Q0) |
                ( Q3 & !Q2 & !Q0);

    assign D1 = (!Q3 &  Q1 &  Q0) |
                (!Q2 &  Q1 &  Q0) |
                ( Q2 & !Q1 & !Q0) |
                ( Q3 & !Q1 & !Q0);

    assign D2 = (!Q2 & !Q1 & !Q0) |
                (!Q3 &  Q2 &  Q0) |
                (!Q3 &  Q2 &  Q1);

    assign D3 = ( Q3 & !Q2 &  Q0) |
                ( Q3 & !Q2 &  Q1) |
                (!Q3 & !Q2 & !Q1 & !Q0) |
                ( Q3 &  Q2 & !Q1 & !Q0);

    // Flip-flops tipo D
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 4'b1100;   // 12
        else
            Q <= {D3, D2, D1, D0};
    end

endmodule
