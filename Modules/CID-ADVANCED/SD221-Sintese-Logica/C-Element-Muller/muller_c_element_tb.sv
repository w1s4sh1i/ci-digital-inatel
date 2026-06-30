`include "muller_c_element.sv"

`timescale 1 ns / 1 ps

module muller_c_element_tb;

    // Sinais do Testbench
    logic rst_n;
    logic a;
    logic b;
    logic q;

    muller_c_element DUT_mce (
        .rst_n (rst_n),
        .a     (a),
        .b     (b),
        .q     (q)
    );

	// Monitoramento
	initial begin
		$timeformat(-9,2,"",10);
		$dumpfile("muller_c_element_tb.vcd");
		$dumpvars(0, muller_c_element_tb);
		$display("|Time (ns)	|reset	|Entrada A|Entrada B|Saída Y	|");
		$monitor("|%0t		|%b	|%b	  |%b	    |%b		|", $realtime, rst_n, a, b, q);
	end

	// [ ] Build a test task; 

    // Processo de Estímulos
    initial begin : proc_stimulus
        $display("[TB_START] Iniciando testes no Muller C-element...");
        
        // Estado Inicial & Reset
        rst_n = 1'b0;
        a     = 1'b0;
        b     = 1'b0;
        #15;
        
        rst_n = 1'b1;
        #10;
        
        // Assert de verificação inicial (Ambos 0 -> Saída deve ser 0)
        assert(q == 1'b0) else $error("\nErro: Inicialização falhou.");

        // Cenário 1: Mudar apenas uma entrada (Deve RETER o estado '0')
        $display("\n[TEST_1] Modificando apenas entrada A (0 -> 1)...");
        a = 1'b1; #10;
        assert(q == 1'b0) else $error("Erro no Cenário 1: Modificou o estado indevidamente.");

        // Cenário 2: Ambas as entradas em '1' (Deve chavear para '1')
        $display("\n[TEST_2] Modificando entrada B para '1' (Transição para 1)...");
        b = 1'b1; #10;
        assert(q == 1'b1) else $error("\nErro no Cenário 2: Falha ao transicionar para 1.");

        // Cenário 3: Remover uma entrada (Deve RETER o estado '1')
        $display("\n[TEST_3] Removendo entrada A (1 -> 0) (Deve reter '1')...");
        a = 1'b0; 
        #10;
        assert(q == 1'b1) else $error("Erro no Cenário 3: Perda de estado retido em 1.");

        // Cenário 4: Ambas as entradas retornando para '0' (Transição para 0)
        $display("\n[TEST_4] Retornando entrada B para '0' (Transição para 0)...");
        b = 1'b0; 
        #10;
        assert(q == 1'b0) else $error("Erro no Cenário 4: Falha ao retornar para 0.");

        // Cenário 5: Ativação concorrente assíncrona rápida
        $display("\n[TEST_5] Teste de chaveamento simultâneo...");
        #5; 
        
        a = 1'b1; 
        b = 1'b1; 
        #5;
        
        assert(q == 1'b1) else $error("Erro no Cenário 5: Falha no chaveamento simultâneo.");
	
	// Configurar task de validação dos testes. 
        $display("\n[TB_FINISHED] Todos os cenários validados com sucesso.");
        $finish;
    end : proc_stimulus

endmodule : muller_c_element_tb
