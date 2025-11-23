/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: D122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-101
Type: Laboratory
Data: octuber, 29 2025
*/

`timescale 1 ns / 1 ps;

// [ ] Separar arquivos para testes integrados;

/* 
1 - RTL          	-> portas lógicas
2 - Estrutural   	-> instancias 
3 - Comportamental	-> always or initial
*/

// Separar os arquivos

// 1ª Parte do Exercício 2
module mux2(a, b, sel, y);
    input a, b, sel;
    output y;

assign y = sel ? a : b; 

endmodule

// 2ª Parte do Exercício 2
module mux3(
   input [1:0] D, sel,
   output y
);

assign y = sel ? D[0] : D[1]; 

endmodule

//estrutural
module mux_est(a, b, sel, y); 
    input a, b, sel;
    output y;

    wire w1, w2;

    or I1(y,w1,w2);
    and I2(w1,!sel,a);
    and I3(w2, sel,b);

endmodule

module mux_rtl(a, b, sel, y);
    input a, b, sel;
    output y;

    wire n_sel, and1, and2;

    assign n_sel = ~sel;
    assign and1 = a & n_sel;
    assign and2 = sel & b;
    assign y = and1 | and2;

endmodule

// Atividade 3

module mux4_comport(a, b, sel, y); //comportamental 
    input a, b, sel;
    output reg y;

    always @(*) begin
        if(sel == 1'b0)
            y = a;
        else
            y = b;
    end

endmodule
