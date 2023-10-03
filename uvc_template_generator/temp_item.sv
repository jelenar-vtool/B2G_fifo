
class temp_item#(int ADDR = 32, int DATA = 32) extends uvm_sequence_item; 
    
// * * * Add fields bellow * * * 

// * * * Add constraints * * *

//-------------------------------------------------------------------
// Shorthand macros
//-------------------------------------------------------------------

// * * * Register variables in factory * * * 
    `uvm_object_utils_begin(temp_item) 

    `uvm_object_utils_end
    extern function new(string name = "temp_item");
endclass // temp_item

function temp_item::new(string name = "temp_item");
    super.new(name);
endfunction 

