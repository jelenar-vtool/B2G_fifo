/*
* * * * *   AGENT CONFIGURATION     * * * * * 
    You can add specific fields for your agents here
*/

class fifo_cfg extends uvm_object;  

//  Enables protocol checks

//  Enables coverage  

//  Simulation timeout

//  Default constraints 
//------------------------------------------------------------------------------------------------------------
// Shorthand macros
//------------------------------------------------------------------------------------------------------------
    `uvm_object_utils_begin(fifo_cfg)

    `uvm_object_utils_end
    
    extern function new(string name = "fifo_cfg");

endclass // fifo_cfg

//-------------------------------------------------------------------------------------------------------------
function fifo_cfg::new(string name = "fifo_cfg");

    super.new(name);

endfunction // new


