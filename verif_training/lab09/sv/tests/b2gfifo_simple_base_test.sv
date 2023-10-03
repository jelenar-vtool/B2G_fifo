class b2gfifo_simple_base_test extends uvm_test;
    `uvm_component_utils(b2gfifo_simple_base_test)

    b2gfifo_master_driver    driver;
    b2gfifo_master_sequencer sequencer;

    extern function new(string name = "b2gfifo_simple_base_test", uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern virtual function void start_of_simulation_phase(uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  b2gfifo_simple_base_test::new(string name = "b2gfifo_simple_base_test", uvm_component parent=null);
	super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_simple_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    driver = b2gfifo_master_driver::type_id::create("driver", this);
    sequencer = b2gfifo_master_sequencer::type_id::create("sequencer", this);
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_simple_base_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driver.seq_item_port.connect(sequencer.seq_item_export);
endfunction : connect_phase

//-------------------------------------------------------------------------------------------------------------
function void  b2gfifo_simple_base_test::start_of_simulation_phase(uvm_phase phase);
	uvm_report_server svr;
    uvm_verbosity verbosity = UVM_LOW;

	super.start_of_simulation_phase(phase);
	uvm_top.set_timeout(.timeout(5000), .overridable(1));
	`uvm_info("start_of_simulation_phase", $sformatf("Printing topology"), UVM_LOW)
	uvm_top.print_topology();
	svr = uvm_report_server::get_server();

    //set verbosity level for env
    $value$plusargs("VERBOSITY=%s", verbosity);
    `uvm_info("start_of_simulation_phase", $sformatf("Verbosity is set to %s.", verbosity.name()), UVM_LOW)
	set_report_verbosity_level_hier(verbosity);
	svr.set_max_quit_count(1000); //maximum number of errors 
	
	uvm_config_db#(uvm_object_wrapper)::set(this, "sequencer.run_phase", "default_sequence", 
	                                       b2gfifo_master_sequence::type_id::get());
endfunction

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_simple_base_test::report_phase(uvm_phase phase);
    uvm_report_server svr;
  	super.report_phase(phase);
  	svr = uvm_report_server::get_server();
endfunction

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_simple_base_test::run_phase(uvm_phase phase);
    super.run_phase(phase);
endtask





