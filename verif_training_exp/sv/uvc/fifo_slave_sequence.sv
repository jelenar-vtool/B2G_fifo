
class fifo_slave_sequence extends uvm_sequence #(fifo_item);
 
    `uvm_object_utils(fifo_slave_sequence)

    extern function new(string name = "fifo_slave_sequence");
    extern virtual task body();  
endclass // fifo_slave_sequence

//-------------------------------------------------------------------
function fifo_slave_sequence::new(string name = "fifo_slave_sequence");

    super.new(name);

endfunction //fifo_sequence::new

//-------------------------------------------------------------------
task fifo_slave_sequence::body();
    

endtask 

