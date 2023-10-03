/*
    Default configuration is one master and one slave agent for the test. You can set up environment cfg here.
*/
class fifo_base_test extends uvm_test;
    `uvm_component_utils(fifo_base_test)


    extern function new(string name = "fifo_base_test", uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void start_of_simulation_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  fifo_base_test::new(string name = "fifo_base_test", uvm_component parent=null);

	super.new(name,parent);

endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void  fifo_base_test::build_phase(uvm_phase phase);

    super.build_phase(phase);

endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void  fifo_base_test::start_of_simulation_phase(uvm_phase phase);

	super.start_of_simulation_phase(phase);
	uvm_top.set_timeout(.timeout(100000000), .overridable(1));
	`uvm_info("start_of_simulation_phase", $sformatf("Printing topology"), UVM_LOW)
	uvm_top.print_topology();
endfunction







