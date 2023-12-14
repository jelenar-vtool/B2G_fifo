class b2gfifo_item extends uvm_sequence_item; 
    
    //TODO: * * * Add the transaction fields * * * 
   `uvm_object_utils(b2gfifo_item)
   rand bit enable;
   rand bit write;
   rand bit read;
   rand bit [7:0] wdata;
   rand bit [1:0] addr;

    //TODO: * * * Add constraints * * *
  constraint wr_rd_c { write != read; } 


    //TODO: * * * Register transaction fields ito the factory * * * 

    extern function new(string name = "b2gfifo_item");
endclass : b2gfifo_item

function b2gfifo_item::new(string name = "b2gfifo_item");
    super.new(name);
endfunction : new
