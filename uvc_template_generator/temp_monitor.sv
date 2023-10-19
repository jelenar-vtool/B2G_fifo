
class temp_monitor#(int ADDR = 32, int DATA = 32) extends uvm_monitor; 
   
   `uvm_component_utils(temp_monitor#(ADDR,DATA))

    virtual temp_if#(ADDR, DATA) temp_vif;
   
    //temp_coverage    cov;
    temp_item   temp_trans;

    temp_cfg         cfg;
   
    int counter;
    uvm_analysis_port#(temp_item)   temp_mon_analysis_port;
    //uvm_analysis_port #(temp_item)   temp_s_analysis_port;

   
    bit reset_flag = 0;
    
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase(uvm_phase phase);  
    extern virtual task  do_monitor();
    extern virtual task  reset_on_the_fly();
    
endclass // temp_monitor_class

//-------------------------------------- 
//-----------------------------------------------------------------------
function temp_monitor::new (string name, uvm_component parent);
    super.new(name, parent);
    temp_trans = temp_item::type_id::create("temp_trans", this);
endfunction   

//-------------------------------------------------------------------------------------------------------------
function void temp_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    `uvm_info("build_phase","BUILD temp_MONITOR",UVM_MEDIUM);
    if(!uvm_config_db#(virtual temp_if#(ADDR, DATA))::get(this, "", "temp_vif", temp_vif)) 
        `uvm_fatal("build_phase",{"virtual interface must be set for: ",get_full_name(),".temp_vif"});

    if (!uvm_config_db#(temp_cfg)::get(this, "", "cfg",cfg)) begin
        `uvm_fatal("build_phase", "cfg wasn't set through config db");
    end

    temp_mon_analysis_port = new("temp_mon_analysis_port",this);
 
    //if (cfg.has_coverage) begin
    //    cov = temp_coverage::type_id::create("temp_coverage",this);
    //    cov.cfg = this.cfg;
    //end  


    if (!cfg.has_checks)   
        `uvm_info("build_phase","CHECKERS DISABLED",UVM_LOW);
endfunction

//-------------------------------------------------------------------------------------------------------------
task  temp_monitor::run_phase(uvm_phase phase);
    
	//wait for reset
	@(posedge temp_vif.reset_n);
	repeat(3) @(posedge temp_vif.system_clock);
    forever begin
      // delete if bellow if UVC dosen't have reset on fly feature
      if (reset_flag) begin
            @(posedge temp_vif.reset_n); // wait for reset to end
	        repeat(3) @(posedge temp_vif.system_clock); // wait 3 more clock cycles, just to be sure we're stable
            reset_flag = 0;
        end

        fork 
            reset_on_the_fly(); // delete this and fork if UVC dosen't have reset on fly feature
            do_monitor();
        join_any
        disable fork;
    end // of forever       
endtask


//-------------------------------------------------------------------------------------------------------------
task temp_monitor::reset_on_the_fly();  
    // * * * Leave this untoched if planning to implement Reset on the fly feature. If not delete it. * * *   
    @(negedge temp_vif.reset_n);
    reset_flag = 1;
    `uvm_info("MONITOR","ASYNCHRONOUS RESET HAPPENED", UVM_LOW)
    
endtask //reset_on_the_fly*/

task temp_monitor::do_monitor();
    // * * * ADD SAMPLING LOGIC HERE * * *

    @(posedge temp_vif.system_clock);  
    `uvm_info("Monitor", "do_monitor task executed", UVM_LOW)

    //temp_mon_analysis_port.write(temp_trans); // sending sampled data to scoreboard
    //cov.temp_cg.sample(temp_trans); // sampling for coverage

endtask
