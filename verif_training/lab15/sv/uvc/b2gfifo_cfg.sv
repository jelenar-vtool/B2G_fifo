class b2gfifo_cfg extends uvm_object;  

    // TODO: * * * Declare all the config fields * * *
  uvm_active_passive_enum c_is_active;
    bit                   has_coverage;

  virtual b2gfifo_if b2gfifo_vif;
  `uvm_object_utils_begin(b2gfifo_cfg)
    `uvm_field_enum (uvm_active_passive_enum, c_is_active, UVM_ALL_ON)
    `uvm_field_int  (has_coverage,                       UVM_ALL_ON)
  `uvm_object_utils_end
    
    // TODO: * * * Register all the config fields with the factory* * *

    
    extern function new(string name = "b2gfifo_cfg");
    
    // TODO: * * * Define the set_default_config function * * *
   function void set_default_config();
	c_is_active= UVM_ACTIVE;
	has_coverage =1;
   endfunction 

endclass : b2gfifo_cfg

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_cfg::new(string name = "b2gfifo_cfg");
    super.new(name);
endfunction : new

