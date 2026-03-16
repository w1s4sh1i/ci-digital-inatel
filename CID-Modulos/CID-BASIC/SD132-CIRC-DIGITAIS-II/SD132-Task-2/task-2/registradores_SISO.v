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

module registradores_SISO #(
    parameter N = 8 // Número de bits, pode ser ajustado até 32
)(
    input wire clk,
    input wire reset,      // reset assíncrono (ativo alto)
    input wire enable,     // permite o shift (ativo alto)
    input wire dir,        // 0: direita, 1: esquerda
    input wire serial_in,  // entrada serial
    output wire serial_out // saída serial
);

    // Garante que N não ultrapasse 32 bits
    localparam MAX_BITS = 32;
    reg [MAX_BITS-1:0] shift_reg;

    // Saída serial depende da direção
    assign serial_out = (dir == 1'b0) ? shift_reg[0] : shift_reg[N-1];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_reg <= 0;
        end else if (enable) begin
            if (dir) begin
                // shift left: entra serial_in em LSB
                shift_reg[N-1:0] <= {shift_reg[N-2:0], serial_in};
            end else begin
                // shift right: entra serial_in em MSB
                shift_reg[N-1:0] <= {serial_in, shift_reg[N-1:1]};
            end
        end
    end
endmodule
