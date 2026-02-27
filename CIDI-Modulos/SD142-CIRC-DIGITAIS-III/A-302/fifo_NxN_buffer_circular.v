/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-301 (A-302)
Type: Laboratory
Data: febuary, 2 2026
*/

`timescale 1 ns / 1 ps

module fifo_NxN_buffer_circular #( 
    parameter N = 8, W = 8
)(
    input clk, reset, rd, wr,
    input [N-1:0] w_data,
    output full, empty,
    output reg [N-1:0] r_data
);

    reg [$clog2(N):0] w_ptr, r_ptr;
    reg [N-1 : 0] fifo_nxn_buffer [W-1 : 0];

    wire full_internal;
    wire empty_internal;

    assign full_internal = ((w_ptr + 1) % N) == r_ptr;
    assign full = full_internal;
    
    assign empty_internal = w_ptr == r_ptr;
    assign empty = empty_internal;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            w_ptr <= 1'b0;
        end else if (wr && !full_internal) begin
            fifo_nxn_buffer[w_ptr] <= w_data;
            w_ptr <= (w_ptr + 1) % N;
        end
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            r_ptr <= 1'b0;
            r_data <= 8'b00000000;
        end else if (rd && !empty_internal) begin
            r_data <= fifo_nxn_buffer[r_ptr];
            r_ptr <= (r_ptr + 1) % N;
        end
    end

endmodule
