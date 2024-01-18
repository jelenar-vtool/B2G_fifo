class b2gfifo_base_test extends uvm_test;
   // Add to factory 
      `uvm_component_utils (b2gfifo_base_test) 
    // TODO: * * * Declare test components and objects * * *
    b2gfifo_env m_env;
    b2gfifo_env_cfg m_env_cfg;
	b2gfifo_empty_sequence  ms_seq;
    extern function new(string name = "b2gfifo_base_test", uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function  b2gfifo_base_test::new(string name = "b2gfifo_base_test", uvm_component parent);
	super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_base_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
     // TODO: * * * Instantitate test components and objects * * *

    // TODO: * * * Apply default configuration to all components and objects * * *
    
    // TODO: * * * Set the environment configuration to config_db * * *
    // Create and setup configuration objects:



    m_env = b2gfifo_env::type_id::create("m_env", this);
    m_env_cfg = b2gfifo_env_cfg::type_id::create("m_env_cfg", this);

    m_env_cfg.set_default_config();
    
    uvm_config_db#(b2gfifo_env_cfg)::set(this, "m_env", "m_env_cfg", m_env_cfg);
    
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_base_test::run_phase(uvm_phase phase);
       phase.raise_objection(this);
       ms_seq=b2gfifo_empty_sequence::type_id::create("ms_seq");
       ms_seq.start(m_env.m_agent.sequencer);
      phase.phase_done.set_drain_time(this, 100ns);
       phase.drop_objection(this);
endtask





