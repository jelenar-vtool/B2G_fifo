//------------------------------------------------------------------------------------------------------------
class b2gfifo_env extends uvm_env;
    `uvm_component_utils(b2gfifo_env)

    //Declare the agent and register env to factory * * *
   b2gfifo_env_cfg m_env_cfg; 
   virtual interface b2gfifo_if b2gfifo_vif;
   // agent
   b2gfifo_agent m_agent; 
   b2gfifo_monitor    m_monitor;
   b2gfifo_scoreboard scbd;
  // other components
   b2gfifo_virtual_sequencer m_virt_seqr;

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
endclass : b2gfifo_env

//------------------------------------------------------------------------------------------------------------
function b2gfifo_env::new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//------------------------------------------------------------------------------------------------------------
function void b2gfifo_env:: build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    // TODO: * * * instantiate the agent * * *
	m_env_cfg=new();

   if(!uvm_config_db#(virtual b2gfifo_if)::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin
      `uvm_fatal(get_type_name(), {"virtual interface must be set for:  b2gfifo_vif"});
   end 
   /*if(!uvm_config_db#(b2gfifo_env_cfg)::get(this, "", "cfg", m_env_cfg)) begin
     `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
   end*/
   
   // create system top env components
  m_agent  = b2gfifo_agent::type_id::create("m_agent", this);
  m_monitor  = b2gfifo_monitor::type_id::create("m_monitor", this);
   scbd        = b2gfifo_scoreboard::type_id::create("scbd", this);
   m_virt_seqr   = b2gfifo_virtual_sequencer::type_id::create ("m_virt_seqr", this);
   m_agent.cfg  = m_env_cfg.m_agent_cfg; //connect agent cfg with cfg from env



endfunction : build_phase 

//------------------------------------------------------------------------------------------------------------ 
function void b2gfifo_env:: connect_phase (uvm_phase phase);
    super.connect_phase(phase);
        // m_virt_seqr.p_env    = this;
   	 m_virt_seqr.seqr = m_agent.sequencer;
    	 //m_agent.m_monitor.a_port.connect(m_virt_seqr);
  m_agent.m_monitor.b2gfifo_mon_analysis_port.connect (scbd.m_ap);//da se def analsis port?
endfunction : connect_phase
