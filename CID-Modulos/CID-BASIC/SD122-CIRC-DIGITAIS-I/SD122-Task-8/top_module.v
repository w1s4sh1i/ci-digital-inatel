/*
Program: CI Digital 02/2025
Class: Circuito Digitais I
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-108
Type: Laboratory
Data: november, 15 2025
*/

`timescale 1 ns / 1ps

module top_module #(parameter WIDTH = 4)(
    input  [WIDTH-1 :0] A, B,
    input  cin, 
    output cout,
    output [WIDTH-1 :0] sum
);
    wire   [WIDTH-1 :0] wc_out;

	assign wc_out[0] = cin; 
			
    adder4b UUT0 (
        .a(A[0]), .b(B[0]), .cin(wc_out[0]),
        .sum(sum[0]), .cout(wc_out[1])
    );

    adder4b UUT1 (
        .a(A[1]), .b(B[1]), .cin(wc_out[1]),
        .sum(sum[1]), .cout(wc_out[2])
    );

    adder4b UUT2 (
        .a(A[2]), .b(B[2]), .cin(wc_out[2]),
        .sum(sum[2]), .cout(wc_out[3])
    );

    adder4b UUT3 (
        .a(A[3]), .b(B[3]), .cin(wc_out[3]),
        .sum(sum[3]), .cout(cout)
    );

endmodule
