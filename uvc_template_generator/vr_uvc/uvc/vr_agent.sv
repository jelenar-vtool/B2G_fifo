
class vr_agent#(parameter int DATA = 32) extends uvm_agent;
    
    `uvm_component_utils(vr_agent#(DATA))

    virtual vr_if#(DATA) vr_vif;
      
    vr_cfg                 cfg;
    vr_monitor#(DATA)            m_mon;
    vr_master_driver#(DATA)       m_drv;
    vr_master_sequencer    m_seqr;
    vr_slave_driver#(DATA)        s_drv;
    vr_slave_sequencer     s_seqr;
   
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass //vr_agent

//-------------------------------------------------------------------------------------------------------------
function vr_agent::new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("vr_agent", "vr UVC", UVM_LOW);
endfunction

//-------------------------------------------------------------------------------------------------------------
function void vr_agent::build_phase(uvm_phase phase);
    
    super.build_phase(phase);

    if (!uvm_config_db#(virtual vr_if#(DATA))::get(this, "*", "vr_vif", vr_vif)) begin
        `uvm_fatal("build_phase_vr_agent", "interface was not set");
    end else 
        `uvm_info("build_phase_vr_agent", "vr_if was set through config db", UVM_LOW); 

    `uvm_info("AGENT", $sformatf("cfg.agent_type = %0b", cfg.agent_type), UVM_LOW)

     if (get_is_active() == UVM_ACTIVE && cfg.agent_type == MASTER) begin // Agent is configured as Master
        this.m_drv = vr_master_driver#( DATA)::type_id::create("m_drv",this);
        this.m_seqr = vr_master_sequencer::type_id::create("m_seqr",this);
        `uvm_info("build_phase_master_agent", "Master driver and sequencer created.", UVM_LOW);
    end 
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == SLAVE) begin // Agent is configured as Slave
        this.s_drv = vr_slave_driver#(DATA)::type_id::create("s_drv",this);
        this.s_seqr = vr_slave_sequencer::type_id::create("s_seqr",this);
        `uvm_info("build_phase_master_agent", "Slave driver and sequencer created.", UVM_LOW);
    end 
    m_mon = vr_monitor#(DATA)::type_id::create("m_mon", this);
    //print_config();
endfunction // vr_master_agent::buid_phase

//-------------------------------------------------------------------------------------------------------------
function void vr_agent::connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == MASTER) begin  //
        m_drv.seq_item_port.connect(m_seqr.seq_item_export);
        `uvm_info("connect_phase_vr_agent", "master driver connected.", UVM_LOW);
    end
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == SLAVE) begin  //
        s_drv.seq_item_port.connect(s_seqr.seq_item_export);
        `uvm_info("connect_phase_vr_agent", "slave driver connected.", UVM_LOW);
    end
   //  vr_vif.apb_baud_rate_value <= cfg.apb_baud_rate_divisor;
endfunction // vr_agent::connect_phase
