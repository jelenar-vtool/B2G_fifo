class b2gfifo_env_cfg extends uvm_object;       

    // TODO: * * * Declare all the env config fields * * *
      b2gfifo_cfg   cfg;
       bit                     ms_has_checks;
       bit                     ms_has_coverage;
    // TODO: * * * Declare all the lower-level config objects * * *

    // TODO: * * * Register all the config fields with the factory* * *
    `uvm_object_utils_begin(b2gfifo_env_cfg)
      `uvm_field_object (cfg, UVM_ALL_ON)
      `uvm_field_int  (ms_has_checks, UVM_ALL_ON)
      `uvm_field_int  (ms_has_coverage, UVM_ALL_ON)
   `uvm_object_utils_end


    extern function new(string name = "b2gfifo_env_cfg");
    
    // TODO: * * * Define the set_default_config function * * *
   function void set_default_config(); 
	cfg.set_default_config();
     ms_has_checks=0;
     ms_has_checks=1;
   endfunction 
endclass

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_env_cfg::new(string name = "b2gfifo_env_cfg");
    super.new(name);
    // TODO: * * * Instantiate the lower-level config objects * * *
   cfg = b2gfifo_cfg::type_id::create ("cfg");

endfunction
