/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-310)
Type: Laboratory
Data: febuary, 9 2026
*/

`timescale 1 ns / 1 ps

module uart_tx #(parameter WIDTH = 8)(
	input clk, reset, tx_start,
	input [WIDTH-1 : 0] data_in,
	output reg tx, tx_done
);

	// Estados da maquina
	localparam	IDLE 	= 0, 
			START	= 1,
			DATA	= 2,
			STOP	= 3,
			DONE 	= 4,
			CLK_PER_BIT = 16'd5208; // Assumindo 9600 baud rate e 50 MHz clock

	reg load_data, enable_counter, enable_shift, tx_reg;
	reg [2:0] state, next_state;
	reg [2:0] bit_counter;
	reg [WIDTH-1 : 0] shift_reg;
	reg [(WIDTH*2)-1 : 0] clk_counter;

	// Contagem dos ciclos de clock
	always @( posedge clk or posedge reset ) begin
		if (reset) begin
			clk_counter <= 16'b0;
		end
		else if ( enable_counter ) begin
			if ( clk_counter < CLK_PER_BIT - 1) begin
				clk_counter <= clk_counter + 1'b1;
			end else begin
				clk_counter <= 16'b0;
			end
		end
		else
			clk_counter <= 16'b0;
	end

	// Registrador de deslocamento
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			shift_reg <= 8'b0;
			tx_reg <= 1'b0;
		end

		else if (enable_shift) begin
			tx_reg <= shift_reg [ bit_counter ];
		end

		else if (load_data) begin
			shift_reg <= data_in;
			tx_reg <= 1'b0;
		end
		
		// else 
	
	end

	// Logica sequencial : Transicao de estado
	always @( posedge clk or posedge reset ) begin
		if (reset) begin
			state <= IDLE;
		end
		else begin
			state <= next_state;
		end
	end

	// Logica combinacional para determinar o proximo estado
	always @ (*) begin
		next_state <= state;
		// Valor padrao : permanece no mesmo estado

		case (state)
			IDLE : begin
				if (tx_start && ! tx_done) begin
					next_state <= START;
				end
			end

			START : begin
				if ( clk_counter == CLK_PER_BIT - 1) begin
					next_state <= DATA;
				end
			end

			DATA : begin
				if (( bit_counter == 7) && ( clk_counter == CLK_PER_BIT - 1) ) begin
					next_state <= STOP;
					// Ultimo bit de dados recebido
				end
			end

			STOP : begin
				if ( clk_counter == CLK_PER_BIT - 1) begin
					next_state <= DONE;
				end
			end

			DONE : begin
				next_state <= IDLE;
			end

			default : begin
				// Estado de seguranca
				next_state <= IDLE;
			end

		endcase

	end

	always @ (posedge clk or posedge reset) begin
		if (reset) begin
			// Reset de todos os sinais
			tx_done <= 1'b0;
			tx <= 1'b1;
			bit_counter <= 3'b0;
			enable_counter <= 1'b0;
			enable_shift <= 1'b0;
			load_data <= 1'b0;
		end
		else begin
			case ( state )
				IDLE : begin
					tx_done <= 1'b0;
					// Garante que tx_done e limpo
					tx <= 1'b1;
					bit_counter <= 3'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					load_data <= 1'b0;
				end

				START : begin
					tx <= 1'b0;
					tx_done <= 1'b0;
					bit_counter <= 3'b0;
					enable_counter <= 1'b1;
					enable_shift <= 1'b0;
					load_data <= 1'b1;
				end

				DATA : begin
					tx <= tx_reg;
					tx_done <= 1'b0;
					enable_counter <= 1'b1;
					enable_shift <= 1'b1;
					load_data <= 1'b0;
					if (clk_counter == CLK_PER_BIT - 1) begin
						bit_counter <= bit_counter + 1 'b1;
					end
				end

				STOP : begin
					tx <= 1'b1;
					tx_done <= 1'b0;
					bit_counter <= 3'b0;
					enable_counter <= 1'b1;
					enable_shift <= 1'b0;
					load_data <= 1'b0;
				end

				DONE : begin
					tx <= 1'b1;
					tx_done <= 1'b1;
					// Sinaliza que a transmissao foi concluida
					bit_counter <= 3'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					load_data <= 1'b0;
				end

				default : begin
					tx <= 1'b1;
					tx_done <= 1'b0;
					// Garante que tx_done e limpo
					bit_counter <= 3'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					load_data <= 1'b0;
				end

			endcase
		end
	end
endmodule
