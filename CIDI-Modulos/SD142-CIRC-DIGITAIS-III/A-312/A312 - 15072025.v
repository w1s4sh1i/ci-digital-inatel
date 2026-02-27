/*
Program: CI Digital T2/2025
Class: Circuito Digitais III
Class-ID: SD142
Advisor: Felipe Rocha 
Advisor-Contact: felipef.rocha@inatel.br
Institute: INATEL - Santa Rita do Sapucaí / MG  
Development: André Bezerra 
Student-Contact: andrefrbezerra@gmail.com
Task-ID: A-306 (A-312)
Type: Testbench
Data: febuary, 9 2026
*/

`timescale 1ns / 1ps

module spi_master #(
    parameter integer CLK_FREQ = 50000000,   // Frequência do clock do sistema (em Hz)
    parameter integer SCLK_FREQ = 1000000    // Frequência desejada do clock SPI (em Hz)
)(
    input wire clk,             // Clock do sistema
    input wire reset,           // Reset do sistema
    input wire [7:0] data_in,   // Dados a serem enviados
    input wire start,           // Sinal para iniciar a transmissão
    input wire CPOL,            // Polaridade do clock (Clock Polarity)
    input wire CPHA,            // Fase do clock (Clock Phase)
    input wire MISO,            // Master Input, Slave Output
    output reg SCLK,            // Clock SPI
    output reg MOSI,            // Master Output, Slave Input
    output reg CS,              // Slave Select
    output reg busy,            // Indica que a transmissão está em progresso
    output reg [7:0] data_out   // Dados recebidos do escravo
);

    // Calcula o divisor do clock com base nas frequências fornecidas
    localparam integer CLK_DIV = CLK_FREQ / (2 * SCLK_FREQ) - 1;

    // Definição dos estados
    localparam IDLE     = 3'b000; // Estado ocioso
    localparam LOAD     = 3'b001; // Carregamento dos dados
    localparam TRANSFER = 3'b010; // Transferência de dados
    localparam DONE     = 3'b011; // Finalização da transmissão

    reg [2:0] current_state, next_state;
    reg [7:0] shift_reg;      // Registrador de deslocamento para transmissão
    reg [7:0] rx_reg;         // Registrador de recepção
    reg [3:0] bit_cnt;        // Contador de bits
    reg [31:0] clk_counter;   // Contador para gerar o divisor de clock
    reg sclk_last;            // Estado anterior de SCLK

    wire edge_pos;            // Detecta borda de subida
    wire edge_neg;            // Detecta borda de descida

    reg sample;               // Condição para amostrar dado
    reg shift;                // Condição para deslocar dado
    reg load_data;
    reg shift_sample_data;
    reg load_data_out;

    assign edge_pos = ~sclk_last & SCLK;
    assign edge_neg =  sclk_last & ~SCLK;

    // Geração do SCLK com base no divisor e CPOL
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            SCLK <= CPOL;
            clk_counter <= 0;
        end else if (!CS) begin
            if (clk_counter == CLK_DIV) begin
                SCLK <= ~SCLK;
                clk_counter <= 0;
            end else begin
                clk_counter <= clk_counter + 1;
            end
        end else begin
            SCLK <= CPOL;
            clk_counter <= 0;
        end
    end

    // Sincronização de SCLK no clock do sistema
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            sclk_last <= CPOL;
        end else begin
            sclk_last <= SCLK;
        end
    end

    always @(*) begin
        sample = (edge_pos && (CPOL == CPHA)) || (edge_neg && (CPOL != CPHA));
        shift  = (edge_neg && (CPOL == CPHA)) || (edge_pos && (CPOL != CPHA));
    end

    always @(posedge sample or posedge reset) begin
        if (reset) begin
            MOSI <= 0;
        end else begin
            if (shift_sample_data) begin
                MOSI <= shift_reg[7]; // Envia o bit mais significativo
            end
        end
    end

    always @(posedge shift or posedge reset) begin
        if (reset) begin
            bit_cnt <= 4'b0;
        end else if (shift_sample_data) begin
            bit_cnt <= bit_cnt + 1'b1;
        end else begin
            bit_cnt <= 4'b0;
        end
    end

    always @(posedge shift or posedge load_data or posedge reset) begin
        if (reset) begin
            shift_reg <= 8'b0;
            rx_reg <= 8'b0;
        end else if (load_data) begin
            shift_reg <= data_in;
        end else if (shift_sample_data) begin
            shift_reg <= {shift_reg[6:0], 1'b0}; // Desloca
            rx_reg <= {rx_reg[6:0], MISO};
        end
    end

    // Após a recepção, carrega os dados
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'b0;
        end else if (load_data_out) begin
            data_out <= rx_reg;
        end
    end

    // Lógica sequencial: Transição de estado
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Lógica combinacional para determinar o próximo estado
    always @(*) begin
        next_state = current_state;
        case (current_state)
            IDLE:     if (start) next_state = LOAD;
            LOAD:     if (!CPHA || (CPHA && (edge_pos || edge_neg))) next_state = TRANSFER;
            TRANSFER: if (bit_cnt == 8) next_state = DONE;
            DONE:     next_state = IDLE;
        endcase
    end

    // Lógica sequencial: Controle dos sinais
    always @(*) begin
        if (reset) begin
            busy <= 0;
            CS <= 1;
            load_data <= 0;
            shift_sample_data <= 0;
            load_data_out <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    CS <= 1; // Escravo desativado
                    busy <= 0;
                    load_data <= !CPHA && start;
                    shift_sample_data <= 0;
                    load_data_out <= 0;
                end
                LOAD: begin
                    CS <= 0; // Escravo ativado
                    busy <= 1;
                    shift_sample_data <= 0;
                    load_data <= (!CPHA || (CPHA && (edge_pos || edge_neg)));
                    load_data_out <= 0;
                end
                TRANSFER: begin
                    CS <= 0;
                    busy <= 1;
                    load_data <= 0;
                    shift_sample_data <= 1;
                    load_data_out <= 0;
                end
                DONE: begin
                    CS <= 1;
                    busy <= 0;
                    shift_sample_data <= 0;
                    load_data <= 0;
                    load_data_out <= 1;
                end
                default: begin
                    CS <= 1;
                    busy <= 0;
                    load_data <= 0;
                    shift_sample_data <= 0;
                    load_data_out <= 0;
                end
            endcase
        end
    end

endmodule
