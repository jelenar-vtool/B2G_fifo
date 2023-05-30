/*
    * * * Environment configuration class. By default it just defines that env will have 2 angets, and creates two agent configurations. One agent will be Master, other will
          be Slave.
          Add or remove fields and constraints to meet your specific needs.
*/
class fifo_env_cfg extends uvm_object;       
    
    
    fifo_cfg slave_config;
    fifo_cfg master_config;    
    

    extern function new(string name = "fifo_env_cfg");
    `uvm_object_utils_begin(fifo_env_cfg)
        `uvm_field_object(master_config, UVM_ALL_ON)
        `uvm_field_object(slave_config, UVM_ALL_ON)
    `uvm_object_utils_end
endclass

function fifo_env_cfg::new(string name = "fifo_env_cfg");
    super.new(name);
    master_config = fifo_cfg::type_id::create ("master_config");
    slave_config = fifo_cfg::type_id::create ("slave_config");
    
endfunction


