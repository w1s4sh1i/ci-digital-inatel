/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-008
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1ns / 1ps

module reset_sync (
    input              clk, n_rst,
    input        [1:0] D_in,
    output  reg  [1:0] Q_out
);

	reg Q_FF1, Q_FF2, Q_FF3;

	always @(posedge clk, negedge n_rst) begin
		
		if (!n_rst) begin
		    Q_FF1 <= 1'b0;
		end else begin
		    Q_FF1 <= 1'b1;
		end
		 
	end


	always @(posedge clk, negedge n_rst) begin
		if (!n_rst) begin
		    Q_FF2 <= 1'b0;
		end
		else begin
		    Q_FF2 <= Q_FF1;
		end 
	end

	always @(posedge clk, negedge n_rst) begin
		if (!n_rst) begin
		    Q_FF3 <= 1'b0;
		end else begin
		    Q_FF3 <= Q_FF2;
		end
	end

	always @(posedge clk)begin
		if (!Q_FF3) begin
			Q_out <= 1'b0;
		end else begin
			Q_out <= D_in;
		end   
	end

endmodule


