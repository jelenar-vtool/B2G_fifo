
class fifo_item extends uvm_sequence_item; 
    
// * * * Add fields bellow * * * 

// * * * Add constraints * * *

//-------------------------------------------------------------------
// Shorthand macros
//-------------------------------------------------------------------

// * * * Register variables in factory * * * 
    `uvm_object_utils_begin(fifo_item) 

    `uvm_object_utils_end
    extern function new(string name = "fifo_item");
endclass // fifo_item

function fifo_item::new(string name = "fifo_item");

    super.new(name);

endfunction 

