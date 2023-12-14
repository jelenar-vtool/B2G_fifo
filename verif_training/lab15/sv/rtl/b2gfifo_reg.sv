class b2gfifo_reg extends uvm_reg;
  `uvm_object_utils(b2gfifo_reg)
   
  //---------------------------------------
  // fields instance 
  //--------------------------------------- 
  rand uvm_reg_field fifo_empty;
  rand uvm_reg_field fifo_full;
  rand uvm_reg_field fifo_overflow;
  rand uvm_reg_field fifo_underflow;
  rand uvm_reg_field fifo_reg_write;

  //---------------------------------------
  // Constructor 
  //---------------------------------------   
  function new (string name = "b2gfifo_reg");
    super.new(name,8,UVM_NO_COVERAGE); //8 -> Register Width
  endfunction

  //---------------------------------------
  // build_phase - 
  // 1. Create the fields
  // 2. Configure the fields
  //---------------------------------------  
  function void build; 
    
    // Create bitfield
    fifo_empty = uvm_reg_field::type_id::create("fifo_empty");  
    fifo_full = uvm_reg_field::type_id::create("fifo_full");   
    fifo_overflow = uvm_reg_field::type_id::create("fifo_overflow");   
    fifo_underflow = uvm_reg_field::type_id::create("fifo_underflow");   
    fifo_reg_write = uvm_reg_field::type_id::create("fifo_reg_write");    
    // Configure
    fifo_empty.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(0),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h1),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
      fifo_full.configure(.parent(this),
                   .size(1), 
                   .lsb_pos(1),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
     fifo_overflow.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(2),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
     fifo_underflow.configure(.parent(this),
                   .size(1), 
                   .lsb_pos(3),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   

      fifo_reg_write.configure(.parent(this), 
                   .size(1), 
                   .lsb_pos(4),  
                   .access("RW"),   
                   .volatile(0),  
                   .reset(1'h0),  
                   .has_reset(1),  
                   .is_rand(1),  
                   .individually_accessible(1));   
    endfunction
endclass

