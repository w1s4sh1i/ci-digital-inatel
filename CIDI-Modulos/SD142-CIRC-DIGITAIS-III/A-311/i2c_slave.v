/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-311)
Type: Laboratory
Data: febuary, 9 2026
*/

`timescale 1 ns / 1 ps

module i2c_slave #(
	parameter WIDTH = 8
)(

	input clk, reset, scl,         
	/*
	- Clock do sistema
	- Reset do sistema
	- Linha de clock I2C
	*/
	inout sda,         
	// Linha de dados I2C

	input [WIDTH - 1 : 0] data_in,  // Dado a ser enviado pelo escravo

	output reg [WIDTH - 1 : 0] data_out, // Dado recebido
	output reg data_ready, ack_error, start 
	/*
	- Flag indicando dado recebido
	- Flag para indicar erro no ACK do mestre
	- Indica inicio e fim da transmissao
	*/
	);

	// Constantes
	localparam	ADDRESS = 7'b1101010, // 6Ah
			IDLE = 3'b000, 
			ADDR = 3'b001, 
			ACK = 3'b010, 
			READ = 3'b011, 
			WRITE = 3'b100, 
			READ_ACK = 3'b101;

	// Registradores internos
	reg [WIDTH - 1 : 0] shift_reg;  // Registrador de deslocamento para leitura de dados
	reg [2:0] bit_count,  // Contador de bits
		[2:0] state,      // Estado atual da maquina de estados
		[2:0] next_state; // Proximo estado da maquina de estados
	reg	sda_out,          // Controle de saida para SDA
		sda_drive,        // Define se o escravo controla diretamente a linha SDA
		scl_sync,         // Valor sincronizado de SCL
		sda_sync,         // Valor sincronizado de SDA
		scl_last,         // Estado anterior de SCL
		sda_last;         // Estado anterior de SDA

	// Controle bidirecional da linha SDA
	assign sda = (sda_drive) ? sda_out : 1'bz;

	// Sincronizacao de SCL e SDA no clock do sistema
	always @(posedge clk or posedge reset) begin
		if (reset) begin
		  scl_sync <= 1'b1;
		  sda_sync <= 1'b1;
		  scl_last <= 1'b1;
		  sda_last <= 1'b1;
		end
		else begin
		  scl_sync <= scl;
		  sda_sync <= sda;
		  scl_last <= scl_sync;
		  sda_last <= sda_sync;
		end
	end

  // Deteccao de borda de start/stop
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      start <= 1'b0;
    end 
    else begin
      if (!start && scl_sync && sda_last && !sda_sync) begin
        // Condicao de start
        start <= 1'b1;
      end
      else if (start && scl_sync && !sda_last && sda_sync) begin
        // Condicao de stop
        start <= 1'b0;
      end
      // else
    end
  end

  // Logica sequencial para o estado atual
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= IDLE;
    end
    else begin
      state <= next_state;
    end
  end

  // Logica combinacional para o proximo estado
	always @(*) begin
		// Estados padrao
		next_state = state;

		if (!start) begin
			next_state = IDLE;
		end
		else begin
			case (state)
				
				// Verifica se o iniciou alguma solicitação e o valor do último SCL é diferente do atual
				IDLE: begin 
				  if (start && scl_last && !scl_sync)
				    next_state = ADDR;
				  // else  
				end
				
				// Verifica se o valor do último SCL é diferente do atual e se o foram enviado os 7 bits de dado
				ADDR: begin 
				  if (scl_last && !scl_sync) begin
				    if (bit_count == 0) begin
				      next_state = ACK;
				    end
				    // else 
				  end
				  // else
				end
				
				// Verifica se o valor do último SCL é diferente do atual e se o endereço enviado é igual ao endereço do SLAVE
				ACK: begin 
				  if (scl_last && !scl_sync) begin
				    if (shift_reg[7:1] == ADDRESS) begin
				      next_state = (shift_reg[0] == 0) ? READ : WRITE;
				    end
				    else begin
				      next_state = IDLE; // Endereco invalido
				    end
				  end
				end
				
				//Verifica se o valor do último SCL é diferente do atual e se os 7 bits do endereço da leitura foram enviados
				READ: begin 
				  if (scl_last && !scl_sync) begin
				    if (bit_count == 0) begin
				      next_state = ACK;
				    end
				    // else
				  end
				  // else
				end
				
				//Verifica se o valor do último SCL é diferente do atual e se os 7 bits do endereço de escrita foram enviados
				WRITE: begin  
				  if (scl_last && !scl_sync)
				  begin
				    if (bit_count == 0)
				    begin
				      next_state = READ_ACK;
				    end
				  end
				end

				// //Verifica se o valor do último SCL é diferente do atual e retorna para o IDLE para esperar outra solicitação
				READ_ACK: begin 
				  if (scl_last && !scl_sync)
				  begin
				    next_state = IDLE;
				  end
				end

				default:
				  next_state = IDLE;
			endcase
		end
	end

	// Logica combinacional e de saida
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			bit_count <= 7;
			shift_reg <= 8'b0;
			data_ready <= 1'b0;
			ack_error <= 1'b0;
			data_out <= 1'b0;
			sda_drive <= 1'b0;
			sda_out <= 1'b1;
		end
    	else begin
			case (state)
			  	IDLE: begin
				  bit_count <= 7;
				  shift_reg <= 8'b0;
				  data_ready <= 1'b0;
				  ack_error <= 1'b0;
				  data_out <= 1'b0;
				  sda_drive <= 1'b0;
				  sda_out <= 1'b1;
				end

				ADDR: begin // Decrementa o contador de bit e armazena o valor do sda
				  if (!scl_last && scl_sync)
				    shift_reg[bit_count] <= sda_sync;
				  if (scl_last && !scl_sync)
				    bit_count <= bit_count - 1'd1;
				end

				ACK: begin // Confere se o valor armazenado no shift_reg é igual ao endereço do slave
				  sda_drive <= 1'b1;
				  sda_out <= 1'b0;
				  if (scl_last && !scl_sync) begin
				    if (shift_reg[7:1] == ADDRESS) begin
				      bit_count <= 7;
				    end
				    // else
				  end
				  // else
				end

				READ: begin
					sda_drive <= 1'b0;
					if (!scl_last && scl_sync) begin
						shift_reg[bit_count] <= sda_sync;
						if (bit_count == 0) begin
							data_out <= shift_reg;
							data_ready <= 1'b1;
						end
						// else
					end
					if (scl_last && !scl_sync)
						bit_count <= bit_count - 1;
					// else        
				end

				WRITE: begin
					sda_drive <= 1;
					sda_out <= data_in[bit_count];
					if (scl_last && !scl_sync) begin
						bit_count <= bit_count - 1;
					end
					// else
				end

				READ_ACK: begin
					sda_drive <= 1'b0;
					if (!scl_last && scl_sync) begin
						ack_error <= (sda_sync != 1'b0);
					end
					// else
				end
			endcase
		end
	end
endmodule

Pense em um jogo que você ama muito jogar e pelo seu Game Designer. Por que vocÇe escolheu esse jogo ? Cute sua mecânicas, dinâmicas, personagens, desafios e o que mais desejar. Use imagens, e/ou videos no seu slide.
