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

module paridade #(parameter WIDTH = 4) (
	input   [WIDTH-1:0] in,
	output             out, par
);

    function reg calc_paridade (
    	input [WIDTH-1:0] data);
        
        begin
		calc_paridade = ^data;
        end
    
    endfunction

    assign out = calc_paridade(in);
    assign par = in[0]; // 1 odd or 0 even

endmodule
