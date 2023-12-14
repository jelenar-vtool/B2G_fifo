class b2gfifo_item extends uvm_sequence_item; 
    
    //Add the transaction fields

   rand bit enable;
   rand bit write;
   rand bit read;
   rand bit [7:0] wdata;
   rand bit [1:0] addr;
    bit [7:0] rdata;
    bit resp;
   `uvm_object_utils_begin (b2gfifo_item)
	`uvm_field_int(enable, UVM_ALL_ON)
  	`uvm_field_int(write, UVM_ALL_ON)
	`uvm_field_int(read, UVM_ALL_ON)
  	`uvm_field_int(wdata, UVM_ALL_ON)
	`uvm_field_int(addr, UVM_ALL_ON)
	`uvm_field_int(rdata, UVM_ALL_ON)
   `uvm_object_utils_end
    //Add constraints 
  constraint wr_rd_c { write != read; }


    //TODO: * * * Register transaction fields ito the factory * * * 

    extern function new(string name = "b2gfifo_item");
endclass : b2gfifo_item

function b2gfifo_item::new(string name = "b2gfifo_item");
    super.new(name);
endfunction : new
