class b2gfifo_virtual_sequence extends uvm_sequence #(uvm_sequence_item);
    // TODO: * * * Add to factory * * *
    `uvm_object_utils(b2gfifo_virtual_sequence)
   `uvm_declare_p_sequencer(b2gfifo_virtual_sequencer)

   b2gfifo_basic_sequence seq1;
  b2gfifo_multiple_delayed_items_sequence seq2;
 b2gfifo_test_sequence seq3;
  
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
	//`uvm_do_on(seq1, p_sequencer.seqr)
	//`uvm_do_on(seq2, p_sequencer.seqr)   
	`uvm_do_on(seq3, p_sequencer.seqr)               
endtask : body
