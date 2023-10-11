class b2gfifo_basic_sequence extends uvm_sequence #(b2gfifo_item);
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    
   
    extern function new(string name = "b2gfifo_basic_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_master_sequence

//-------------------------------------------------------------------
function b2gfifo_basic_sequence::new(string name = "b2gfifo_basic_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_basic_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
endtask : body



//-------------------------------------------------------------------
//-------------------------------------------------------------------
class b2gfifo_multiple_delayed_items_sequence extends uvm_sequence #(b2gfifo_item);
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *   
    
    extern function new(string name = "b2gfifo_multiple_delayed_items_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_multiple_delayed_items_sequence

//-------------------------------------------------------------------
function b2gfifo_multiple_delayed_items_sequence::new(string name = "b2gfifo_multiple_delayed_items_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_multiple_delayed_items_sequence::body();
     // TODO: * * * Create an instance of a basic_sequence * * * 
     
     // TODO: * * * Randomize and start the basic_sequence sequence * * *
     //       * * * Use the fields defined in this sequence to randomize the basic sequence * * *
endtask : body
