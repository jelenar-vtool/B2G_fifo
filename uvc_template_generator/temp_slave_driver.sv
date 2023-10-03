
class temp_slave_driver#(int ADDR = 32, int DATA = 32) extends uvm_driver #(temp_item);
    
    `uvm_component_utils(temp_slave_driver#(ADDR,DATA))
    virtual temp_if#(ADDR, DATA)   temp_vif;
    
    temp_cfg    cfg;
    bit reset_flag = 0;
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase (uvm_phase phase);
    extern virtual task  do_init ();
    extern virtual task  reset_on_the_fly();
    extern virtual task  do_drive(temp_item req);
    
endclass // temp_slave_driver

//-------------------------------------------------------------------------------------------------------------
function temp_slave_driver::new(string name, uvm_component parent);
    super.new(name, parent);
endfunction // temp_slave_driver::new

//-------------------------------------------------------------------------------------------------------------
function void temp_slave_driver::build_phase(uvm_phase phase);
    super.build_phase(phase); 
    `uvm_info("build_phase","BUILD temp_slave_DRIVER",UVM_HIGH);
    if(!uvm_config_db#(virtual temp_if#(ADDR, DATA))::get(this, "", "temp_vif", temp_vif)) 
        `uvm_fatal("build_phase",{"virtual interface must be set for: ", get_full_name(),".temp_vif"});
    if (!uvm_config_db#(temp_cfg)::get(this, "", "cfg", cfg)) begin
        `uvm_fatal("build_phase", "cfg wasn't set through config db");
    end
endfunction // temp_slave_driver::build_phase

//-------------------------------------------------------------------------------------------------------------
task temp_slave_driver::run_phase(uvm_phase phase);
    do_init();
	@(posedge temp_vif.reset_n);
	repeat(3) @(posedge temp_vif.system_clock);

	
    forever begin 
        seq_item_port.get_next_item(req);
        
        // delete if bellow if UVC dosen't have reset on fly feature 
        if (reset_flag) begin 
            @(posedge temp_vif.reset_n); // wait for reset to end
	        repeat(3) @(posedge temp_vif.system_clock); // wait 3 more clock cycles, just to be sure we're stable
            reset_flag = 0;
        end

        fork 
            reset_on_the_fly(); // delete this and fork if UVC dosen't have reset on fly feature
            do_drive(req);
        join_any
        disable fork;
			
        seq_item_port.item_done();  

    end   // of forever
endtask// temp_slave_driver::run_phase

//-------------------------------------------------------------------------------------------------------------
task temp_slave_driver::do_init();
// * * * Write initial values for your signals here * * *
    @(posedge temp_vif.system_clock);  
    `uvm_info("Driver", "do_init task executed", UVM_LOW)
endtask

task temp_slave_driver::do_drive(temp_item req);
// * * * Write driving logic here * * *
    @(posedge temp_vif.system_clock);  
     `uvm_info("Driver", "do_drive task executed", UVM_LOW)
endtask


task temp_slave_driver::reset_on_the_fly();
    // * * * Leave this untoched if planning to implement Reset on the fly feature. If not delete it. * * *
    @(negedge temp_vif.reset_n);
    reset_flag = 1;
endtask

