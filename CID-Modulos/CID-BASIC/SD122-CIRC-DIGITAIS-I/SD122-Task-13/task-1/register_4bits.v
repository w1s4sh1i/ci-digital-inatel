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

module register_4bits (
    input [3:0] D,
    input clk, rst, we, 
    output reg [3:0] Q
);

    always @ (posedge clk, posedge rst) begin
        if (rst) begin
            Q <= 4'b0000; 
        end
        else if (we) begin 
            Q <= D;
        end
    end

endmodule
