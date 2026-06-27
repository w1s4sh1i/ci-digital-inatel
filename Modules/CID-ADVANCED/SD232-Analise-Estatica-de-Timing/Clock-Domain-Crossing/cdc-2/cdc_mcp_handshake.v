`timescale 1ns / 1ps

module cdc_mcp_handshake #(
	parameter WIDTH = 8
)(
	// Domínio de Origem (Source)
	input               src_clk,
	input               src_arstn,
	// Gatilho para nova transferência
	input               src_valid,   
	input   [WIDTH-1:0] src_data,
	// Indica que o handshake concluiu e aceita novo dado
	output              src_ready,   

	// Domínio de Destino (Destination)
	input               dest_clk,
	input               dest_arstn,
	// Pulso indicando dado válido neste ciclo
	output              reg dest_valid,  
	output  reg [WIDTH-1:0] dest_data
);

	// Sinais Internos
	reg             req_toggle;
	reg [WIDTH-1:0] ff_src;

	// Cadeias de sincronização
	reg [2:0] req_sync; // Sincronizador de Request no Destino
	reg [2:0] ack_sync; // Sincronizador de Acknowledge na Origem

	wire       dest_en;

	// Origem...
	// Controle de prontidão: pronto quando o request enviado for igual ao ack recebido
	assign src_ready = (req_toggle == ack_sync[2]);

	// Lógica de captura de dados e geração do Toggle (Request)
	always @(posedge src_clk or negedge src_arstn) begin
		if (!src_arstn) begin
		    req_toggle <= 1'b0;
		    ff_src     <= {WIDTH{1'b0}};
		end else if (src_valid && src_ready) begin
		    // Inverte estado para sinalizar nova requisição
		    req_toggle <= ~req_toggle; 
		    // Trava o dado no registrador de origem
		    ff_src     <= src_data;    
		end
	end

	// Sincronizador de Retorno (Acknowledge) - 3 estágios
	always @(posedge src_clk or negedge src_arstn) begin
		if (!src_arstn) begin
		    ack_sync <= 3'b000;
		end else begin
		    // Recebe o req_sync[1] (2º estágio) do destino de volta para a origem
		    ack_sync <= {ack_sync[1:0], req_sync[1]}; 
		end
	end

		// Destino...
	// Sincronizador de Ida (Request) - 3 estágios
	always @(posedge dest_clk or negedge dest_arstn) begin
		if (!dest_arstn) begin
		    req_sync <= 3'b000;
		end else begin
		    req_sync <= {req_sync[1:0], req_toggle};
		end
	end

	// Detector de Borda (Edge Detector - equivalente à lógica AND/OR na imagem)
	assign dest_en = req_sync[1] ^ req_sync[2]; 

	// Amostragem do dado (ff_dest)
	always @(posedge dest_clk or negedge dest_arstn) begin
		if (!dest_arstn) begin
		    dest_data  <= {WIDTH{1'b0}};
		    dest_valid <= 1'b0;
		end else begin
		    dest_valid <= dest_en; 
		    if (dest_en) begin
		    	// Amostra de forma segura, o dado já está estável
			dest_data <= ff_src; 
		    end
		    // else...
		end
	end

endmodule
