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

module decoder8x3 #(parameter N = 8, M = 3) (
    input 		[N-1:0] in,
    output reg  [M-1:0] out
);
    always @(*) begin
        casex(in)
            8'b00000001 : out = 3'b000;
            8'b00000010 : out = 3'b001;
            8'b00000100 : out = 3'b010;
            8'b00001000 : out = 3'b011;
            8'b00010000 : out = 3'b100;
            8'b00100000 : out = 3'b101;
            8'b01000000 : out = 3'b110;
            8'b10000000 : out = 3'b111;
            default     : out = 3'bxxx; // 3'b000; 
        endcase
    end

endmodule

module top_module #(parameter N = 16, M = 4) (
    input  [N-1 : 0] in,
    output [M-1 :0] out
);
    localparam WIDTH_WIRE = 3, WIDTH_OUT = 8;
    wire [WIDTH_WIRE-1 : 0] low_out;
    wire [WIDTH_WIRE-1 : 0] high_out;
    wire high_active;

    decoder8x3 dec_low(
        .in(in[WIDTH_OUT-1 : 0]),
        .out(low_out)
    );

    decoder8x3 dec_high(
        .in(in[N-1 : WIDTH_OUT]),
        .out(high_out)
    );

    assign high_active = |in[N-1 : WIDTH_OUT];
    assign out = {high_active, high_active ? high_out : low_out};

endmodule
