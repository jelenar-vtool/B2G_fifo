/*
    * * * Environment configuration class. By default it just defines that env will have 2 angets, and creates two agent configurations. One agent will be Master, other will
          be Slave.
          Add or remove fields and constraints to meet your specific needs.
*/
class temp_env_cfg extends uvm_object;       
    
    
    temp_cfg slave_config;
    temp_cfg master_config;    
    int has_master_agent_1;
    int has_slave_agent_1;
    

    extern function new(string name = "temp_env_cfg");
    `uvm_object_utils_begin(temp_env_cfg)
        //`uvm_field_object(temp_config, UVM_ALL_ON)
        `uvm_field_object(master_config, UVM_ALL_ON)
        `uvm_field_object(slave_config, UVM_ALL_ON)
        `uvm_field_int(has_master_agent_1, UVM_ALL_ON )
        `uvm_field_int(has_slave_agent_1, UVM_ALL_ON)      
    `uvm_object_utils_end
endclass

function temp_env_cfg::new(string name = "temp_env_cfg");
    super.new(name);
    master_config = temp_cfg::type_id::create ("master_config");
    slave_config = temp_cfg::type_id::create ("slave_config");
    
endfunction


