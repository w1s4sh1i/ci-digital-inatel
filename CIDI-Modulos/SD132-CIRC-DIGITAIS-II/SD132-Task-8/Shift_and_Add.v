/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-208
Type: Laboratory
Data: november, 29 2025
*/

`timescale 1 ns / 1 ps

module Shift_and_Add #(parameter N = 4) (
    input 				clk, St,
    input  		[N-1:0]	Mplier, Mcand,
    output  			K,
    output reg	[2*N:0] ACC 
);
    
    reg [N-1:0] State;
    wire M; // Bit menos significativo do ACC
    assign M = ACC[0];
    
    // Final state
    assign K = (State == 2*N+1) ? 1'b1 : 1'b0;
    
    initial begin
		State = 1'b0;
		ACC = 1'b0;
    end

    always @(posedge clk) begin

           if (State == 0) begin
                if (St) begin
                    ACC[2*N : N] <={N+1{1'b0}};
                    ACC[N-1 : 0] <= Mplier;
                    State <= 1'b1;
                end 
           end else
            if (State%2 != 0 && State != 2*N+1) begin
                if (M == 1'b1) begin
		            ACC[2*N:N] <= {1'b0, ACC[2*N-1:N]} + Mcand;
		            State <= State + 1'b1;
                end else begin
		            ACC <= {1'b0, ACC[2*N:1]}; // Shift right ACC
		            State <= State + 2;
                end
            end else
            if (State % 2 == 0 && State != 2*N+1) begin
                ACC <= {1'b0, ACC[2*N : 1]};
                State <= State + 1'b1;
            end 
            else begin
                State <= 1'b0; 
            end

    end
endmodule
