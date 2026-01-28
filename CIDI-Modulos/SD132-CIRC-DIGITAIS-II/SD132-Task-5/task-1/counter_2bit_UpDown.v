/*
Program: CI Digital T2/2025
Class: Circuito Digitais II
Class-ID: SD132
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-205
Type: Laboratory
Data: november, 26 2025
*/

`timescale 1 ns / 1 ps

module counter_2bit_UpDown (
    input wire       clk, rst, up,
    output reg [1:0] CNT
);
    
	reg [1:0] current_state, next_state;
	localparam	C0 = 2'b00,
		      	C1 = 2'b01,
		      	C2 = 2'b10,
		      	C3 = 2'b11;

	always @ (posedge clk or negedge rst) begin // posedge rst
		current_state <= (!rst) ? C0 : next_state;
	end

	always @ (current_state or up) begin
		case (current_state)
		    C0     : next_state <= up ? C1 : C3;
		    C1     : next_state <= up ? C2 : C0;
		    C2     : next_state <= up ? C3 : C1;
		    C3     : next_state <= up ? C0 : C2;
		    default: next_state <= C0;
		endcase
	end

	always @ (current_state) begin
		case (current_state)
		    C0     : CNT <= 2'b00;
		    C1     : CNT <= 2'b01;
		    C2     : CNT <= 2'b10;
		    C3     : CNT <= 2'b11;
		    default: CNT <= 2'b00;
		endcase
	end

endmodule

