class b2gfifo_multiple_delayed_items_test extends  b2gfifo_base_test;

// TODO: * * * Extend this class from base test class * * *

// TODO: * * * Add to factory and declare a virtual sequence for this test * * *
   `uvm_component_utils(b2gfifo_multiple_delayed_items_test)
    b2gfifo_env m_env;

// TODO: * * * Declare the test constructor and run_phase task * * *
    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : b2gfifo_multiple_delayed_items_test
     function  b2gfifo_multiple_delayed_items_test::new(string name = "b2gfifo_multiple_delayed_items_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new
// TODO: * * * Write the test constructor definition * * *
     function void b2gfifo_multiple_delayed_items_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        super.build_phase(phase);
        //set_specific_configuration();
     set_type_override_by_type(b2gfifo_empty_sequence::get_type(), b2gfifo_multiple_delayed_items_sequence::get_type());

    endfunction : build_phase

// TODO: * * * Write the run_phase definition. Randomize and start the virtual sequence in it * * *
  task b2gfifo_multiple_delayed_items_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
