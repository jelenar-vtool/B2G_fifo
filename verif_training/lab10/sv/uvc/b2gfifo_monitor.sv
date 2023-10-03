//-------------------------------------------------------------------------------------------------------------
class b2gfifo_monitor extends uvm_monitor; 
   
    //TODO: * * * Register the monitor class within the UVM factory * * *

    //TODO: * * * Declare the virtual interface handle * * *
   
    //TODO: * * * Declare the sampled transaction handle * * *
        
    uvm_analysis_port#(b2gfifo_item)   b2gfifo_mon_analysis_port;
    
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase(uvm_phase phase);  
    
endclass // b2gfifo_monitor_class

//-------------------------------------------------------------------------------------------------------------//-------------------------------------------------------------------------------------------------------------
function b2gfifo_monitor::new (string name, uvm_component parent);
    super.new(name, parent);
    
    //TODO: * * * Instantiate the sampled transaction handle * * *
endfunction   

//-------------------------------------------------------------------------------------------------------------
function void b2gfifo_monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    //TODO: * * * Retrieve the virtual interface handle from config db * * *

    b2gfifo_mon_analysis_port = new("b2gfifo_mon_analysis_port",this);
endfunction

//-------------------------------------------------------------------------------------------------------------
task b2gfifo_monitor::run_phase(uvm_phase phase);

	//TODO: * * * Write the transaction sampling logic * * *     
	
	//TODO: * * * Send the sampled transaction using write() * * *
	
endtask
