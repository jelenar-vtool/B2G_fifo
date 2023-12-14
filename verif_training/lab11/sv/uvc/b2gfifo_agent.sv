class b2gfifo_agent extends uvm_agent;
    //Register the agent class to the factory * * *

    // Declare the agent subcomponents * * *
      b2gfifo_master_driver    driver;
      b2gfifo_master_sequencer sequencer;
      b2gfifo_monitor    monitor;
    //Declare the agent's configuration object (cfg) * * *
     virtual b2gfifo_if b2gfifo_vif;
     b2gfifo_cfg cfg;
      `uvm_component_utils(b2gfifo_agent)

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass : b2gfifo_agent

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_agent::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);

    //TODO: * * * Get agent's configuration from config_db  * * *
    //TODO: * * * Use "cfg" as instance name and as name to get from config_db

    //TODO: * * * Instantiate the components based on agent's configuration * * *
// get virtual interface handler
    if(!uvm_config_db #(virtual b2gfifo_if )::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
    end  

// get configuration 
    if(!uvm_config_db #(b2gfifo_cfg)::get(this, "", "cfg", cfg)) begin 
       `uvm_fatal("", "Failed to get configuration object !");
    end 

 // create components
    if(cfg.c_is_active == UVM_ACTIVE) begin
      driver = b2gfifo_master_driver::type_id::create("driver", this);
      sequencer = b2gfifo_master_sequencer::type_id::create("sequencer", this);
    end

    monitor = b2gfifo_monitor::type_id::create("monitor", this);

endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_agent::connect_phase(uvm_phase phase);
    //TODO: * * * Connect the driver to the sequencer * * * 
 super.connect_phase(phase); 

// connect ports 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
     driver.seq_item_port.connect(sequencer.seq_item_export); 
  end 

// assign interface 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
     driver.b2gfifo_vif=b2gfifo_vif; 
  end 

  monitor.b2gfifo_vif = b2gfifo_vif; 

// assign configuration 
  if (cfg.c_is_active == UVM_ACTIVE) begin 
    driver.cfg = cfg; 
    sequencer.cfg = cfg; 
  end 
  monitor.cfg = cfg; 

endfunction : connect_phase
