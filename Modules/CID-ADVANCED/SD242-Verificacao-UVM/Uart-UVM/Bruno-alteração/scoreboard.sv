`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV
`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

class scoreboard extends uvm_component;
    `uvm_component_utils(scoreboard)

    uvm_tlm_analysis_fifo #(bit [7:0]) command_fifo;
    uvm_tlm_analysis_fifo #(bit [7:0]) result_fifo;

    int match_count;
    int mismatch_count;

    protected string agent_name;

    function new(string name = "scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    function void set_agent_name(string name);
        agent_name = name;
    endfunction : set_agent_name

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        command_fifo = new("command_fifo", this);
        result_fifo  = new("result_fifo", this);

        match_count    = 0;
        mismatch_count = 0;
    endfunction : build_phase

    task run_phase(uvm_phase phase);
        bit [7:0] expected_cmd;
        bit [7:0] actual_result;

        forever begin
            command_fifo.get(expected_cmd);
            result_fifo.get(actual_result);

            `uvm_info(get_full_name(),
                      $sformatf("Received expected command: 0x%02h, actual result: 0x%02h",
                                expected_cmd, actual_result),
                      UVM_LOW)

            if (expected_cmd == actual_result) begin
                match_count++;
                `uvm_info(get_full_name(),
                          "MATCH: Expected command matches actual result.",
                          UVM_LOW)
            end
            else begin
                mismatch_count++;

                // ALTERADO:
                // Antes estava com `uvm_fatal`, que encerrava a simulação
                // no primeiro erro e impedia continuar o teste multi-baud.
                // Agora usamos `uvm_error` para registrar o erro sem matar a simulação.
                `uvm_error(get_full_name(),
                           $sformatf("MISMATCH: Expected 0x%02h but got 0x%02h.",
                                     expected_cmd, actual_result))
            end
        end
    endtask : run_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_full_name(),
                  $sformatf("\n--- %s SCOREBOARD REPORT ---\nMatches: %0d\nMismatches: %0d\n",
                            agent_name, match_count, mismatch_count),
                  UVM_LOW)
    endfunction : report_phase

endclass : scoreboard

`endif // SCOREBOARD_SV