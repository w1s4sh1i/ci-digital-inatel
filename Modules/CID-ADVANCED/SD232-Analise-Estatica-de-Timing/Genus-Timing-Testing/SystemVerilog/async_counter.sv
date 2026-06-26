`include "d_ff.sv"

`timescale 1 ns / 1 ps 

module async_counter (
    input  logic       clk,   // Primary clock input
    input  logic       rst_n, // Active-low asynchronous reset
    output logic [3:0] count  // 4-bit counter output
);

    // Internal wires to interconnect the inverted outputs
    logic [3:0] q_n;

    // Stage 0: Clocked by the external clock signal
    d_ff ff0 (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (q_n[0]),
        .q     (count[0]),
        .q_n   (q_n[0])
    );

    // Stage 1: Clocked by the output of Stage 0
    d_ff ff1 (
        .clk   (count[0]),
        .rst_n (rst_n),
        .d     (q_n[1]),
        .q     (count[1]),
        .q_n   (q_n[1])
    );

    // Stage 2: Clocked by the output of Stage 1
    d_ff ff2 (
        .clk   (count[1]),
        .rst_n (rst_n),
        .d     (q_n[2]),
        .q     (count[2]),
        .q_n   (q_n[2])
    );

    // Stage 3: Clocked by the output of Stage 2
    d_ff ff3 (
        .clk   (count[2]),
        .rst_n (rst_n),
        .d     (q_n[3]),
        .q     (count[3]),
        .q_n   (q_n[3])
    );

endmodule
