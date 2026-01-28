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

module data_path (
    input sel12, sel21, escrita, clk, reset, carry_in,
    input [2:0] operacao, 
    input [1:0] reg_addr, 
    input [3:0] dados,
    output [3:0] resultado, 
    output carry_out 
);

    wire [3:0] Q_rega, Q_regb, Out_regf; 
    wire [3:0] Rega, Regb, Out_mux; 
    wire we_rega = ~sel12; 
    wire we_regb = sel12; 
    wire en      = sel12; 
    wire  Borrow; 
    
    demux_1x2 demux (
        .in(Out_regf), .sel(sel12),
        .out0(Rega),.out1(Regb)
    );
    
    register_file reg_file (
        .addr(reg_addr), .clk(clk), .data_in(Out_mux), .we(escrita), .reset(reset),
        .data_out(Out_regf)
    );
    
    register_4bits rega (
        .clk(clk),.D(Rega), .rst(reset),.we(we_rega),
        .Q(Q_rega) 
    );
    
    register_4bits regb (
        .clk(clk), .D(Regb), .rst(reset),.we(we_regb),
        .Q(Q_regb) 
    );
    
    mux_2x1_4bits mux(
        .in0(dados), .in1(resultado), .sel(sel21),
        .out(Out_mux)
    );
    
    alu_simples Alu (
        .A(Q_rega), .B(Q_regb),.Bin(1'b0),.Borrow(Borrow), .Cin(carry_in), .sel(operacao),.en(en),
        .Cout(carry_out ), .result(resultado) 
    );

endmodule
