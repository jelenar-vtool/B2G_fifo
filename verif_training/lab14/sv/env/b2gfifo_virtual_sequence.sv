class b2gfifo_virtual_sequence extends uvm_sequence #(b2gfifo_item);
    // TODO: * * * Add to factory * * *
    
    extern function new(string name = "b2gfifo_virtual_sequence");
    extern virtual task body();      
endclass : b2gfifo_virtual_sequence

//-------------------------------------------------------------------
function b2gfifo_virtual_sequence::new(string name = "b2gfifo_virtual_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_virtual_sequence::body();
	 // TODO: * * * Create an instance of each sequence defined in part 1 and 2 * * *
 	 // TODO: * * * Instantiate, randomize and start both sequences * * *
endtask : body
