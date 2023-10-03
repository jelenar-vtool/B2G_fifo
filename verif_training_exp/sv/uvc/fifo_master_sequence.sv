class fifo_master_sequence extends uvm_sequence #(fifo_item);
 
    `uvm_object_utils(fifo_master_sequence)
    
    extern function new(string name = "fifo_master_sequence");
    extern virtual task body();   

endclass // fifo_master_sequence

//-------------------------------------------------------------------
function fifo_master_sequence::new(string name = "fifo_master_sequence");
    super.new(name);
endfunction //fifo_sequence::new

//-------------------------------------------------------------------
task fifo_master_sequence::body();
    
endtask 


