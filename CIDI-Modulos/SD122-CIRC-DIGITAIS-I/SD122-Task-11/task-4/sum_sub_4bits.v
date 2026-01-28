/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Laboratory
Data: november, 19 2025
*/

`timescale 1 ns / 1 ps;

module sum_sub_4bits ( // #(paramater WIDTH = 4)(
	input  [3:0] a, b,
	input  sub,
	output reg carry_out,
	output reg  [3:0] result
);

    always @(*) begin
        {carry_out,result} <=  sub ? a - ~b + 1'b1 : a + b; 
    end

endmodule
