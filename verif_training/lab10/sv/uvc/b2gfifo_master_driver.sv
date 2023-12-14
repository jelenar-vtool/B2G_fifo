class b2gfifo_master_driver extends uvm_driver #(b2gfifo_item);
    
    //Register the driver class to the factory 
     `uvm_component_utils(b2gfifo_master_driver)

    //Declare the virtual interface handle 
    virtual b2gfifo_if b2gfifo_vif;
    b2gfifo_item req;

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
   
    //Retrieve the interface from the config_db 
	if(!uvm_config_db#(virtual b2gfifo_if)::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin
          `uvm_fatal("", "uvm_config_db::get failed")
       end

   
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::run_phase(uvm_phase phase);
    do_init();
     @(posedge b2gfifo_vif.rst_n);
       forever begin


       repeat(3) @(posedge b2gfifo_vif.clk);
 	
        seq_item_port.get_next_item( req );
          do_drive(  );
          seq_item_port.item_done();

   //Code run phase - use do_drive() to execute driving of signals * * *
	end 
endtask : run_phase

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::do_init();
    // Write initial values for your signals here * * *
    b2gfifo_vif.enable =0;
    b2gfifo_vif.addr = 2'b00;
    b2gfifo_vif.write = 1;
    b2gfifo_vif.read= 0;
    b2gfifo_vif.resp =0;
    b2gfifo_vif.wdata =8'b00101111;
    @(posedge b2gfifo_vif.clk);
    `uvm_info("Driver", "do_init task executed", UVM_LOW)
endtask : do_init

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_master_driver::do_drive();
    b2gfifo_vif.write <= req.write;
    b2gfifo_vif.addr  <= req.addr;
    b2gfifo_vif.wdata <=req.wdata;
    b2gfifo_vif.read <= req.read;

  	@(posedge b2gfifo_vif.clk);

     b2gfifo_vif.enable =1;
    `uvm_info("Driver", "do_drive task is being executed", UVM_LOW)
endtask : do_drive
