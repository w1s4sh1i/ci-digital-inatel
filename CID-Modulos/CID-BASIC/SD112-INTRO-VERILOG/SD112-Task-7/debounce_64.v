/*
Program: CI Digital T2/2025
Class: Introdução à Verilog  
Class-ID: SD112
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-007
Type: Laboratory
Data: octuber, 17 2025
*/

// `timescale 1 ns / 1 ps;

// Atualizar testes para validação de parâmetros

module debounce_64 ( // #(parameter )(
    input  clk,
    input  noisy_in,
    // input reset,
    output reg  clean_out
);
    reg [1:0] sync;	// sincronizador de entrada
    reg [4:0] counter;	// contador de 5 bits (0–63) 5'b11111
    reg stable_state;	// Alterar valor inicial

    always @(posedge clk) begin
        
        // Etapa 1: sincroniza o sinal de entrada
        sync[0] <= noisy_in; // pulso de clock up
        sync[1] <= sync[0];

        // Etapa 2: verifica se o sinal mudou
        // Reestruturar lógica. 
        if (sync[1] != stable_state) 
        	counter <= counter + 1;
        else
			counter <= 5'b00000;
        
		// Etapa 3: se o sinal permaneceu diferente por 64 clocks, muda o estado
        if (counter == 5'd63) // 5'b11111; & counter
            stable_state <= sync[1];

        // Saída limpa
        clean_out <= stable_state;
    end
    
endmodule
