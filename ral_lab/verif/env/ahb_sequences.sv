class ahb_sequence extends uvm_sequence #(ahb_sequence_item);
  
  // registration macro
  `uvm_object_utils(ahb_sequence)

  // fields
  rand bit       s_HWRITE;
  rand bit[2:0]  s_HBURST;
  rand bit[2:0]  s_HSIZE;
  rand bit[31:0] s_HADDR;
  rand bit[31:0] s_HWDATA;
       bit[31:0] s_HRDATA;
       bit[1:0]  s_HTRANS;
  
  //constraints
  constraint s_default_c { soft s_HWRITE == 1;
  						             soft s_HADDR  == 32'h1000_0000;
                           soft s_HWDATA == 8;
                           soft s_HSIZE  == 2;
                           soft s_HBURST == 0;
    					           }

  // constructor
function new(string name = "ahb_sequence");
  super.new(name);
endfunction : new

  // body task
virtual task body();
  req = ahb_sequence_item::type_id::create("req");
    
  start_item(req);

  if(!req.randomize() with {
 		    HWRITE == s_HWRITE;
  		  HSIZE  == s_HSIZE;
  		  HADDR  == s_HADDR;
  		  HWDATA == s_HWDATA;
       	HRDATA == s_HRDATA;
       	HTRANS == s_HTRANS;
    }) begin
    `uvm_fatal(get_type_name(), "Failed to randomize.")
  end
  
  finish_item(req);
  
endtask : body
  
endclass



// ************************************************************************
// WRITE SEQUENCE 
// ************************************************************************

class ahb_write_sequence extends uvm_sequence #(ahb_sequence_item);
  
  // registration macro
  `uvm_object_utils(ahb_write_sequence)

  // fields
  rand bit [31:0] write_addr;
  rand bit [31:0] write_data;

  // constructor
function new(string name = "ahb_write_sequence");
  super.new(name);
endfunction : new

  // body task
virtual task body();
  `uvm_do_with(req,{req.HWRITE == 1; req.HADDR == write_addr; req.HWDATA == write_data; req.HSIZE == 2; req.HBURST == 0;})
endtask

endclass



// ************************************************************************
// READ SEQUENCE 
// ************************************************************************

class ahb_read_sequence extends uvm_sequence #(ahb_sequence_item);
  
  // registration macro
  `uvm_object_utils(ahb_read_sequence)

  // fields
  rand bit [31:0] read_addr;

  // constructor
function new(string name = "ahb_read_sequence");
  super.new(name);
endfunction : new

  // body task
virtual task body();
  `uvm_do_with(req,{req.HWRITE == 0; req.HADDR == read_addr; req.HSIZE == 2; req.HBURST == 0;})
endtask

endclass
