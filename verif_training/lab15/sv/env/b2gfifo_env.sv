//------------------------------------------------------------------------------------------------------------
class b2gfifo_env extends uvm_env;
    `uvm_component_utils(b2gfifo_env)

    //Declare the agent and register env to factory * * *
   b2gfifo_env_cfg m_env_cfg; 
   b2gfifo_cfg cfg;
   virtual interface b2gfifo_if b2gfifo_vif;
   virtual interface b2gfifo_topvif b2gfifo_topif;
   // agent
   b2gfifo_agent m_agent; 
   b2gfifo_monitor    m_monitor;
   b2gfifo_scoreboard scbd;
  // other components
   b2gfifo_virtual_sequencer m_virt_seqr;
   b2gfifo_master_sequencer m_master_seqr;
 //ral
 b2gfifo_reg_block  regmodel;   
  b2gfifo_reg2bus    m_adapter;
  uvm_reg_predictor #(b2gfifo_item) m_apb2reg_predictor;

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
	uvm_config_db#(b2gfifo_cfg)::set(this,"*","cfg", cfg);  
   if(!uvm_config_db#(virtual b2gfifo_topvif)::get(this, "", "b2gfifo_topif", b2gfifo_topif)) begin
      `uvm_fatal(get_type_name(), {"virtual interface must be set for:  b2gfifo_topif"});
   end 
 if(!uvm_config_db#(virtual b2gfifo_if)::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin
      `uvm_fatal(get_type_name(), {"virtual interface must be set for:  b2gfifo_vif"});
   end 
   if(!uvm_config_db#(b2gfifo_env_cfg)::get(this, "", "m_env_cfg", m_env_cfg)) begin
     `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
   end
   
   // create system top env components
  m_agent  = b2gfifo_agent::type_id::create("m_agent", this);
  cfg  = b2gfifo_cfg::type_id::create("cfg", this);
  m_monitor  = b2gfifo_monitor::type_id::create("m_monitor", this);
   scbd        = b2gfifo_scoreboard::type_id::create("scbd", this);
   m_virt_seqr   = b2gfifo_virtual_sequencer::type_id::create ("m_virt_seqr", this);
   m_master_seqr   = b2gfifo_master_sequencer::type_id::create ("m_master_seqr", this);
   m_agent.cfg  = m_env_cfg.cfg; //connect agent cfg with cfg from env

  regmodel = b2gfifo_reg_block::type_id::create("regmodel", this);
        m_adapter   = b2gfifo_reg2bus::type_id::create("m_adapter");
        m_apb2reg_predictor = uvm_reg_predictor#(b2gfifo_item)::type_id::create("m_apb2reg_predictor", this);        
        regmodel.build();

        uvm_config_db #(b2gfifo_reg_block)::set(null, "*", "regmodel", regmodel);
        


endfunction : build_phase 

//------------------------------------------------------------------------------------------------------------ 
function void b2gfifo_env:: connect_phase (uvm_phase phase);
    super.connect_phase(phase);
        // m_virt_seqr.p_env    = this;
   	 m_virt_seqr.seqr = m_agent.sequencer;
    	 //m_agent.m_monitor.a_port.connect(m_virt_seqr);
       m_agent.m_monitor.b2gfifo_mon_analysis_port.connect (scbd.m_ap);//da se def analsis port?
        m_apb2reg_predictor.map = regmodel.default_map;
        m_apb2reg_predictor.adapter = m_adapter;
        m_agent.m_monitor.b2gfifo_mon_analysis_port.connect(m_apb2reg_predictor.bus_in);
		regmodel.add_hdl_path("$root.top.m_dut0");

        regmodel.default_map.set_sequencer(m_agent.sequencer, m_adapter);
        regmodel.default_map.set_base_addr(8'h3);	
		
endfunction : connect_phase
