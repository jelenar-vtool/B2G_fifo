// * * * Default sequencer * * *

class b2gfifo_master_sequencer extends uvm_sequencer #(b2gfifo_item);

   `uvm_component_utils(b2gfifo_master_sequencer)

    extern function new(string name, uvm_component parent);
    extern function void build_phase(uvm_phase phase);
endclass : b2gfifo_master_sequencer
 
//-------------------------------------------------------------------------------------------------------------
function b2gfifo_master_sequencer::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_master_sequencer::build_phase(uvm_phase phase);
    super.build_phase(phase);
endfunction : build_phase
