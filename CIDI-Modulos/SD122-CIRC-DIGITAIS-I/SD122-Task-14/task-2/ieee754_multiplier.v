/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-114
Type:  Testbench
Data: november, 21 2025
*/

`timescale 1 ns / 1 ps;

// [ ] Checar multiplicação
//
module ieee754_multiplier (
    input [31:0] a,
    input [31:0] b,
    output [31:0] result
);
    wire sign;
    wire [7:0] exp_a, exp_b, exp_result;
    wire [23:0] mant_a, mant_b;
    wire [47:0] mant_product;
    
    reg [22:0] mantissa_final;
    reg [7:0] exponent_final;
    reg [47:0] mantissa_norm;

    assign sign = a[31] ^ b[31]; // XOR dos sinais
    
    assign exp_a = a[30:23];
    assign exp_b = b[30:23];
    
    assign mant_a = {1'b1, a[22:0]};
    assign mant_b = {1'b1, b[22:0]};
    
    assign mant_product = mant_a * mant_b;

    always @(*) begin
        if (mant_product[47] == 1) begin
            mantissa_norm = mant_product >> 1;
            exponent_final = exp_a + exp_b - 127 + 1;
        end else begin
            mantissa_norm = mant_product;
            exponent_final = exp_a + exp_b - 127;
        end

        mantissa_final = mantissa_norm[46:24]; 
    end

    assign result = {sign, exponent_final, mantissa_final};

endmodule
