
class fifo_agent extends uvm_agent;
    
    `uvm_component_utils(fifo_agent)

      
   
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass //fifo_agent

//-------------------------------------------------------------------------------------------------------------
function fifo_agent::new(string name, uvm_component parent);

    super.new(name, parent);

endfunction

//-------------------------------------------------------------------------------------------------------------
function void fifo_agent::build_phase(uvm_phase phase);
    
    super.build_phase(phase);

endfunction // fifo_master_agent::buid_phase

//-------------------------------------------------------------------------------------------------------------
function void fifo_agent::connect_phase(uvm_phase phase);

endfunction // fifo_agent::connect_phase

