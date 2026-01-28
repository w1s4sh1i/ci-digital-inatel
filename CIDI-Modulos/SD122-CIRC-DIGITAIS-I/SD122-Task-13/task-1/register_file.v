/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-113
Type: Laboratory
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module register_file (
    input [1:0] addr,
    input clk, we, reset,
    input [3:0] data_in,
    output reg [3:0] data_out
);

    reg [3:0] register_0, register_1, register_2, register_3;

    always @ (posedge clk, posedge reset) begin
        
        if (reset) begin
            register_0 <= 4'b0000;
            register_1 <= 4'b0000;
            register_2 <= 4'b0000;
            register_3 <= 4'b0000;
        end 
        else if (we) begin
            case (addr)
                2'b00 : register_0 <= data_in;
                2'b01 : register_1 <= data_in;
                2'b10 : register_2 <= data_in;
                2'b11 : register_3 <= data_in;
                default: begin
					register_0 <= 4'b0000;
					register_1 <= 4'b0000;
					register_2 <= 4'b0000;
					register_3 <= 4'b0000;
                end
            endcase
        end
    end

    always @(*) begin
        case (addr)
            2'b00 : data_out = register_0;
            2'b01 : data_out = register_1;
            2'b10 : data_out = register_2;
            2'b11 : data_out = register_3;
            default: data_out = 4'b0000;
        endcase
    end

endmodule
