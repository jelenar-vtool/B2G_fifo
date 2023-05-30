
class fifo_monitor extends uvm_monitor; 
   
   `uvm_component_utils(fifo_monitor)

   

   
    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase(uvm_phase phase);  
    extern virtual task  do_monitor();
    
endclass 

//-------------------------------------- 
//-----------------------------------------------------------------------
function fifo_monitor::new (string name, uvm_component parent);

    super.new(name, parent);

endfunction   

//-------------------------------------------------------------------------------------------------------------
function void fifo_monitor::build_phase(uvm_phase phase);

    super.build_phase(phase);
   
endfunction

//-------------------------------------------------------------------------------------------------------------
task  fifo_monitor::run_phase(uvm_phase phase);
    

endtask

//-------------------------------------------------------------------------------------------------------------
task fifo_monitor::do_monitor();
    // * * * ADD SAMPLING LOGIC HERE * * *


endtask
