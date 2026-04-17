`ifndef UART_TEST_SV
`define UART_TEST_SV

`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "environment.sv"

class uart_test extends uvm_test;
    
    `uvm_component_utils(uart_test)
    uart_environment uart_env;

	// BRUNO - Alteração
    virtual uart_bfm   bfm_uart0;
    virtual reg_if_bfm bfm_reg0;
	// ----------------------
	
    function new(string name = "uart_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        
        super.build_phase(phase);
        uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.rx_ag", "is_active", UVM_PASSIVE);
        uvm_config_db#(uvm_active_passive_enum)::set(this, "uart_env.tx_ag", "is_active", UVM_PASSIVE);
        uart_env = uart_environment::type_id::create("uart_env", this);
		
		// BRUNO - Alteração
        if (!uvm_config_db#(virtual uart_bfm)::get(this, "", "bfm_uart0", bfm_uart0))
            `uvm_fatal(get_full_name(), "Virtual interface bfm_uart0 nao encontrada")

        if (!uvm_config_db#(virtual reg_if_bfm)::get(this, "", "bfm_reg0", bfm_reg0))
            `uvm_fatal(get_full_name(), "Virtual interface bfm_reg0 nao encontrada")
            
    // ----------------------------
            
    endfunction : build_phase

	// BRUNO - Alteração
    task automatic wait_cycles(input int n);
        repeat (n) @(posedge bfm_reg0.clk);
    endtask

    task automatic run_one_baud(
        input bit [4:0] baud_code,
        input real      baud_real,
        input bit [7:0] tx_data
    );
        bit [7:0] rx_data;
        bit got_data;
        int timeout_cycles;
        real frame_time_ns;

        got_data = 0;
        rx_data  = 8'h00;

        `uvm_info("BAUD_TEST",
                  $sformatf("Testando baud=%0.0f bps dado=0x%02h", baud_real, tx_data),
                  UVM_LOW)

        bfm_reg0.configure_csr(1'b0, 1'b0, 1'b0, 1'b0, 3'd7, baud_code);

        wait_cycles(50);

        bfm_uart0.send(tx_data, 8, baud_real, "none", 1'b0);

        // ALTERADO:
        // Antes o timeout era fixo e curto demais para baud baixos.
        // Agora ele é calculado com base no baud atual.
        frame_time_ns  = (10.0 * 1_000_000_000.0) / baud_real;
        timeout_cycles = integer'(((frame_time_ns * 2.5) / 10.0) + 0.5);

        repeat (timeout_cycles) begin
            bfm_reg0.get_csr();
            if (bfm_reg0.data_available) begin
                got_data = 1;
                break;
            end
            @(posedge bfm_reg0.clk);
        end

        if (!got_data) begin
            `uvm_error("BAUD_TEST",
                       $sformatf("TIMEOUT em %0.0f bps: data_available nao subiu", baud_real))
            return;
        end

        bfm_reg0.uart_receive(rx_data);

        if (rx_data !== tx_data) begin
            `uvm_error("BAUD_TEST",
                       $sformatf("ERRO em %0.0f bps: esperado=0x%02h recebido=0x%02h",
                                 baud_real, tx_data, rx_data))
        end
        else begin
            `uvm_info("BAUD_TEST",
                      $sformatf("PASS em %0.0f bps: recebido=0x%02h",
                                baud_real, rx_data),
                      UVM_LOW)
        end

        bfm_reg0.get_csr();
        if (bfm_reg0.rx_error) begin
            `uvm_error("BAUD_TEST",
                       $sformatf("rx_error ativou em %0.0f bps", baud_real))
        end

        wait_cycles(100);
    endtask

    task run_phase(uvm_phase phase);
        
        // incremental_sequence baud_item;
        
        phase.raise_objection(this);

		/* DATA - TESTING */
		
		/* BAUD RATE - TESTING */
        `uvm_info("BAUD_TEST", "Iniciando teste de variacao de baud rate", UVM_LOW)

        fork
            bfm_reg0.generate_clock(100_000_000.0, 0, 0.0);
            bfm_uart0.generate_clock(100_000_000.0, 0, 0.0);
            bfm_reg0.monitor_csr(100_000_000.0, 115200.0);
        join_none

        bfm_reg0.reset_pulse(1, 5, "Sync", 1);
        bfm_uart0.reset_pulse(1, 5, "Sync", 1);

        wait_cycles(50);

		// Alterar para configurar pelo uart_item e incremental_sequence ou random_sequence
        run_one_baud(5'd12,   9600.0, 8'h55);
        run_one_baud(5'd14,  19200.0, 8'hA3);
        run_one_baud(5'd19,  57600.0, 8'h3C);
        run_one_baud(5'd21, 115200.0, 8'hF0);

        `uvm_info("BAUD_TEST", "Fim do teste de variacao de baud rate", UVM_LOW)

		/* PARITY (ERROR) - TESTING */
		
		/* PARITY - TESTING */
        
        /* BAUD RATE (ERROR) - TESTING */
        
        #100ns;
        phase.drop_objection(this);
        
    endtask : run_phase

endclass : uart_test

`endif // UART_TEST_SV
