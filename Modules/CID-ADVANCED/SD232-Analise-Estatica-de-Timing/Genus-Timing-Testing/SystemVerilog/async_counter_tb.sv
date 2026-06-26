`include "async_counter.sv"

`timescale 1ns / 1ps

module tb_async_counter;

    logic       clk;
    logic       rst_n;
    logic [3:0] count;

    async_counter dut (
        .clk   (clk),
        .rst_n (rst_n),
        .count (count)
    );

    always #5; clk = ~clk;

	// DUMP AND MONITOR
	
    initial begin
        // --- TESTE 1: Inicialização e Reset Assíncrono ---
        $display("[TESTE] Iniciando Reset...");
        rst_n = 1'b0;
        #15; // Mantém o reset por mais de um ciclo
        
        if (count !== 4'b0000) begin
            $display("[ERRO] Contador não resetou para 0000! Valor atual: %b", count);
        end else begin
            $display("[OK] Reset funcional. count = %b", count);
        end
        
        // Libera o reset
        rst_n = 1'b1;
        
        // --- TESTE 2: Contagem Completa (0 a 15) ---
        $display("\n[TESTE] Iniciando contagem progressiva...");
        
        // Como o FF0 chaveia na NEGEDGE do clk, esperamos o sinal estabilizar
        // na POSEDGE do clk para fazer a checagem limpa dos 4 bits.
        for (int i = 0; i < 16; i++) begin
            @(posedge clk); 
            #1; // Pequeno atraso para garantir que o efeito ripple terminou
            
            $display("Tempo: %0td | Esperado: %0d | Obtido: %0d (Bin: %b)", $time, i, count, count);
            
            if (count !== i) begin
                $display("[ERRO] Falha na contagem! Esperado %0d, obtido %0d", i, count);
            end
        end

        // --- TESTE 3: Overflow (Rollover de 15 para 0) ---
        $display("\n[TESTE] Verificando Overflow (15 -> 0)...");
        @(posedge clk);
        #1;
        if (count !== 4'b0000) begin
            $display("[ERRO] Falha no Overflow! Esperado 0000, obtido %b", count);
        end else begin
            $display("[OK] Contador resetou com sucesso após o valor 15.");
        end

        // --- TESTE 4: Interrupção por Reset no Meio da Contagem ---
        $display("\n[TESTE] Forçando reset assíncrono no meio da contagem...");
        // Deixa contar alguns ciclos
        repeat(3) @(posedge clk);
        
        // Aplica o reset assíncrono fora da borda do clock
        #3; 
        rst_n = 1'b0; 
        #1; // Margem para propagação do reset
        
        if (count !== 4'b0000) begin
            $display("[ERRO] Reset assíncrono falhou em tempo de execução! count = %b", count);
        end else begin
            $display("[OK] Reset assíncrono interrompeu a contagem com sucesso.");
        end

        // --- Fim dos Testes ---
        #20;
        rst_n = 1'b1;
        $display("Simulação concluída com sucesso!");
        $finish;
    end

endmodule
