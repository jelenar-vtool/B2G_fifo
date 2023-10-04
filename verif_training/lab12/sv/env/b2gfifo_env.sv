//------------------------------------------------------------------------------------------------------------
class b2gfifo_env extends uvm_env;

    // TODO: * * * Declare the agent and register env to factory * * *

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
endclass : b2gfifo_env

//------------------------------------------------------------------------------------------------------------
function b2gfifo_env::new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//------------------------------------------------------------------------------------------------------------
function void b2gfifo_env:: build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    // TODO: * * * instantiate the agent * * *
endfunction : build_phase 

//------------------------------------------------------------------------------------------------------------ 
function void b2gfifo_env:: connect_phase (uvm_phase phase);
    super.connect_phase(phase);
endfunction : connect_phase
