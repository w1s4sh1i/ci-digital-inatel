// Incremental file
`ifndef INCREMENTAL_SEQUENCE_SV
`define INCREMENTAL_SEQUENCE_SV

`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "random_sequence.sv"

// Alterar composição ou resgate das mensagens

class incremental_sequence extends random_sequence; // 
    
    // Alterar para configuração externa
    int SAMPLES  = 40; 
    
    `uvm_component_utils(incremental_sequence)
	
    function new(string name = "incremental_sequence", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

	// Adicionar leitura de arquivo externo

    task body();
    
    	// Congufirar SAMPLES por indução externa
        
        req = uart_item::type_id::create("req");
        
        repeat (SAMPLES) begin
            
            start_item(req);
            
            // Increment the data value
            // req.data = req.data + 1; 
            
            // Adicionar seletor para alteração dos valores; -> Analisar incremente baud
            req.baud = req.baud + 1; 
            
      		/* 
            `uvm_info(get_full_name(), $sformatf("Generated incremental 'baud': %0h", data), UVM_MEDIUM) // req.data
            finish_item(req.data);
            */
            
            `uvm_info(get_full_name(), $sformatf("Generated incremental 'baud': %0h", baud), UVM_MEDIUM)
            finish_item(req.baud);
            
        end
    endtask : body
    
    /// Configuração

endclass : incremental_sequence

`endif // INCREMENTAL_SEQUENCE_SV
