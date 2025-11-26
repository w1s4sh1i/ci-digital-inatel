/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-208
Type: Laboratory-Example
Data: november, 26 2025
*/

`timescale 1 ns / 1 ps;

module mult4x4 ( // #(paramter N = 4, M = 4)( 
	input clk,
	input St,
	input [3:0] Mplier, // Multiplicador (4)
	input [3:0] Mcand,  // Multiplicando (4)
	output Done,
	output reg [8:0] ACC // Acumulador (produto parcial + multiplicador)
);
	reg [3:0] State;
	wire M; 
	
	// Bit menos significativo do ACC
	assign M = ACC[0];
	
	// Estado final indica conclusão
	assign Done = (State == 9) ? 1'b1 : 1'b0;
	
	initial begin
		State = 4'd0;
		ACC = 9'd0;
	end	

	always @(posedge clk) begin
		case (State)
			// Estado inicial
			4'd0: begin
				if (St) begin
					ACC[8:4] <= 5'b00000;
					ACC[3:0] <= Mplier;
					State <= 4'd1;
				end
			end

			// Estados que testam M e somam ou não
			4'd1, 4'd3, 4'd5, 4'd7: begin 

				if (M == 1'b1) begin
					ACC[8:4] <= {1'b0, ACC[7:4]} + Mcand;
					State <= State + 1;
				end else begin
					// Shift right ACC
					ACC <= {1'b0, ACC[8:1]}; 
					State <= State + 2;
				end
			end
		
			// Estados de shift
			4'd2, 4'd4, 4'd6, 4'd8: begin 
				ACC <= {1'b0, ACC[8:1]};
				State <= State + 1;
			end
		
			// Fim
			4'd9: begin 
				State <= 4'd0;
			end
		endcase
	end 
	
endmodule

