/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-013
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module and_primitive_tb;

	reg a,b;
    wire y;

	and_primitive U1 (
		.a(a),.b(b),
		.y(y)
	);

    initial begin
        a = 0; b = 0;
        #20;
        a = 0; b = 1;
        #20;
        a = 1; b = 0;
        #20;
        a = 1; b = 1;
        #20;          
        
    end
               
endmodule






