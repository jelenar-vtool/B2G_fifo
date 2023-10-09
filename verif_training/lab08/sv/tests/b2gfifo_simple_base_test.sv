class b2gfifo_simple_base_test extends uvm_test;
    `uvm_component_utils(b2gfifo_simple_base_test)

    extern function new(string name = "b2gfifo_simple_base_test", uvm_component parent=null);
    extern task run_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  b2gfifo_simple_base_test::new(string name = "b2gfifo_simple_base_test", uvm_component parent=null);
	super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_simple_base_test::run_phase(uvm_phase phase);
    super.run_phase(phase);
    #1ms;
endtask





