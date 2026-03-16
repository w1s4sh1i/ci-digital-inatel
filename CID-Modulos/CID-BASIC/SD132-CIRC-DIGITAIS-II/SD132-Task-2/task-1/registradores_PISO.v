/*
Program: CI Digital T2/2025
Class: Circuito Digitais II 
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-202
Type: Laboratory
Data: november, 30 2025
*/

`timescale 1 ns / 1 ps;

module registradores_PISO #( parameter num_bits = 8) (
    input wire reset,
    input wire clk,
    input wire load,
    input wire dir, // 0: shift right, 1: shift left
    input wire [num_bits-1:0] data_in,
    output wire data_out
);

    reg [num_bits-1:0] reg_data;

    // Definição da saída serial conforme direção
    assign data_out = (dir == 1'b0) ? reg_data[0] : reg_data[num_bits-1];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_data <= 0;
        end else if (load) begin
            reg_data <= data_in;
        end else if (dir) begin
            // shift left: bit [num_bits-2:0] vai para [num_bits-1:1], bit 0 recebe 0
            reg_data <= {reg_data[num_bits-2:0], 1'b0};
        end else begin
            // shift right: bit [num_bits-1:1] vai para [num_bits-2:0], bit [num_bits-1] recebe 0
            reg_data <= {1'b0, reg_data[num_bits-1:1]};
        end
    end

endmodule
