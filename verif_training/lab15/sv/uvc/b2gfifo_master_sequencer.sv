// * * * Default sequencer * * *

class b2gfifo_master_sequencer extends uvm_sequencer #(b2gfifo_item);

   `uvm_component_utils(b2gfifo_master_sequencer)
    b2gfifo_cfg cfg;
   virtual b2gfifo_if b2gfifo_vif;
   virtual b2gfifo_topvif b2gfifo_topif;	
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
 if(!uvm_config_db #(virtual b2gfifo_if )::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
end
 if(!uvm_config_db #(virtual b2gfifo_topvif )::get(this, "", "b2gfifo_topif", b2gfifo_topif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
end
endfunction : build_phase
