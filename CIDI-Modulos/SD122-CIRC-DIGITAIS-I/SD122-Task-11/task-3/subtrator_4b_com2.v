/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-111
Type: Laboratory
Data: november, 19 2025
*/

`timescale 1 ns / 1 ps;

// [ ] Avaliar condição de Bin e Bout

module subtrator_4b (
    input [3:0] A, B,
    input cin, // !
    output [3:0] sum,
    output cout
);

    wire [3:0] B_comp;
    wire carry_out;

    // Complemento de 2 de B
    // [ ] Analisar implementação e resultados.
    assign B_comp = ~B + 4'd1; // !

    // Somador de 4 bits
    adder #(4) UUT (
        .a(A), .b(B_comp),
        .cin(cin), .sum(sum),
        .cout(carry_out)
    );

    assign cout = carry_out;

endmodule

// Usar 2 substrator instanciado
module adder #(parameter N = 4)(
    input  [N-1:0] 	a, b, 
    input 		cin,
    output [N-1:0]	sum, 
    output cout
);
    assign sum = a ^ b ^ cin;
    assign cout = (a & b) | (cin & ( a ^ b));

endmodule

module subtrator_full ( // #(paramater WIDTH = 4) (
    input A, B, BorrowIn ,
    output reg D, BorrowOut
);
    always @(*) begin
    	D <= A ^ B ^ BorrowIn;
    	BorrowOut <= (~A & B) ? 1'b1 : 
    				 (~(A ^ B) & BorrowIn) ? 1'b1: 1'b0; // X or Y 
    end
endmodule
