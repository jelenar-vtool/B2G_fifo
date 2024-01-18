class b2gfifo_empty_check_test extends  b2gfifo_base_test;


   `uvm_component_utils(b2gfifo_empty_check_test)
    b2gfifo_env m_env;


    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : b2gfifo_empty_check_test
     function  b2gfifo_empty_check_test::new(string name = "b2gfifo_empty_check_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new

     function void b2gfifo_empty_check_test::build_phase(uvm_phase phase);
	uvm_factory factory= uvm_factory::get();
        super.build_phase(phase);
        //set_specific_configuration();
     set_type_override_by_type(b2gfifo_empty_sequence::get_type(), b2gfifo_empty_check_sequence::get_type());

    endfunction : build_phase


  task b2gfifo_empty_check_test::run_phase(uvm_phase phase);

        super.run_phase(phase);
endtask : run_phase
