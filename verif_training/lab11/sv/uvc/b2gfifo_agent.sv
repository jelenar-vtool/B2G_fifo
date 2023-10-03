
class b2gfifo_agent extends uvm_agent;
    
    //TODO: * * * Register the agent with the factory * * *
      
    //TODO: * * * Declare the agent's subcomponents * * *

    //TODO: * * * Declare the agent's config object * * *
   
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass : b2gfifo_agent

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_agent::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    //TODO: * * * Instantiate the agent's subcomponents * * *
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_agent::connect_phase(uvm_phase phase);
    
    //TODO: * * * Connect the driver to the sequencer * * *
        
endfunction : connect_phase

