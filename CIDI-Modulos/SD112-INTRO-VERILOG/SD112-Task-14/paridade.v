/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: D112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module paridade #(
    parameter WIDTH = 4)
(
    input   [WIDTH-1:0] in,
    output             out
);

    function reg calcula_paridade (
    	input [WIDTH-1:0] dado);
        
        begin
                        
            calcula_paridade = ^dado;
        end
    
    endfunction

    assign out = calcula_paridade(in);

endmodule
