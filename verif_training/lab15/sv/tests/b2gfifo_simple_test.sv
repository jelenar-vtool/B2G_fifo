// TODO: * * * Write the extended test class here * * *
class b2gfifo_simple_test extends  b2gfifo_base_test;

// TODO: * * * Extend this class from base test class * * *

// TODO: * * * Add to factory and declare a virtual sequence for this test * * *
   `uvm_component_utils(b2gfifo_simple_test)
	b2gfifo_virtual_sequence  ms_seq;

// TODO: * * * Declare the test constructor and run_phase task * * *
    extern function new (string name, uvm_component parent);
    extern  function void build_phase (uvm_phase phase);
    extern  task run_phase (uvm_phase phase);
   
endclass : b2gfifo_simple_test
     function  b2gfifo_simple_test::new(string name = "b2gfifo_simple_test", uvm_component parent);
	super.new(name,parent);
    endfunction : new
// TODO: * * * Write the test constructor definition * * *
     function void b2gfifo_simple_test::build_phase(uvm_phase phase);
        super.build_phase(phase);
        //set_specific_configuration();
     
    endfunction : build_phase

// TODO: * * * Write the run_phase definition. Randomize and start the virtual sequence in it * * *
    task b2gfifo_simple_test::run_phase(uvm_phase phase);


       phase.raise_objection(this);
       ms_seq=b2gfifo_virtual_sequence::type_id::create("ms_seq");
       ms_seq.start(m_env.m_virt_seqr);
 	
       phase.phase_done.set_drain_time(this, 100ns);
       phase.drop_objection(this);
endtask : run_phase

// TODO: * * * Don't forget to add the objections! * * *
