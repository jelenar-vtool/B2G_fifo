class ahb_agent extends uvm_agent;
  
  `uvm_component_utils(ahb_agent)
  
  uvm_analysis_port#(ahb_sequence_item) agent_export;
  
  ahb_driver      driver;
  ahb_monitor     monitor;
  ahb_sequencer   sequencer;
  //TO_DO

  function new(string name="ahb_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = ahb_driver::type_id::create("driver",this);
    monitor = ahb_monitor::type_id::create("monitor",this);
    sequencer = ahb_sequencer::type_id::create("sequencer",this);
    //TO_DO
  endfunction
  
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent_export = monitor.p_mon_port;
    driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction
  
  
endclass
