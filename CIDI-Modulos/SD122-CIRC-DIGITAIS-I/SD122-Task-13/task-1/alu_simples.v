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

module alu_simples (
    input  		[3:0] 	A, B,
    input  		[2:0] 	sel,
    input        		Cin, en,  
    input        		Bin,   
    output reg	[3:0] 	result,
    output reg      	Cout,
	output reg      	Borrow
);

always @(*) begin

    if (en) begin
        
        Cout   = 1'b0;
        Borrow = 1'b0;
        result = 4'b0000;

        case (sel)
            3'b000: result = A & B;
            3'b001: result = ~A;
            3'b010: result = A | B;
            3'b011: result = ~(A & B);

            3'b100: begin
                {Cout,result} = A + B + Cin;
            end

            3'b101: begin
                {Borrow,result} = A - B - Bin;
            end

            3'b110: begin
                result = A << (B < 4 ? B : 0);
            end

            3'b111: begin
                result = A >> (B < 4 ? B : 0);
            end
        endcase
    end
    else begin
    Cout   = 1'b0;
    Borrow = 1'b0;
    result = 4'b0000;
    end
end

endmodule
