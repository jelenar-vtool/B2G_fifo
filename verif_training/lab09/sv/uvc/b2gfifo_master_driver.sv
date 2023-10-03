class b2gfifo_master_driver extends uvm_driver #(b2gfifo_item);
    
    //TODO: * * * Register the driver class to the factory * * *
    
    //TODO: * * * Declare the virtual interface handle * * *

    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    
    extern virtual task do_init();
    extern virtual task do_drive();
    
endclass : b2gfifo_master_driver

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_master_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_master_driver::build_phase(uvm_phase phase);
    super.build_phase(phase); 
    `uvm_info("build_phase","BUILD b2gfifo_MASTER_DRIVER",UVM_HIGH);
   
    //TODO: * * * Retrieve the interface from the config_db * * *
   
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::run_phase(uvm_phase phase);
    do_init();
    
    @(posedge b2gfifo_vif.rst_n);
       repeat(3) @(posedge b2gfifo_vif.clk);

   //TODO: * * * Code run phase - use do_drive() to execute driving of signals * * *

endtask : run_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::do_init();
    //TODO: * * * Write initial values for your signals here * * *
    
    @(posedge b2gfifo_vif.clk);
    `uvm_info("Driver", "do_init task executed", UVM_HIGH)
endtask : do_init

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::do_drive();
    //TODO: * * * Write driving logic here * * *
    
    `uvm_info("Driver", "do_drive task is being executed", UVM_HIGH)
endtask : do_drive
