// * * * Default sequencer * * *


class fifo_master_sequencer extends uvm_sequencer #(fifo_item);

   `uvm_component_utils(fifo_master_sequencer)

    fifo_cfg cfg;

    extern function new (string name, uvm_component parent);
    extern function void build_phase (uvm_phase phase);
endclass // fifo_master_sequencer
 
//-------------------------------------------------------------------------------------------------------------
function fifo_master_sequencer::new (string name, uvm_component parent);

    super.new(name, parent);

endfunction 

//-------------------------------------------------------------------------------------------------------------
function void fifo_master_sequencer::build_phase(uvm_phase phase);

    super.build_phase(phase);

endfunction

