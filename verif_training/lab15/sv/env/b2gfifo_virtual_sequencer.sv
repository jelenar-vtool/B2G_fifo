//typedef class b2gfifo_env;


class b2gfifo_virtual_sequencer extends uvm_sequencer  #(uvm_sequence_item);
    // TODO: * * * Declare the sequencer handle * * *
    
    // TODO: * * * Add to factory * * *

    // TODO: * * * Declare and define other necessary tasks and functions * * *
    `uvm_component_utils(b2gfifo_virtual_sequencer)

    
    b2gfifo_master_sequencer seqr;
    //b2gfifo_env       	    p_env; // if pointer to env is needed

   //add additional tlm ports/events/queues/variables..

    function new(string name, uvm_component parent);
   	 super.new(name,parent);
    endfunction

endclass : b2gfifo_virtual_sequencer
