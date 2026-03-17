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

/* 
TODO:
[X] O primeiro byte enviado é o endereço (7 bits) incrementado de um bit R/W. O segundo byte 
enviado é o valor introduzido para o ponteiro de endereço interno do slave.

[X] Para ler um registo específico no slave, o Master deve definir o ponteiro de endereço 
interno do slave, escrevendo o endereço do slave anexado com o bit R/W alto. O próximo byte 
enviado é o valor que o ponteiro de endereço interno deve ter.
Agora o Master deve enviar um outro start porque o Master vai ler desta vez.
*/

`timescale 1 ns / 1 ps

module i2c_master #(
	parameter WIDTH = 8
)(    
	/*
	- Clock principal;
	- Reset sincrono;
	- Sinal para iniciar a transmissao;
	*/

	input clk, reset, start,

	// Dados a serem enviados
	input [WIDTH-1 : 0] data_in,   
	// Endereco do escravo (7 bits)
	input [WIDTH-2 : 0] slave_addr,

	/*
	- Modo: 0 = escrita, 1 = leitura
	- ACK a ser enviado pelo mestre
	*/
	input rw, ack_master, 

	/*
	- Linha do clock I2C
	- Linha de dados I2C (bidirecional)
	*/

	inout scl, sda,
	  
	/*
	- Indica o fim da transmissao
	 Dados a serem recebidos
	*/
	output done,
	output [WIDTH-1 : 0] data_slave
);

	/*
	Parametros para o divisor de clock (ajustar para a frequencia desejada)
	- Frequencia do clock principal (100 MHz);
	- Frequencia do SCL desejada (5 MHz);
	- Contador para gerar SCL;
	*/

	localparam	CLK_FREQ = 100_000_000, 
				SCL_FREQ = 5_000_000,     
				SCL_DIV = CLK_FREQ / (2 * SCL_FREQ); 

	/* 
	Registradores internos:
	- Contador para dividir o clock principal;
	- Estado atual e proximo estado da FSM; 
	- indice do bit sendo transmitido (0 a 7);
	- Registrador de deslocamento para transmissao;
	> Valor de saida para a linha:
	- SDA;
	- SCL;
	> Controle de direcao do (1 = dirigir, 0 = alta impedancia):
	- SDA;
	- SCL.
	- Identifica que houve uma solicitacao de inicio;
	- Estado anterior de SCL;
	- Checa ACK recebido pelo escravo;
	*/
	reg [WIDTH*2-1 : 0] clk_counter;      
	reg [2:0] state, next_state, bit_index;     
	reg [WIDTH-1 : 0] shift_reg;
	reg sda_out, scl_out, sda_dir, scl_dir, start_id, scl_last, check_ack_slave;         

	// Conexao tri-state para SDA e SCL
	assign sda = sda_dir ? sda_out : 1'bz;
	assign scl = scl_dir ? scl_out : 1'bz;

	// Definicao de estados 3'b000 - 3'b111 
	localparam	IDLE         = 3'b000,  // Estado ocioso
				START        = 3'b001,  // Geracao da condicao de inicio
				SEND_BIT     = 3'b010,  // Envio de bits (endereco ou dados)
				CHECK_ACK    = 3'b011,  // Verificacao do ACK
				READ_SLAVE   = 3'b100,  // Le dados enviados pelo escravo
				WRITE_ACK    = 3'b101,  // Manda ACK para escravo
				STOP         = 3'b110,  // Geracao da condicao de parada
				DONE         = 3'b111;  // Fim da transmissao

	// Geracao do clock SCL
	always @(posedge clk or posedge reset)  begin
		if (reset) begin
		  clk_counter <= {WIDTH*2-1{1'b0}};
		  // Clock SCL comeca em alto
		  scl_out <= 1'b1;
		end
		else begin
		  if (clk_counter == SCL_DIV - 1) begin // Comparação para realizar a divisão de clock e assim gera o sinal SCL
			clk_counter <= {WIDTH*2-1{1'b0}};
			scl_out <= ~ scl_out;   // Alterna o estado do SCL
		  end
		  else begin
			clk_counter <= clk_counter + 1;
		  end
		end
	end

	// Sincronizacao de SCL e SDA no clock do sistema
	always @(posedge clk or posedge reset) begin
		if (reset) begin
		  scl_last <= 1'b1;
		end
		else begin
		  scl_last <= scl_out; //
		end
	end

	// Identifica inicio do controle
	always @(posedge clk or posedge reset) begin
		if (reset) begin
		  start_id <= 1'b0; // Como não houve solicitações é inicializado para 0
		end
		else begin
		  if (start == 1) begin
			start_id <= 1; // Incrementação do seu valor já que ocorreu solicitações
		  end
		  else if (start_id == 1 && state != IDLE) begin
			start_id <= 1'b0; // Retorna para 0 pois está tratando uma solicitação
		  end
		end
	end

	// Logica sequencial: Transicao de estado
	always @(posedge clk or posedge reset) begin
		if (reset) begin
		  state <= IDLE;
		end
		else begin
		  state <= next_state;
		end
	end

	// Logica combinacional: Proximo estado
	always @(*) begin
		// Definir proximo estado como padrao
		next_state = state;
		case (state)
			IDLE: begin
				if (start_id) begin // Se acontecer uma solicitação modifica de estado
				  next_state = START;
				end
				// else
			end

		  	START: begin // Verifica se o último valor de saída do SCL é diferente do próximo, sinalizando assim que o Endereço está sendo enviado
				if (scl_last && !scl_out)
					// Muda de estado na borda de descida
					next_state = SEND_BIT;  
		  		// else
		  	end

			SEND_BIT: begin // Verifica se o último valor de saída do SCL é diferente do próximo e o bit sendo transmito é o 7º bit
				if (scl_last && !scl_out && bit_index == 3'b000) begin
					next_state = CHECK_ACK;
				end
			end

			// Verifica se o último valor de saída do SCL é diferente do próximo e se o ACK foi 
			// enviado pelo slave se for escrita ira para o estado SEND_BIT e se for leitura para o estado READ_BIT
			CHECK_ACK: begin 
				if (scl_last && !scl_out) begin
					if (check_ack_slave) begin // ACK recebido
						if (rw == 1'b0) begin
							next_state = SEND_BIT;
						end
						else begin
							next_state = READ_SLAVE;
						end
					end
				  	else begin
						next_state = STOP; // NACK ou erro
				  	end
				end
				// else
			end

			READ_SLAVE: begin 
			// Verifica se o último valor de saída do SCL é diferente do próximo e o bit sendo transmito é o 7º bit
				if (scl_last && !scl_out && bit_index == 3'b000)
			  		next_state = WRITE_ACK;
			  	// else 	
		  	end

			WRITE_ACK: begin 
			// Verifica se o último valor de saída do SCL é diferente do próximo se o bit ACK for encontrado vai para o estado READ_SLAVE
				if (scl_last && !scl_out) begin
					if (ack_master == 1'b0) begin
						next_state = READ_SLAVE;
					end
					else begin
						next_state = STOP;
					end
				end
				// else 
			end

			STOP: begin 
			// Verifica se o último valor de saída do SCL é diferente do próximo e modifica para o estado DONE
				if (scl_last && !scl_out)
					next_state = DONE;
			end

			DONE: begin 
			// Verifica se o último valor de saída do SCL é diferente do próximo e retorna para o IDLE para aguardar outra solicitação
				if (scl_last && !scl_out)
			  		next_state = IDLE;
			end
			
			default:
				next_state = IDLE;
		endcase
	end

	// Logica sequencial: Atualizacao dos sinais
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			// Inicializacao em caso de reset
			sda_out <= 1'b1;      // SDA comeca em nivel alto
			sda_dir <= 1'b0;      // SDA em alta impedancia
			scl_dir <= 1'b0;      // SCL inicialmente desativado
			done <= 1'b0;         // Transmissao nao concluida
			check_ack_slave <= 1'b0;
			shift_reg <= 8'b0; 
			bit_index <= 3'b111;
			data_slave <= 8'b0;
		end
		else begin
			case (state)
				IDLE: begin
				  // Estado ocioso: Aguardando o sinal de inicio
				  sda_out <= 1'b1;      // SDA comeca em nivel alto
				  sda_dir <= 1'b0;      // SDA em alta impedancia
				  scl_dir <= 1'b0;      // SCL inicialmente desativado
				  done <= 1'b0;         // Transmissao nao concluida
				  check_ack_slave <= 1'b0;
				  shift_reg <= 8'b0;
				  bit_index <= 3'b111;
				  data_slave <= 8'b0;
				end

				START: begin
				  // Condicao de inicio: SDA vai para baixo enquanto SCL esta alto
				  if (scl_out == 1'b1) begin
					sda_out <= 1'b0;
				  end
				  sda_dir <= 1'b1; // Controla a linha SDA
				  scl_dir <= 1'b1; // Controla a linha SCL
				  shift_reg <= {slave_addr, rw}; // Combina endereco e RW no registrador de deslocamento
				  bit_index <= 7; // Configura o indice para 8 bits (endereco + RW)
				end

				SEND_BIT: begin
				  	sda_out <= shift_reg[bit_index];
					sda_dir <= 1; // Controla a linha SDA
					if (scl_last && !scl_out) begin
						if (bit_index > 3'b000) begin
							bit_index <= bit_index - 1'b1; // Proximo bit
						end
				  	end
				end

				CHECK_ACK: begin
				  sda_dir <= 1'b0; // Libera a linha SDA para o receptor
				  bit_index <= 3'b111;
				  if (!scl_last && scl_out) begin
					if (sda == 1'b0) begin // ACK recebido
						check_ack_slave <= 1'b1;
						if (rw == 0)
							shift_reg <= data_in;
						// else
					end
					else begin
					  check_ack_slave <= 1'b0; // NACK ou erro
					end
				  end
				  else if (scl_last && !scl_out) begin
					check_ack_slave <= 1'b0;
				  end
				end

				READ_SLAVE: begin
				  sda_dir <= 1'b0; // Libera a linha SDA
				  if (!scl_last && scl_out)
					data_slave[bit_index] <= sda;
				  if (scl_last && !scl_out) begin
					if (bit_index > 3'b000) begin
					  bit_index <= bit_index - 1'b1; // Proximo bit
					end
					// else
				  end
				end

				WRITE_ACK: begin
				  sda_dir <= 1'b1;
				  bit_index <= 3'b111;
				  sda_out <= ack_master;
				end

				STOP: begin
				  // Condicao de parada: SDA vai para alto enquanto SCL esta alto
				  //sda_dir <= 1; // Coloca a linha para condicao de parada
				  if (scl_out == 1'b0 && next_state == STOP) begin
					sda_dir <= 1'b1; // Coloca a linha para condicao de parada
					sda_out <= 1'b0;
				  end
				  else if (scl_out == 1'b1) begin
					sda_out <= 1'b1;
					sda_dir <= 1'b0; // Libera a linha SDA
				  end
				  // else 
				end

				DONE: begin
					done 	<= 1'b1;
					sda_out <= 1'b1;
					sda_dir <= 1'b0; // Libera a linha SDA
					scl_dir <= 1'b0; // Libera a linha SCL
				end
			endcase
		end
	end
	
endmodule
