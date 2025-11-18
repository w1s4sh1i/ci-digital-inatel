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

module DFF (
    input D, clk,rst,
    output reg Q
);


always @(posedge clk)
begin
  if (rst)
    Q <= 0;
  else
    Q <= D;
end


endmodule
