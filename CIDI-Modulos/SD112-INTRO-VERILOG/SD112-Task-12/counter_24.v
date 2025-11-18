/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-012
Type: Laboratory
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module   counter_24    #(parameter W = 24) (
    input clk, reset, en,
    output reg [W-1:0] count
);

wire carry0, carry1, carry2;
wire [7:0] c1, c2, c3;

counter #(.WIDTH(8)) C1 (.clk(clk), .reset(reset), .en(en), .count(c1), .carry(carry0));
counter #(.WIDTH(8)) C2 (.clk(clk), .reset(reset), .en(~carry0), .count(c2), .carry(carry1));
counter #(.WIDTH(8)) C3 (.clk(clk), .reset(reset), .en(~carry1), .count(c3), .carry(carry2));


always @(posedge clk or posedge reset) begin
    if (reset)
        count <= 0;
    else
        count <= {c3, c2, c1};
        end

endmodule
