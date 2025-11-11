/*
Program: CI Digital 02/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-014
Type: Testbench
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;
module tb_demux_3x8;

    reg [2:0] in;
    wire [7:0] out;

    demux_3x8 U1 (
        .in(in),
        .out(out)
    );

    initial begin

        in  = 3'b000;#10;

        in  = 3'b001;#10;

        in  = 3'b010;#10;

        in  = 3'b011;#10;

        in  = 3'b100;#10;

        in = 3'b101; #10;

        in = 3'b110; #10;

        in = 3'b111; #10;

        #10 $stop; 
    end

endmodule
