// Random  file
`ifndef RANDOM_SEQUENCE_SV
`define RANDOM_SEQUENCE_SV

`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "uart_item.sv"

// Alterar estrutura para geração das mensagens;

class random_sequence extends uvm_sequence #(uart_item);
    
    // `uvm_object_utils(random_sequence)
    
    `uvm_object_utils(random_sequence)

    uart_item seq_item;
    
    int item_count;
    // BAUD - 16 de abril
    int SAMPLES = 500; 
	// -------------------------
	
    function new(string name = "random_sequence");
        super.new(name);
    endfunction : new

    virtual task body();
    
        seq_item 	= uart_item::type_id::create("seq_item");
        item_count	= 0;
    
        repeat (SAMPLES) begin
            
            start_item(seq_item);
            
            if (!seq_item.randomize()) begin
                `uvm_error(get_full_name(), "Failed to get random uart_item")
            end
			            
            item_count++;
            
            // `uvm_info(get_full_name(), $sformatf("Sequence 'data' %d: Generated random data: 0x%02h", item_count, seq_item.data), UVM_MEDIUM)
            
            // BAUD -16 de abril 
            `uvm_info(get_full_name(), $sformatf("Sequence 'baud' test %d: Generated 'incremental' 'baud': 0x%02h", item_count, seq_item.baud), UVM_MEDIUM)
           
            finish_item(seq_item);
             
        end
    endtask : body

endclass : random_sequence

`endif // RANDOM_SEQUENCE_SV
