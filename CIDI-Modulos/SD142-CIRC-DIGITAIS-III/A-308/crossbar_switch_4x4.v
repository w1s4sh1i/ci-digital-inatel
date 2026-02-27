/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-305 (A-308)
Type: Laboratory
Data: febuary, 6 2026
    Questions:
    1 - Eles se diferenciam na quantidade de caminhos disponiveis de suas interconecções. 
    2 - Tratar solicitações simultâneas a um recurso compartilhado. 
    3 - Solicitações de duas entradas para a mesmo recurso em uma chamada não são possiveis.
*/
module crossbar_switch_4x4 #(parameter WIDTH = 8)(
    input	[1:0] select, 
    // Sinal de controlede 2 bits para selecionar a conexão
    input	[WIDTH - 1 : 0] in1, in2, in3, in4, // Entradas de 8 bits
    output	[WIDTH - 1 : 0] out1, out2, out3, out4 // Saídas de 8 bits
);

	always @(*) begin
		// Conexão da entrada para a saída baseada no sinal de seleção
		// Estratégia circular 1234, 2341, 3412, 4123 ... + (select + 1) ... 
		case ( select )
			2'b00 : begin
				out1 = in1;
				out2 = in2;
				out3 = in3;
				out4 = in4;
			end
			2'b01 : begin
				out1 = in2;
				out2 = in3;
				out3 = in4;
				out4 = in1;
			end
			2'b10 : begin
				out1 = in3;
				out2 = in4;
				out3 = in1;
				out4 = in2;
			end
			2'b11 : begin
				out1 = in4;
				out2 = in2;
				out3 = in1;
				out4 = in3;
			end
			default: begin
				// Set default - inicial config;
				out1 = {WIDTH{1'b0}};
				out2 = {WIDTH{1'b0}};
				out3 = {WIDTH{1'b0}};
				out4 = {WIDTH{1'b0}};
			end
		endcase
	end

endmodule
