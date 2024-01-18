class b2gfifo_item extends uvm_sequence_item; 
    
   rand bit enable;
   rand bit write;
   rand bit read;
   rand bit [7:0] wdata;
   rand bit [1:0] addr;
   rand bit [31:0] delay;
    bit [7:0] rdata;
    bit resp;
   `uvm_object_utils_begin (b2gfifo_item)
	`uvm_field_int(enable, UVM_ALL_ON)
  	`uvm_field_int(write, UVM_ALL_ON)
	`uvm_field_int(read, UVM_ALL_ON)
  	`uvm_field_int(wdata, UVM_ALL_ON)
	`uvm_field_int(addr, UVM_ALL_ON)
	`uvm_field_int(delay, UVM_ALL_ON)
  	
   `uvm_object_utils_end
 	extern function new(string name = "b2gfifo_item"); 
	constraint wr_rd_c {soft  write != read;  }
	constraint delay_c { delay< 10;}
   	constraint w_addr3_c {if(addr == 2'b11) (wdata[5] ==0);(wdata[6] ==0);(wdata[7] ==0); }


endclass : b2gfifo_item

function b2gfifo_item::new(string name = "b2gfifo_item");
    super.new(name);
endfunction : new
