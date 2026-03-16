/*
Program: CI Digital T2/2025
Class: Circuito Digitais I 
Class-ID: SD122
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-112
Type: Laboratory
Data: november, 20 2025
*/

`timescale 1 ns / 1 ps;

module ula_shift_03 ( // #(parameter WIDTH = 4) (

    input 		[3:0] A, B,
    input 		[2:0] sel, // $clog2(WIDTH)
    output reg	[3:0] resultado
);
    always @(*) begin
        case (sel)
            3'b000: resultado = A & B;       //  AND
            3'b001: resultado = A | B;       //  OR
            3'b010: resultado = ~A;          //  NOT (Apenas ao operando A)
            3'b011: resultado = ~(A & B);    //  NAND
            3'b100: resultado = A + B;       // Soma
            3'b101: resultado = A - B;       // Subtração
            // operacoes novas
            3'b110: resultado = (B < 4) ? A << B : A << 0; 
            // A << ( {WIDTH{(B < 4)}} & B)
            3'b111: resultado = (B < 4) ? A >> B : A >> 0;
            default: resultado = 4'b0000;   //  padrão (zero)
        endcase
    end

endmodule
