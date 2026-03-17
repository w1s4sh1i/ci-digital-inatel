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

module uart_rx #(parameter WIDTH = 8)(
    input clk, reset, rx,
    output reg rx_done,
    output reg [WIDTH - 1 : 0] data_out
);

	// Estados da maquina
	localparam	IDLE 	= 0, 
				START	= 1,
				DATA	= 2,
				STOP 	= 3,
				DONE 	= 4,
				ERROR 	= 5,
				// Assumindo 9600 baud rate e 50 MHz clock
				CLK_PER_BIT = 16'd5208; 

	reg rx_stop, enable_counter, enable_shift, load_data;
	reg [2:0] state, next_state;
	reg [2:0] bit_counter;
	reg [WIDTH - 1 : 0] shift_reg;
	reg [15:0] clk_counter;

	// Contagem dos ciclos de clock
	always @( posedge clk or posedge reset ) begin
		if (reset) begin
			clk_counter <= 16'b0;
		end
		else if (enable_counter) begin
			if (clk_counter < CLK_PER_BIT - 1) begin
				clk_counter <= clk_counter + 1'b1;
			end
			else begin
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
			data_out  <= 8'b0;
		end
		else if (enable_shift) begin
			shift_reg [ bit_counter ] <= rx;
		end
		else if (load_data) begin
			data_out <= shift_reg;
		end
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
		
		// Valor padrao : permanece no mesmo estado
		next_state <= state;
		
		case (state)
			IDLE : begin
				if (rx == 0) begin
					// Detecta o bit de inicio
					next_state <= START ;
				end
			end

			START : begin
				if (clk_counter == CLK_PER_BIT - 1) begin
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
				if (clk_counter == CLK_PER_BIT - 1) begin
					if ( rx_stop == 1) begin // Verifica o bit de parada
						next_state <= DONE;
					end
					else begin
						next_state <= ERROR; // Erro na recepcao no STOP bit
					end
				end
				// else 
			end

			DONE : begin
				next_state <= IDLE;
			end

			ERROR : begin
				// [ ] Define error state mensage; 
				next_state <= IDLE ;
			end

			default : begin
				// Estado de seguranca
				next_state <= IDLE ;
			end

		endcase
	end

	// Logica sequencial : Amostragem dos dados
	always @( posedge clk or posedge reset ) begin
		if (reset) begin
			// Reset de todos os sinais
			rx_done <= 1'b0;
			rx_stop <= 1'b0;
			enable_counter <= 1'b0;
			enable_shift <= 1'b0; 
			bit_counter <= 3'b0;
			load_data <= 1'b0;
		end
		else begin
			case (state)
				IDLE : begin
				  rx_done <= 1'b0;
				  rx_stop <= 1'b0;
				  enable_counter <= 1'b0;
				  enable_shift <= 1'b0;
				  bit_counter <= 3'b0;
				  load_data <= 1'b0;
				end

				START : begin
				  rx_done <= 1'b0;
				  rx_stop <= 1'b0;
				  enable_counter <= 1'b1;
				  enable_shift <= 1'b0;
				  bit_counter <= 3'b0;
				  load_data <= 1'b0;
				end

				DATA : begin
				  rx_done <= 1'b0;
				  rx_stop <= 1'b0;
				  enable_counter <= 1'b1;
				  load_data <= 1'b0;
				  enable_shift <= ( clk_counter == CLK_PER_BIT / 2) ;
				  if ( clk_counter == CLK_PER_BIT - 1) begin
					bit_counter <= bit_counter + 1 'b1;
				  end
				  if ((bit_counter == 7) && (clk_counter == CLK_PER_BIT - 1)) begin
					load_data <= 1;
				  end
				end

				STOP : begin
					enable_counter <= 1'b1;
					enable_shift <= 1'b0;
					bit_counter <= 3'b0;
					load_data <= 1'b0;
					
					if ( clk_counter == CLK_PER_BIT - 1) begin
						rx_done <= 1'b1;
				  	end
				  	
				  	if (( clk_counter == CLK_PER_BIT / 2) && rx) begin
						rx_stop <= 1'b1;
				  	end
				  	 
				end

				DONE : begin
					rx_done <= 1'b0;
					rx_stop <= 1'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					bit_counter <= 3'b0;
					load_data <= 1'b0;
				end

				ERROR : begin
					rx_done <= 1'b0;
					rx_stop <= 1'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					bit_counter <= 3'b0;
					load_data <= 1'b0;
				end

				default : begin
					rx_done <= 1'b0;
					rx_stop <= 1'b0;
					enable_counter <= 1'b0;
					enable_shift <= 1'b0;
					bit_counter <= 3'b0;
					load_data <= 1'b0;
				end
			endcase
		end
	end

endmodule
