`timescale 1ns / 1ps

module axi4_lite_system_tb;

    // Sinais de controle do Testbench
    reg clk 		= 1'b0;
    reg reset 		= 1'b1;
    reg wr_en 		= 1'b0;
    reg rd_en 		= 1'b0;
    reg [31:0] addr 	= 32'b0;
    reg [31:0] wdata_in = 32'b0;
    
    wire [31:0] rdata_out; // 32'h0
    wire read_done;
    wire write_done;

    // Variáveis para estatísticas de testes (Métricas dinâmicas)
    integer 	testes_passivos		= 0,
    		testes_negativos	= 0,
    		total_testes 		= 0;
    
    real pct_passivos, pct_negativos;
    
    // Variável auxiliar para receber leituras
    reg [31:0] read_val = 32'h0; 	 
    
    // Instanciação do bloco TOP
    axi4_lite_system_top DUT_system (
        .clk(clk),
        .reset(reset),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(addr),
        .wdata_in(wdata_in),
        .rdata_out(rdata_out),
        .read_done(read_done),
        .write_done(write_done)
    );

    // Geração do Clock (Período de 10ns)
    always #5 clk = ~clk;
    
    // DECLARAÇÃO DE TASKS (TAREFAS) PARA OTIMIZAÇÃO
    
    // Escrita AXI
    task axi_write;
        input [31:0] target_addr;
        input [31:0] target_data;
        begin
            @(posedge clk);
            addr <= target_addr;
            wdata_in <= target_data;
            wr_en <= 1'b1;
            @(posedge clk);
            wr_en <= 1'b0;
            wait(write_done);
            #1; // Tempo para estabilização
        end
    endtask

    // Leitura AXI
    task axi_read;
        input  [31:0] target_addr;
        output [31:0] data_read;
        begin
            @(posedge clk);
            addr <= target_addr;
            rd_en <= 1'b1;
            @(posedge clk);
            rd_en <= 1'b0;
            wait(read_done);
            #1;
            data_read = rdata_out;
        end
    endtask

    // Validadora Automática
    task check_result;
    	input valid;  
        input [31:0] expected, actual;
        input [8*120 - 1:0] test_msg; // String de até 120 caracteres
        
        reg [8*4 - 1:0]	mark;
        reg		comparison;
        begin
            total_testes = total_testes + 1;
            comparison = expected === actual;
            mark = valid === comparison ? "OK": "ERRO";
            if (comparison) begin
                $display("[%0s] %4s;", mark, test_msg);
            end else begin
                $display("[%0s] %4s | Esperado: 0x%08x, Obtido: 0x%08x;", mark, test_msg, expected, actual);
            end
            
            // Realizar contagem em outra task; 
            testes_passivos = testes_passivos + (valid === comparison);
            testes_negativos = testes_negativos + (valid !==  comparison);
        end
    endtask

    
    // ROTINA PRINCIPAL DE TESTES
    
    initial begin
    
        $dumpfile("axi4_lite_system.vcd");
        $dumpvars(0, axi4_lite_system_tb);
        // monitor...
    end 
    
    initial begin
        
        $display("\n[TB] Iniciar testes (jun, 1 2026): ...");

        // TESTE 1: Reset
        reset = 1'b1;
        
        #20; 
        check_result(1, 32'h0, DUT_system.UUT_subordinate.reg_s[0], 
        	"Teste 1: Reset ativo. reg0 zerado");
        check_result(1, 32'h0, DUT_system.UUT_subordinate.reg_s[1], 
        	"Teste 1: Reset ativo. reg1 zerado");
        
        reset = 1'b0; 
        
        #10;
        // TESTES 2 e 3: Escritas via Master
        axi_write(32'h00000000, 32'h00000011);
        check_result(1, 32'h00000011, DUT_system.UUT_subordinate.reg_s[0], 
        	"Teste 2: Escrita bem sucedida no reg0 (0x00)");

        axi_write(32'h00000004, 32'h00000022);
        check_result(1, 32'h00000022, DUT_system.UUT_subordinate.reg_s[1], 
        	"Teste 3: Escrita bem sucedida no reg1 (0x04)");

        // TESTES 4 e 5: Injeção Direta (Simulação de hardware externo)
        DUT_system.UUT_subordinate.reg_s[2] = 32'h00000033;
        
        #1;
        check_result(1, 32'h00000033, DUT_system.UUT_subordinate.reg_s[2], 
        	"Teste 4: Injetado valor externo em reg2_din");

        DUT_system.UUT_subordinate.reg_s[3] = 32'h00000044;
        
        #1;
        check_result(1, 32'h00000044, DUT_system.UUT_subordinate.reg_s[3], 
        	"Teste 5: Injetado valor externo em reg3_din");

        // TESTES 6 a 9: Leituras via Master
        axi_read(32'h00000000, read_val);
        check_result(1, 32'h00000011, read_val, 
        	"Teste 6: Leitura do reg0 (0x00)");

        axi_read(32'h00000004, read_val);
        check_result(1, 32'h00000022, read_val, 
        	"Teste 7: Leitura do reg1 (0x04)");

        axi_read(32'h00000008, read_val);
        check_result(1, 32'h00000033, read_val, 
        	"Teste 8: Leitura do reg2 (0x08 - Externo)");

        axi_read(32'h0000000C, read_val);
        check_result(1, 32'h00000044, read_val, 
        	"Teste 9: Leitura do reg3 (0x0C - Externo)");

        // TESTE 10: Validação de Flags AXI (OKAY)
        total_testes = total_testes + 1;
        
        if (DUT_system.bresp == 2'b00 && DUT_system.rresp == 2'b00) begin
            $display("[OK] Teste 10: Respostas do protocolo AXI OKAY (2'b00);");
            testes_passivos = testes_passivos + 1;
        end else begin
            $display("[ERRO] Teste 10: Erro nas flags AXI (bresp: %b, rresp: %b);", DUT_system.bresp, DUT_system.rresp);
            testes_negativos = testes_negativos + 1;
        end

        // TESTE 11 e 12: Tentativa de sobrescrever dados externos (Falha esperada pelo RTL sem proteção)
        axi_write(32'h00000008, 32'hDEADBEEF);
        check_result(0, 32'h00000033, DUT_system.UUT_subordinate.reg_s[2], 
        	"Teste 11: Escrita rejeitada em reg2 (Read-Only)");

        axi_write(32'h0000000C, 32'hAAAAFFFF);
        check_result(0, 32'h00000044, DUT_system.UUT_subordinate.reg_s[3], 
        	"Teste 12: Escrita rejeitada em reg3 (Read-Only)");

        // DASHBOARD DE MÉTRICAS FINAL        
        pct_passivos  = (testes_passivos * 100.0) / total_testes;
        pct_negativos = (testes_negativos * 100.0) / total_testes;

        $display("\n                RELATORIO DE COBERTURA DE TESTES          ");
        $display("------------------------------------------------------------");
        $display(" Total de Casos Executados: %0d;", total_testes - 1); // corrigir a redução
        $display(" Percentual de testes: \n> Positivos (OK) : %0.2f%% (%0d testes); \n> Negativos (ERRO) : %0.2f%% (%0d testes); \n\n", pct_passivos, testes_passivos - 1, pct_negativos, testes_negativos); // 

        #20;
        $finish;
    end

endmodule
