class ahb_sequence_item extends uvm_reg_item;
  
  //fields
   rand bit       HWRITE;
   rand bit[2:0]  HBURST;
   rand bit[2:0]  HSIZE;
   rand bit[31:0] HADDR;
   rand bit[31:0] HWDATA;
        bit[31:0] HRDATA;
        bit[1:0]  HTRANS;

  `uvm_object_utils_begin(ahb_sequence_item)
    `uvm_field_int(HADDR,UVM_ALL_ON)
    `uvm_field_int(HWDATA,UVM_ALL_ON)
    `uvm_field_int(HRDATA,UVM_ALL_ON)
    `uvm_field_int(HBURST,UVM_ALL_ON)
    `uvm_field_int(HSIZE,UVM_ALL_ON)
    `uvm_field_int(HWRITE,UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="ahb_sequence_item");
    super.new(name);
  endfunction
  
  
endclass
