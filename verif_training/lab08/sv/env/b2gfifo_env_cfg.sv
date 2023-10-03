/*
    * * * Environment configuration class. By default it just defines that env will have 2 angets, and creates two agent configurations. One agent will be Master, other will
          be Slave.
          Add or remove fields and constraints to meet your specific needs.
*/
class b2gfifo_env_cfg extends uvm_object;       
    
    
    b2gfifo_cfg slave_config;
    b2gfifo_cfg master_config;    
    int has_master_agent_1;
    int has_slave_agent_1;
    

    extern function new(string name = "b2gfifo_env_cfg");
    `uvm_object_utils_begin(b2gfifo_env_cfg)
        //`uvm_field_object(b2gfifo_config, UVM_ALL_ON)
        `uvm_field_object(master_config, UVM_ALL_ON)
        `uvm_field_object(slave_config, UVM_ALL_ON)
        `uvm_field_int(has_master_agent_1, UVM_ALL_ON )
        `uvm_field_int(has_slave_agent_1, UVM_ALL_ON)      
    `uvm_object_utils_end
endclass

function b2gfifo_env_cfg::new(string name = "b2gfifo_env_cfg");
    super.new(name);
    master_config = b2gfifo_cfg::type_id::create ("master_config");
    slave_config = b2gfifo_cfg::type_id::create ("slave_config");
    
endfunction


