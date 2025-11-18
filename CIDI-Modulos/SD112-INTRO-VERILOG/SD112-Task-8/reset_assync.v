/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-008
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1ns / 1ps

module sync_FF( 
    input D,
    input clk,
    input rst,
    output reg Q
);    

    always @(posedge clk or posedge rst) begin
        Q <= (!rst) ? 1'b0 : D;
    end
    
endmodule

module reset_async ( 
    input vdd, clk, nrest,
    output out
);
    wire q_ff1, q_ff2;

    sync_FF sync_FF1(
        .D(vdd), .clk(clk), .rst(nrest),
        .Q(q_ff1)
    );

    sync_FF sync_FF2(
        .D(q_ff1), .clk(clk), .rst(nrest),
        .Q(q_ff2)
    );

    sync_FF sync_FF3(
        .D(q_ff2), .clk(clk), .rst(nrest),
        .Q(out)
    );
    
endmodule

module top_module(
    input  vdd, clk, nrst_in,
    input  D, // [:0] D, configurar para n bits 
    output Q
);    
    wire bg_wire;

    reset_async r_sync(
        .vdd(vdd), .clk(clk), .nrest(nrst_in), 
        .out(bg_wire)
    );

    sync_FF syncOUT_FF(
        .D(D), .clk(clk), .rst(bg_wire),
        .Q(Q)
    );

endmodule
