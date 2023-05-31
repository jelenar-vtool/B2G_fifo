`uvm_analysis_imp_decl(_ahbwrite)
`uvm_analysis_imp_decl(_ahbread)

class ahb_scoreboard extends uvm_component;
  `uvm_component_utils(ahb_scoreboard)
  
  ahb_sequence_item w_transaction;
  ahb_sequence_item r_transaction;
  
  ahb_sequence_item wc_transaction;
  ahb_sequence_item rc_transaction;
  
  ahb_sequence_item w_handles[$];
  ahb_sequence_item r_handles[$];
  
  uvm_analysis_imp_ahbwrite#(ahb_sequence_item, ahb_scoreboard) w_port;
  uvm_analysis_imp_ahbread#(ahb_sequence_item, ahb_scoreboard) r_port;
  
  function new(string name="apb_score_board", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    w_port=new("w_port",this);
    r_port=new("r_port",this);
  endfunction
  
  virtual function void write_ahbwrite(ref ahb_sequence_item w_transaction);
    `uvm_info(get_type_name(),"RECIEVED WRITE TRANSACTION",UVM_LOW)
    w_handles.push_front(w_transaction);
  endfunction
  
  virtual function void write_ahbread(ref ahb_sequence_item r_transaction);
    `uvm_info(get_type_name(),"RECIEVED READ TRANSACTION",UVM_LOW)
    r_handles.push_front(r_transaction);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
  
    forever
      begin
        wait((w_handles.size>0) && (r_handles.size>0))
        compare_task();
     end
  endtask
  
  task compare_task();   
    wc_transaction=w_handles.pop_back();
    rc_transaction=r_handles.pop_back();
    wc_transaction.print();
    rc_transaction.print();
    if((wc_transaction.HADDR==rc_transaction.HADDR)&&(wc_transaction.HWDATA==rc_transaction.HRDATA))
      begin
        `uvm_info(get_type_name(),"\n**********************************************",UVM_LOW)
        `uvm_info(get_type_name(),"THE TRANSACTION HAS BEEN MATCHED",UVM_LOW)
        `uvm_info(get_type_name(),"**********************************************\n\n",UVM_LOW)
      end
    else
      begin
        `uvm_info(get_type_name(),"\n**********************************************",UVM_LOW)
//        `uvm_fatal(get_type_name(),"THE TRANSACTION HAS BEEN FAILED")
        `uvm_info(get_type_name(),"**********************************************\n\n",UVM_LOW)
      end
  endtask
  
endclass
  
