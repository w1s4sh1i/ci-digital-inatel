/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-209
Type: Laboratory
Data: november, 26 2025
*/

`timescale 1 ns / 1ps

module divisor_rest #(parameter N = 4)(
    
    input clk, start, rst, 
    input [N   : 0] divisor,
    input [N-1 : 0] dividendo,
    
    output reg [N-1 : 0] quociente, resto,
    output reg [  2 : 0] current_state
);
	integer i;
	
	reg [2:0] next_state;
	
	localparam 			P = 2 * N;
	localparam [3:0]	S0 = 3'd0, 
						S1 = 3'd1, 
						S2 = 3'd2, 
						S3 = 3'd3, 
						S4 = 3'd4, 
						S5 = 3'd5, 
						S6 = 3'd6, 
						S7 = 3'd7;
			
	// Preenchimento do estados
	// initial ... end
	
	reg [N   : 0] A, M;
	reg [P   : 0] AQ;
	reg [N-1 : 0] Q; // q_reg, r_reg;
	
	always @ (posedge clk or posedge rst) begin
		current_state <= rst ? S0 : next_state;
	end

	// [ ] Alteração na entrar....
	always @ (current_state or start) begin // modificar dependência

		case (current_state)

		    S0	: next_state = start ? S1 : S0;
		    S1	: next_state = S2; 
		    S2	: next_state = S3; 
		    S3	: next_state = S4;
		    S4	: next_state = AQ[P] ? S6 : S5;
		    S5	: next_state = (i==0) ? S7 : S2;
		    S6	: next_state = (i==0) ? S7 : S2;
		    S7	: next_state = S0; // << !
		    default: next_state = S0;

		endcase
	end

	always @ (current_state) begin
	
		case (current_state)
		    S0     : begin
		        A = {N{1'b0}};
		        M = {N{1'b0}}; 
		        AQ = {P{1'b0}};
		        i = 0;
			quociente = rst ? {N{1'b0}} : quociente; 
			resto = rst ? {N{1'b0}} : resto; 
		    end
		    S1     : begin
		        M = divisor;
		        Q = dividendo;
		        i = N-1;
		        AQ = {A,Q};
		    end
		    S2     : begin
		        AQ = AQ << 1;
		    end
		    S3     : begin
		        AQ[P : N] =  AQ[P : N] - M;
		    end
		    S4     : begin
		        AQ[P : N] =  (AQ[P]) ? AQ[P : N] + M : AQ[P : N];
		    end
		    S5     : begin
		         AQ[0] = 1'b1;
		         i = i-1;
		    end
		    S6     :  begin
		        AQ[0] = 1'b0;
		        i = i-1;
		    end
		    S7     : begin  
				quociente = AQ[N-1	: 0];
		    	resto	  = AQ[P	: N];
		    end     
		    default: AQ ={N{1'b0}};
		endcase
	end
	
endmodule
