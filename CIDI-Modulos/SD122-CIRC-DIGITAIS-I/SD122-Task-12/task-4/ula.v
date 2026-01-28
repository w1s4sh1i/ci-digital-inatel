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

module ula (
    input  		[3:0]	A, B,
    input				carry_in,
    input  		[2:0]	seletor,
    output reg	[3:0]	resultado,
    output reg			carry_out, 
    output 				Z
);
    always @(*) begin
        // Resetando os sinais de saída
        carry_out = 1'b0;
        resultado = 4'b0000;

        // Operações baseadas no seletor
        case (seletor)
            3'b000: resultado = A & B;    // AND
            3'b001: resultado = A | B;    // OR
            3'b010: resultado = ~A;       // NOT A
            3'b011: resultado = ~(A & B); // NAND
            3'b100: begin                 // Soma
                {carry_out, resultado} = A + B + carry_in;  // Soma com carry
            	end
            3'b101: begin                 // Subtração
                {carry_out, resultado} = {1'b0, A} - {1'b0, B} - carry_in; 
                // Subtração com carry
                carry_out = ~carry_out;   
            	end
            default: resultado = {4{1'b0}}; // Caso padrão (resultado zero)
        endcase
	end
    
    assign Z = resultado==0; 
    
endmodule
