`timescale 1ns / 1ps

module d_ff (
    input  logic clk,
    input  logic rst_n,
    input  logic d,
    output logic q,
    output logic q_n
);

    always_ff @(negedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            q <= d;
        end
    end

    assign q_n = ~q;

endmodule

