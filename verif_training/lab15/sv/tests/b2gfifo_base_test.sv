class b2gfifo_base_test extends uvm_test;
    // TODO: * * * Add to factory * * *
    
    // TODO: * * * Declare test components and objects * * *

    extern function new(string name = "b2gfifo_base_test", uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  b2gfifo_base_test::new(string name = "b2gfifo_base_test", uvm_component parent=null);
	super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // TODO: * * * Instantitate test components and objects * * *

    // TODO: * * * Apply default configuration to all components and objects * * *
    
    // TODO: * * * Set the environment configuration to config_db * * *
    
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_base_test::run_phase(uvm_phase phase);
endtask





