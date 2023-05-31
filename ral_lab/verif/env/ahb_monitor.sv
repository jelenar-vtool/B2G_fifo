class ahb_monitor extends uvm_monitor;
  
  `uvm_component_utils(ahb_monitor)
  
  uvm_analysis_port#(ahb_sequence_item) w_mon_port;
  uvm_analysis_port#(ahb_sequence_item) r_mon_port;
  uvm_analysis_port#(ahb_sequence_item) p_mon_port;
  
  
  event RESETEVENT;
  virtual ahb_interface vintf;
  
  ahb_sequence_item w_sequence_item;
  ahb_sequence_item r_sequence_item;
  
  function new(string name="ahb_wr_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    w_mon_port = new("w_mon_port",this);
    r_mon_port = new("r_mon_port",this);
    p_mon_port = new("p_mon_port",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    if(!uvm_config_db#(virtual ahb_interface)::get(this,"","AHB_INTERFACE",vintf))
      `uvm_fatal(get_type_name(),"THE VIRTUAL INTERFACE RETRIEVING FAILED")
      else
        `uvm_info(get_type_name(),"THE VIRTUAL INTERFACE IS THEIR IN THE MONITOR",UVM_LOW)
  endfunction
  
  
  virtual task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    @(negedge vintf.HRESETN);
    @(posedge vintf.HRESETN);
    ->RESETEVENT;
    phase.drop_objection(this);
  endtask
  
  virtual task run_phase(uvm_phase phase);
    wait(RESETEVENT.triggered);
    
  forever
      begin
        
        while(1)
          begin
            
          @(posedge vintf.HCLK);
        if(vintf.HTRANS == 2)
         break;
            
           end
        
        if(vintf.HWRITE == 1)
          ahb_write_collection();
         else
           ahb_read_collection();
        
      end
        
  endtask
  
  task ahb_write_collection();
    
    w_sequence_item = ahb_sequence_item::type_id::create("w_sequence",this);
    w_sequence_item.HADDR=vintf.HADDR;
    @(posedge vintf.HCLK);
    w_sequence_item.HWDATA = vintf.HWDATA;
    w_sequence_item.HWRITE = vintf.HWRITE;
    `uvm_info(get_type_name(),"\n#######################################",UVM_LOW)
    `uvm_info(get_type_name(),"THE PRINT IS FROM AHB_WRITE_COLLECTION",UVM_LOW)
    `uvm_info(get_type_name(),"#######################################\n\n",UVM_LOW)
    w_sequence_item.print();
    w_mon_port.write(w_sequence_item);
    p_mon_port.write(w_sequence_item);
    
  endtask
  
  task ahb_read_collection();
    
    r_sequence_item = ahb_sequence_item::type_id::create("r_sequence",this);
    r_sequence_item.HADDR = vintf.HADDR;
    r_sequence_item.HWRITE = vintf.HWRITE;
    
    @(posedge vintf.HCLK);
    
    while(1)begin
      @(posedge vintf.HCLK);
      if(vintf.HREADY_OUT == 1);
        break;end
      r_sequence_item.HRDATA=vintf.HRDATA;
   
    `uvm_info(get_type_name(),"\n#######################################",UVM_LOW)
    `uvm_info(get_type_name(),"THE PRINT IS FROM AHB_READ_COLLECTION",UVM_LOW)
    `uvm_info(get_type_name(),"#######################################\n\n",UVM_LOW)
    r_sequence_item.print();
    r_mon_port.write(r_sequence_item);
    p_mon_port.write(r_sequence_item);
    
  endtask
      
  
endclass
    
  
  
  
  
  
  
  
  
      
