`include "d_ff.sv"

`timescale 1ns / 1ps

module tb_d_ff;

    // --- Sinais de Interface ---
    logic clk;
    logic rst_n;
    logic d;
    logic q;
    logic q_n;

    // --- Instanciação do Design Under Test (DUT) ---
    d_ff dut (
        .clk   (clk),
        .rst_n (rst_n),
        .d     (d),
        .q     (q),
        .q_n   (q_n)
    );

    // --- Geração do Clock (Período de 10ns -> 100MHz) ---
    always begin
        clk = 0;
        #5;
        clk = 1;
        #5;
    end

    // --- Bloco de Estímulos ---
    initial begin
        // Inicialização dos sinais
        rst_n = 1'b0;
        d     = 1'b0;
        
        // Aplica o reset por dois ciclos de clock
        #15;
        rst_n = 1'b1; // Libera o reset
        
        // Monitorando as mudanças no terminal
        $monitor("Tempo=%0td | rst_n=%b | d=%b | q=%b | q_n=%b", $time, rst_n, d, q, q_n);

        // --- Casos de Teste ---
        // Como o FF é negedge, mudamos o 'd' na posedge para estabilidade
        @(posedge clk); d = 1'b1; // Espera-se q=1 na próxima negedge
        @(posedge clk); d = 1'b0; // Espera-se q=0 na próxima negedge
        @(posedge clk); d = 1'b1; // Espera-se q=1 na próxima negedge
        
        // Testando Reset Assíncrono no meio do ciclo
        #3; 
        rst_n = 1'b0;             // Ativa reset imediatamente
        #5;
        rst_n = 1'b1;             // Desativa reset
        
        // Mais um teste após o reset
        @(posedge clk); d = 1'b1;
        @(posedge clk); d = 1'b0;

        // Fim da simulação
        #20;
        $display("Simulação finalizada com sucesso!");
        $finish;
    end

endmodule
