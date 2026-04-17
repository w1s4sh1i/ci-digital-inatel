`ifndef TX_MONITOR_SV
`define TX_MONITOR_SV
`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

class tx_monitor extends uvm_monitor;
    `uvm_component_utils(tx_monitor)

    virtual uart_bfm   bfm_uart0;
    virtual reg_if_bfm bfm_reg0;

    uvm_analysis_port#(bit [7:0]) ap_command;
    uvm_analysis_port#(bit [7:0]) ap_result;

    function new(string name = "tx_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap_command = new("ap_command", this);
        ap_result  = new("ap_result", this);

        if (!uvm_config_db#(virtual uart_bfm)::get(this, "", "bfm_uart0", bfm_uart0))
            `uvm_fatal(get_full_name(), "BFM not set via uvm_config_db");

        if (!uvm_config_db#(virtual reg_if_bfm)::get(this, "", "bfm_reg0", bfm_reg0))
            `uvm_fatal(get_full_name(), "Register Interface BFM not set via uvm_config_db");
    endfunction : build_phase

    // ALTERADO:
    // conversão do código do CSR para baud real
    function real baud_code_to_real(input bit [4:0] baud_code);
        case (baud_code)
            5'd0  : baud_code_to_real = 50.0;
            5'd1  : baud_code_to_real = 75.0;
            5'd2  : baud_code_to_real = 110.0;
            5'd3  : baud_code_to_real = 134.0;
            5'd4  : baud_code_to_real = 150.0;
            5'd5  : baud_code_to_real = 200.0;
            5'd6  : baud_code_to_real = 300.0;
            5'd7  : baud_code_to_real = 600.0;
            5'd8  : baud_code_to_real = 1200.0;
            5'd9  : baud_code_to_real = 1800.0;
            5'd10 : baud_code_to_real = 2400.0;
            5'd11 : baud_code_to_real = 4800.0;
            5'd12 : baud_code_to_real = 9600.0;
            5'd13 : baud_code_to_real = 14400.0;
            5'd14 : baud_code_to_real = 19200.0;
            5'd15 : baud_code_to_real = 28800.0;
            5'd16 : baud_code_to_real = 31250.0;
            5'd17 : baud_code_to_real = 38400.0;
            5'd18 : baud_code_to_real = 56000.0;
            5'd19 : baud_code_to_real = 57600.0;
            5'd20 : baud_code_to_real = 76800.0;
            5'd21 : baud_code_to_real = 115200.0;
            5'd22 : baud_code_to_real = 128000.0;
            5'd23 : baud_code_to_real = 153600.0;
            5'd24 : baud_code_to_real = 230400.0;
            5'd25 : baud_code_to_real = 256000.0;
            5'd26 : baud_code_to_real = 460800.0;
            5'd27 : baud_code_to_real = 500000.0;
            5'd28 : baud_code_to_real = 576000.0;
            5'd29 : baud_code_to_real = 921600.0;
            default: baud_code_to_real = 115200.0;
        endcase
    endfunction

    function int data_len_from_csr(input bit [31:0] csr_data);
        data_len_from_csr = csr_data[6:4] + 1;
    endfunction

    function string parity_from_csr(input bit [31:0] csr_data);
        if (csr_data[1] == 1'b0)
            parity_from_csr = "none";
        else if (csr_data[2] == 1'b0)
            parity_from_csr = "even";
        else
            parity_from_csr = "odd";
    endfunction

    function bit stop_from_csr(input bit [31:0] csr_data);
        stop_from_csr = csr_data[3];
    endfunction

    task command_monitor_task();
        bit [7:0] data_read;
        forever begin
            bfm_reg0.get_if_write01(data_read);
            ap_command.write(data_read);
            @(posedge bfm_reg0.clk);
        end
    endtask

    task result_monitor_task();
        bit [7:0]  data_read;
        bit [31:0] csr_data;
        real       baud_real;
        int        data_len_cfg;
        string     parity_cfg;
        bit        stop_bit_cfg;

        forever begin
            // ALTERADO:
            // lê configuração atual antes de decodificar o frame
            bfm_reg0.read_register(csr_data, 2'b00);

            baud_real    = baud_code_to_real(csr_data[11:7]);
            data_len_cfg = data_len_from_csr(csr_data);
            parity_cfg   = parity_from_csr(csr_data);
            stop_bit_cfg = stop_from_csr(csr_data);

            // LINHA ANTIGA:
            // bfm_uart0.receive_tx(data_read);

            // ALTERADO:
            // passa baud/data_len/paridade/stop corretos
            bfm_uart0.receive_tx(
                data_read,
                data_len_cfg,
                baud_real,
                parity_cfg,
                stop_bit_cfg
            );

            ap_result.write(data_read);
        end
    endtask

    task run_phase(uvm_phase phase);
        fork
            command_monitor_task();
            result_monitor_task();
        join_none
    endtask : run_phase

endclass : tx_monitor

`endif // TX_MONITOR_SV