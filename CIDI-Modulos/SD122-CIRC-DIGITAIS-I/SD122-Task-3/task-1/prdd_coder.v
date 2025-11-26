/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-103
Type: Laboratory
Data: octuber, 17 2025
*/

`timescale 1 ns / 1 ps;

module prdd_coder #(parameter N = 16, M = 4)(
    input wire [N-1 : 0] in,
    output reg [M-1 : 0] out
);
   always @(*) begin
        casex (in)
            16'b1xxxxxxxxxxxxxxx : out = 4'b1111;
            16'b01xxxxxxxxxxxxxx : out = 4'b1110;
            16'b001xxxxxxxxxxxxx : out = 4'b1101;
            16'b0001xxxxxxxxxxxx : out = 4'b1100;
            16'b00001xxxxxxxxxxx : out = 4'b1011;
            16'b000001xxxxxxxxxx : out = 4'b1010;
            16'b0000001xxxxxxxxx : out = 4'b1001;
            16'b00000001xxxxxxxx : out = 4'b1000;
            16'b000000001xxxxxxx : out = 4'b0111;
            16'b0000000001xxxxxx : out = 4'b0110;
            16'b00000000001xxxxx : out = 4'b0101;
            16'b000000000001xxxx : out = 4'b0100;
            16'b0000000000001xxx : out = 4'b0011;
            16'b00000000000001xx : out = 4'b0010;
            16'b000000000000001x : out = 4'b0001;
            16'b0000000000000001 : out = 4'b0000;
            default: out = 4'b0000;
        endcase
   end

endmodule
