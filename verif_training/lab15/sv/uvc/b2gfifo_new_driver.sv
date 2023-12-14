class b2gfifo_new_driver extends b2gfifo_master_driver #(b2gfifo_item);
  
    //Register the driver class to the factory 
     `uvm_component_utils(b2gfifo_new_driver)

    //Declare the virtual interface handle 
    virtual b2gfifo_if b2gfifo_vif;
    b2gfifo_item req;
    b2gfifo_cfg cfg;
    extern function new(string name, uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    
    extern virtual task do_init();
    extern virtual task do_drive();
    
endclass : b2gfifo_master_driver
//-------------------------------------------------------------------------------------------------------------
function b2gfifo_new_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_new_driver::build_phase(uvm_phase phase);
    super.build_phase(phase); 
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_new_driver::run_phase(uvm_phase phase);
       super.run_phase(phase); 
endtask : run_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_new_driver::do_init();
          super.do_init(); 
endtask : do_init

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_new_driver::do_drive(); //najcesce aserseni ovde, da vide da li je drajver ispotovao protokol
    `uvm_info("Driver", "do_drive task is being executed", UVM_LOW)
    b2gfifo_vif.write <= req.write;
    b2gfifo_vif.addr  <= req.addr;
    b2gfifo_vif.wdata <=req.wdata;
    b2gfifo_vif.read <= req.read;
    b2gfifo_vif.enable <=1;

   @(posedge b2gfifo_vif.clk);
   b2gfifo_vif.enable <=0;

endtask : do_drive
