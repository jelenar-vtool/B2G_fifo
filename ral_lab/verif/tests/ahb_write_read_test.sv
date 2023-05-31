class ahb_write_read_test extends ahb_base_test;

  `uvm_component_utils(ahb_write_read_test)
   
  ahb_write_sequence write_seq;
  ahb_read_sequence read_seq;

  // constructor
  function new(string name="ahb_write_read_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  // build phase
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    write_seq = ahb_write_sequence::type_id::create("write_seq");
    read_seq = ahb_read_sequence::type_id::create("read_seq");
  endfunction
  
  
  
  // run phase
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    
    //WRITE REGISTER WITHOUT RAL MODEL
    //REGISTER 1
    write_seq.write_addr = 32'h00000000;
    write_seq.write_data = 32'hffffffff;
    write_seq.start(environment.agent.sequencer);
    
    //REGISTER 2
    write_seq.write_addr = 32'h00000004;
    write_seq.write_data = 32'hffff0000;
    write_seq.start(environment.agent.sequencer);
    


    //READ REGISTER WITHOUT RAL MODEL
    //REGISTER 1
    read_seq.read_addr = 32'h00000000;
    read_seq.start(environment.agent.sequencer);
    
    //REGISTER3
    read_seq.read_addr = 32'h00000008;
    read_seq.start(environment.agent.sequencer);
    
    
    phase.drop_objection(this);
  endtask
  
  
  
  // connect phase
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction
  
  // set default configuration
  function void set_default_configuration();
    super.set_default_configuration();
  endfunction

endclass 

