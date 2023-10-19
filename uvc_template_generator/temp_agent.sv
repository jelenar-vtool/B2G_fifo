
class temp_agent#(parameter int ADDR = 32,parameter int DATA = 32) extends uvm_agent;
    
    `uvm_component_utils(temp_agent#(ADDR,DATA))

    virtual temp_if#(ADDR, DATA) temp_vif;
      
    temp_cfg                 cfg;
    temp_monitor#(ADDR, DATA)            m_mon;
    temp_master_driver#(ADDR, DATA)       m_drv;
    temp_master_sequencer    m_seqr;
    temp_slave_driver#(ADDR, DATA)        s_drv;
    temp_slave_sequencer     s_seqr;
   
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    
endclass //temp_agent

//-------------------------------------------------------------------------------------------------------------
function temp_agent::new(string name, uvm_component parent);
    super.new(name, parent);
    `uvm_info("temp_agent", "temp UVC", UVM_LOW);
endfunction

//-------------------------------------------------------------------------------------------------------------
function void temp_agent::build_phase(uvm_phase phase);
    
    super.build_phase(phase);

    if (!uvm_config_db#(virtual temp_if#(ADDR, DATA))::get(this, "*", "temp_vif", temp_vif)) begin
        `uvm_fatal("build_phase_temp_agent", "interface was not set");
    end else 
        `uvm_info("build_phase_temp_agent", "temp_if was set through config db", UVM_LOW); 

    `uvm_info("AGENT", $sformatf("cfg.agent_type = %0b", cfg.agent_type), UVM_LOW)

     if (get_is_active() == UVM_ACTIVE && cfg.agent_type == MASTER) begin // Agent is configured as Master
        this.m_drv = temp_master_driver#(ADDR, DATA)::type_id::create("m_drv",this);
        this.m_seqr = temp_master_sequencer::type_id::create("m_seqr",this);
        `uvm_info("build_phase_master_agent", "Master driver and sequencer created.", UVM_LOW);
    end 
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == SLAVE) begin // Agent is configured as Slave
        this.s_drv = temp_slave_driver#(ADDR, DATA)::type_id::create("s_drv",this);
        this.s_seqr = temp_slave_sequencer::type_id::create("s_seqr",this);
        `uvm_info("build_phase_master_agent", "Slave driver and sequencer created.", UVM_LOW);
    end 
    m_mon = temp_monitor#(ADDR, DATA)::type_id::create("m_mon", this);
    //print_config();
endfunction // temp_master_agent::buid_phase

//-------------------------------------------------------------------------------------------------------------
function void temp_agent::connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == MASTER) begin  //
        m_drv.seq_item_port.connect(m_seqr.seq_item_export);
        `uvm_info("connect_phase_temp_agent", "master driver connected.", UVM_LOW);
    end
    if (get_is_active() == UVM_ACTIVE && cfg.agent_type == SLAVE) begin  //
        s_drv.seq_item_port.connect(s_seqr.seq_item_export);
        `uvm_info("connect_phase_temp_agent", "slave driver connected.", UVM_LOW);
    end
   //  temp_vif.temp_baud_rate_value <= cfg.temp_baud_rate_divisor;
endfunction // temp_agent::connect_phase

