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

module demux_3x8 (
    input  [2:0] in,
    output reg [7:0] out
 );

    task demux(
        input  [2:0] in_data,
        output [7:0] out_data
     );
        begin
            out_data = 8'b0;         
            out_data[in_data] = 1'b1; 
        end
    endtask

    always @(*) begin
        demux(in, out);
    end

endmodule
