class b2gfifo_item extends uvm_sequence_item; 
    
    //TODO: * * * Add the transaction fields * * * 

    //TODO: * * * Add constraints * * *

    //TODO: * * * Register transaction fields ito the factory * * * 

    extern function new(string name = "b2gfifo_item");
endclass : b2gfifo_item

function b2gfifo_item::new(string name = "b2gfifo_item");
    super.new(name);
endfunction : new

