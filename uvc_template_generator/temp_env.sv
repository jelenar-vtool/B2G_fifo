/*
      * * * Environment class, by default creates two agents and scoreboard.
            One agent is configured as Master, other as Slave.
            Both agent's monitors are connected to Scoreboards through Analysis ports.
            Feel free to adapt ENV to meet your specific needs.
*/


class temp_env extends uvm_env;

    `uvm_component_param_utils(temp_env)

    temp_env_cfg cfg_env;
    temp_agent#(32,32) master_agent;
    temp_agent#(32,32) slave_agent;
    temp_sb sb; 

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);
    extern virtual function void print_cfg();
endclass : temp_env

function temp_env :: new (string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

function void temp_env:: build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if (!uvm_config_db # (temp_env_cfg) :: get (this, "", "cfg_env", cfg_env)) begin
        `uvm_fatal (get_type_name(), "Failed to get the configuration file from the config DB!")
    end 
    
    master_agent = temp_agent#(32,32) :: type_id :: create ("master_agent", this);
    slave_agent = temp_agent#(32,32) :: type_id :: create ("slave_agent", this);

    master_agent.cfg = cfg_env.master_config;
    slave_agent.cfg = cfg_env.slave_config;

        

    sb = temp_sb::type_id::create("sb",this);
    

endfunction : build_phase 
 
function void temp_env:: connect_phase (uvm_phase phase);
    super.connect_phase(phase);
    //connect monitor to scb !!!
    if (cfg_env.has_master_agent == 1) begin
    master_agent.m_mon.temp_mon_analysis_port.connect(sb.m_mon_imp);
    end
    if (cfg_env.has_slave_agent == 1) begin    
    slave_agent.m_mon.temp_mon_analysis_port.connect(sb.s_mon_imp); 
    end

endfunction : connect_phase

function void temp_env ::print_cfg();
   `uvm_info(get_type_name(), $sformatf ("The configuration that was set : \n%s", cfg_env.sprint()), UVM_MEDIUM)
endfunction : print_cfg


