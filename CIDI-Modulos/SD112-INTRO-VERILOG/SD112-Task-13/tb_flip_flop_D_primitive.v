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

module flip_flop_D_primitive_tb;

    reg d, clk, rst;
    wire q;

    flip_flop_D_primitive U1 (q, d, clk, rst);

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end


    initial begin

        rst = 1; d = 1; #10;
        rst = 0; #10;

        d = 1; #10;
        d = 0; #10;
        #20;
        $finish;
    end

endmodule
