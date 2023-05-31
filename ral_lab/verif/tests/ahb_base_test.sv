class ahb_base_test extends uvm_test;
  
  // registration macro
  `uvm_component_utils(ahb_base_test)
  
  ahb_environment environment;
  //TO_DO
  
  // constructor
  function new(string name="ahb_base_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  // build phase
  virtual function void build_phase(uvm_phase phase);
    //TO_DO
    environment = ahb_environment::type_id::create("environment",this);
  endfunction
  
  // start_of_simulation phase
  virtual function void start_of_simulation_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
  
  // connect phase
  virtual function void connect_phase(uvm_phase phase);
  endfunction
  
  // end_of_elaboration phase
  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);

    // allow additional time before stopping
    uvm_test_done.set_drain_time(this, 10us);
  endfunction
  
  // set default configuration
  function void set_default_configuration();
    // define default configuration
  endfunction

endclass

















