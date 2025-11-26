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

// [ ] Realizar análise de testes integrados;

/* 
1 - RTL          	-> portas lógicas
2 - Estrutural   	-> instancias 
3 - Comportamental	-> always or initial
*/

// Atividade 3
//4 Comportamental

module mux4_comport (  
    input a, b, sel,
    output reg y
);
    always @(*) begin
    	
    	//y = (sel) ? a : b;
        if (sel == 1'b1)
            y <= a;
        else
            y <= b;
    end

endmodule
