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
Type: Testbench
Data: novembro, 3 2025
*/

`timescale 1 ns / 1 ps;

module tb_A12_4;

reg clk, rst;
wire out;

A12_4 #(.CONST(10), .WIDTH (8)) U2 (.clk(clk),.rst(rst),
         .out(out)
);



always #5 clk = ~clk;

initial begin
    
    clk <= 0;
    rst <= 1'b1; 
    #60; 
    rst <= 0;
    #30; 
    #200;
    $finish;
end

endmodule
