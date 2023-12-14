//-------------------------------------------------------------------------------------------------------------
class b2gfifo_monitor extends uvm_monitor; 
   
  
   //Register the monitor class within the UVM factory 
   `uvm_component_utils(b2gfifo_monitor)
    //Declare the virtual interface handle
     virtual b2gfifo_if b2gfifo_vif;
        virtual b2gfifo_topvif b2gfifo_topif;
    //Declare the sampled transaction handle * * *
    b2gfifo_item req;
    uvm_analysis_port#(b2gfifo_item)   b2gfifo_mon_analysis_port;
    b2gfifo_cfg cfg;
	

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase(uvm_phase phase);  
    
endclass // b2gfifo_monitor_class

//-------------------------------------------------------------------------------------------------------------//-------------------------------------------------------------------------------------------------------------
function b2gfifo_monitor::new (string name, uvm_component parent);
    super.new(name, parent);
   

    //TODO: * * * Instantiate the sampled transaction handle * * *
    req = b2gfifo_item::type_id::create("req");

    b2gfifo_mon_analysis_port = new("b2gfifo_mon_analysis_port", this);
  
endfunction   

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //TODO: * * * Retrieve the virtual interface handle from config db * * *
    if(!uvm_config_db#(virtual b2gfifo_if)::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin
      `uvm_fatal(get_type_name(),"NOVIF: call to uvm_config_db get method failed\n");
    end

   if(!uvm_config_db#(virtual b2gfifo_topvif)::get(this, "", "b2gfifo_topif", b2gfifo_topif)) begin
      `uvm_fatal(get_type_name(),"NOVIF: call to uvm_config_db get method failed\n");
    end
  if(!uvm_config_db #(b2gfifo_cfg)::get(this, "", "cfg", cfg)) begin 
       `uvm_fatal("", "Failed to get configuration object !");
    end

endfunction

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_monitor::run_phase(uvm_phase phase);

	//Write the transaction sampling logic      
	
	//Send the sampled transaction using write() 
  super.run_phase(phase);
forever begin
     @ (posedge b2gfifo_vif.clk);
  if (b2gfifo_vif.enable ==1) begin //mozes da stvais uslove, ako je read sta uzimas i ako je w sta uzimas, mogu poisebni alasis portovi ya write, read, resp
     
	if (b2gfifo_vif.write ==1)begin 
        req.write = b2gfifo_vif.write;
        req.read = b2gfifo_vif.read;  
        req.addr = b2gfifo_vif.addr;
        req.wdata = b2gfifo_vif.wdata;
        req.resp= b2gfifo_vif.resp; 
	`uvm_info("moiotr", "write is beging sent", UVM_LOW)      
	end else if(b2gfifo_vif.read==1) begin 
        req.read = b2gfifo_vif.read; 
        req.write = b2gfifo_vif.write; 
        req.rdata = b2gfifo_vif.rdata;
        req.resp= b2gfifo_vif.resp; 
        req.addr = b2gfifo_vif.addr;
	`uvm_info("monitor","read is begin sent", UVM_LOW)
	end       
        `uvm_info(get_type_name(), $sformatf("Monitor collected trans %s", req.sprint()), UVM_LOW)
        b2gfifo_mon_analysis_port.write(req);
    end
	
  end 
	 
endtask
