class ahb_driver extends uvm_driver#(ahb_sequence_item);
  
  `uvm_component_utils(ahb_driver)
  
  event resetevent;
  
  virtual ahb_interface vintf;
  
  function new(string name="ahb_driver",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(!uvm_config_db#(virtual ahb_interface)::get(this,"","AHB_INTERFACE",vintf))
      `uvm_fatal(get_type_name(),"THE VIRTUAL INTERFACE HAS BEEN NOT POINTED")
     else
       `uvm_info(get_type_name(),"THE VIRTUAL INTERFACE HAS BEEN NOT POINTED",UVM_LOW)
  endfunction
  
  virtual task reset_phase(uvm_phase phase);
    phase.raise_objection(this);
    @(negedge vintf.HRESETN);
    @(posedge vintf.HRESETN);
    ->resetevent;
    phase.drop_objection(this);
  endtask
  
  virtual task run_phase(uvm_phase phase);
    wait(resetevent.triggered);
    forever
      begin
       seq_item_port.get_next_item(req);
        `uvm_info(get_type_name(),"\n#######################################",UVM_LOW)
        `uvm_info(get_type_name(),"THIS PRINT IS BEFORE DRIVING THE ITEM",UVM_LOW)
        `uvm_info(get_type_name(),"##########################################\n\n",UVM_LOW)
        req.print();
        drive_item(req);
        seq_item_port.item_done();
       
      end
    
  endtask
  
  task drive_item(input ahb_sequence_item drv);
    
    if(drv.HWRITE == 1)
      ahb_single_write(drv);
    else
      ahb_single_read(drv);

  endtask
  
  task ahb_single_write(input ahb_sequence_item wseq);
   
  while(1)
  begin
    
    @(posedge vintf.HCLK)
    if(vintf.HREADY_OUT == 1)
       break;
    
  end

    vintf.HADDR <= wseq.HADDR;
    vintf.HWRITE <= wseq.HWRITE;
    vintf.HTRANS <= 2;
    vintf.HBURST <= wseq.HBURST;
    vintf.HSIZE <= wseq.HSIZE;
    vintf.HSELx <= 1;
    
  @(posedge vintf.HCLK)
    
  if(vintf.HRESP == 0)
    begin
      vintf.HWDATA <= wseq.HWDATA;
      vintf.HADDR <= 0;
      vintf.HTRANS <= 0;
    end
   else
     `uvm_error(get_type_name(),"THE RESPONSE IS ERROR or SPLIT or RETRY CANNOT MOVE FURTHER")
     
     while(1)
       begin
         @(posedge vintf.HCLK)
         if(vintf.HREADY_OUT == 1)
           break;
       end
  
  endtask 
  
  
  task ahb_single_read(input ahb_sequence_item wseq);
   
  while(1)
  begin
    
    @(posedge vintf.HCLK)
    if(vintf.HREADY_OUT == 1)
       break;
    
  end

    vintf.HADDR <= wseq.HADDR;
    vintf.HWRITE <= wseq.HWRITE;
    vintf.HTRANS <= 2;
    vintf.HBURST <= wseq.HBURST;
    vintf.HSIZE <= wseq.HSIZE;
    vintf.HSELx <= 1;
    
  @(posedge vintf.HCLK)
    
  if(vintf.HRESP == 0)
    begin
      vintf.HTRANS <= 0;
      vintf.HADDR <= 0;
    end
   else
     `uvm_error(get_type_name(),"THE RESPONSE IS ERROR or SPLIT or RETRY CANNOT MOVE FURTHER")
     
     while(1)
       begin
         @(posedge vintf.HCLK)
         if(vintf.HREADY_OUT == 1)
           begin
             $cast(req.HRDATA,vintf.HRDATA);
           break;
           end
       end
  
  endtask 
  
endclass
      
 
 
   
