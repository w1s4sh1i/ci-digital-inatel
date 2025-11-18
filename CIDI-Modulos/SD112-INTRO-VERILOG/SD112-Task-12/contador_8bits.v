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

module contador_8bits #(parameter WIDTH = 8)(
    input clk,             
    input rst,  
    input en,     
    output reg[WIDTH-1:0] out  
);


  always @ (posedge clk) begin
    if (rst)             
      out <= {WIDTH{1'b0}};
    else                    
      if (~en) 
        out <= out + 1;
      else
        out <= out;
  end
endmodule
