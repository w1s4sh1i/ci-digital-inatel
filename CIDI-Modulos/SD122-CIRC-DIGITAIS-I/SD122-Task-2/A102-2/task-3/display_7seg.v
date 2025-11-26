/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-102-2
Type: Laboratory
Data: november, 5 2025
*/

`timescale 1 ns / 1 ps;

// Nível de ativação 0

module display_7seg (
    input		[3:0] in,
    output reg	[6:0] out
);
    always @(*) begin
        
        case (in)
            4'b0000: out = 7'b0000001;
            4'b0001: out = 7'b1001111;
            4'b0010: out = 7'b0010010;
            4'b0011: out = 7'b0000110;
            4'b0100: out = 7'b1001100;
            4'b0101: out = 7'b0100100;
            4'b0110: out = 7'b0100000;
            4'b0111: out = 7'b0001111;
            4'b1000: out = 7'b0000000;
            4'b1001: out = 7'b0000100; // 9
            /*
            4'b1010: out = 7'b0000000; // 10 a
            4'b1011: out = 7'b0000000; // 11 b
            4'b1100: out = 7'b0000000; // 12 c
            4'b1101: out = 7'b0000000; // 13 d
            4'b1110: out = 7'b0000000; // 14 e 
            4'b1111: out = 7'b0000000; // 15 f
            */
            default: out = 7'bxxxxxxx;
        endcase
    end
    
endmodule
