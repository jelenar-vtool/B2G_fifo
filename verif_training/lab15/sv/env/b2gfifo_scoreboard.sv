// TODO: * * * Call the imp_decl macro * * *
`uvm_analysis_imp_decl(_master)
//------------------------------------------------------------------------------------------------------------
class b2gfifo_scoreboard extends uvm_scoreboard;

    //Add scoreboard to factory
      `uvm_component_utils (b2gfifo_scoreboard)
      b2gfifo_item req;
	b2gfifo_covergroup ms_cg;
   //ref model 
      bit [7:0]  refr_fifo[$];
      bit [7:0]  refw_fifo[$];
      bit [7:0]  ref_ctrl_start= 00000001; 
     virtual b2gfifo_if b2gfifo_vif;
    b2gfifo_reg_block  regmodel;  
    int polling_duration=2;
    int polling_interval=10; 
    // TODO: * * * Declare the analysis import for received data items * * * 
     uvm_analysis_imp_master #(b2gfifo_item, b2gfifo_scoreboard) m_ap;
   // uvm_analysis_imp #(b2gfifo_item, b2gfifo_scoreboard) m_analysis_export;
    // TODO: * * * Declare all the expected data queue and variables needed for checkers * * *
    
    extern function new(string name = "", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
   // extern function  bit[7:0] ref_bin2gray(bit[7:0] ref_data);
    // TODO: * * * Declare the write function prototype * * *
     extern function void write_master (b2gfifo_item req);
     extern task run_phase (uvm_phase phase);
    extern function void phase_ready_to_end(uvm_phase phase);
/*task backdoor_poll(uvm_reg_field field_name, int polling_duration, int polling_interval, bit value_to_be_polled);
    uvm_reg        m_reg;
    uvm_status_e   m_status;
    uvm_reg_data_t m_data;
    
    m_reg = field_name.get_parent();
    fork
        begin
            m_reg.read(m_status, m_data, UVM_BACKDOOR);
            while(m_data != value_to_be_polled)begin
                #(polling_interval * 1ns);
                m_reg.read(m_status, m_data, UVM_BACKDOOR);
            end 
        end
        begin
            #(polling_duration * 1ns);
            `uvm_error(get_type_name(), "Maximum polling duration reached")
        end
    join_any
    disable fork;
endtask */   
endclass

//------------------------------------------------------------------------------------------------------------
function b2gfifo_scoreboard::new(string name = "", uvm_component parent);
    super.new(name,parent);
  ms_cg = new("ms_cg",parent);
   // ms_cg.set_inst_name ("ms_cg");
endfunction

//------------------------------------------------------------------------------------------------------------
function void b2gfifo_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual b2gfifo_if )::get(this, "", "b2gfifo_vif", b2gfifo_vif)) begin 
       `uvm_fatal("", "Failed to get virtual_interface !");
    end
    // TODO: * * * Instantiate the analysis port * * *
      m_ap= new("m_ap", this);
  
    // TODO: * * * Don't forget to connect this A.P. to the monitor's A.P. later! * * *
	 if(!uvm_config_db#(b2gfifo_reg_block)::get(this, "", "regmodel", regmodel)) begin
	     `uvm_fatal(get_type_name(), "Failed to get configuration object from config DB!")
	   end
endfunction    

//------------------------------------------------------------------------------------------------------------
// TODO: * * * Write the definition of the write function * * *
//       * * * Inside the function, update the expected data queues, compare the data if needed
//       * * * What other checkers do you need?
//       * * * Note: Add run phase if needed
 function void b2gfifo_scoreboard::write_master (b2gfifo_item req);
bit [7:0] temp;
`uvm_info("SCOREBOARD", "uso u write", UVM_LOW)
	if (req.read) begin 
	ms_cg.r_cg.sample(req.read,req.addr,req.resp); 
	  if (req.addr == 0) begin 
		if(refw_fifo.size()== 0) begin  
		  	ref_ctrl_start[3] =1; 
			regmodel.CTL_STAT.fifo_underflow.predict(1);
		/*fork 
		backdoor_poll("regmodel.CTL_STAT.fifo_underflow", polling_duration, polling_interval, 1);
		join_none*/
		end 
		else begin 
			ref_ctrl_start[2] =0;
			regmodel.CTL_STAT.fifo_overflow.predict(0);
			refr_fifo.push_back(req.rdata); 
		
			`uvm_info("ms_scoreboard - write", $sformatf("Data read = %0h", req.rdata), UVM_LOW)
		end 
	  end 
 	  if (req.addr == 1) begin 
		if (!(req.resp ===1 ))
		`uvm_error("read","Attempt to read from addr 1, resp not set")
	  end
	  if (req.addr == 2) begin 
		if (!(req.resp ===1 ))
		`uvm_error("read","Attempt to read from addr 2, resp not set")
	  end
	  if (req.addr == 3) begin 
			`uvm_info("ctl_stat", $sformatf("ctl = %h", req.rdata), UVM_LOW)
			`uvm_info("ref_ctrl_start", $sformatf("ref_ctrl_start = %h", ref_ctrl_start), UVM_LOW)
		if (!(req.rdata[0] ===ref_ctrl_start[0])) begin  `uvm_error("ctl_start","error with empty bit") end 
		if (!(req.rdata[1] ===ref_ctrl_start[1])) begin  `uvm_error("ctl_start","error with full bit") end
		if (!(req.rdata[2] ===ref_ctrl_start[2])) begin  `uvm_error("ctl_start","error with overflow status indication") end
		if (!(req.rdata[3] ===ref_ctrl_start[3])) begin  `uvm_error("ctl_start","error with FIFO underflow status indication")end 
		if (!(req.rdata[4] ===ref_ctrl_start[4])) begin  `uvm_error("ctl_start","error with FIFO clr")end 
			
	 end
	end
	if (req.write) begin
	ms_cg.w_cg.sample(req.wdata,req.addr); 
	  if (req.addr == 0  || req.addr == 1 || req.addr == 2) begin 
		if(ref_ctrl_start[3] ==1) begin 
			ref_ctrl_start[3] =0;
			regmodel.CTL_STAT.fifo_underflow.predict(0);
		end
	 	if(refw_fifo.size()== 16) begin 
			ref_ctrl_start[2] =1;
			regmodel.CTL_STAT.fifo_overflow.predict(1);
		end else begin

                 if(refw_fifo.size()== 0) ref_ctrl_start[0] =0; 
			regmodel.CTL_STAT.fifo_empty.predict(0);
		`uvm_info("", $sformatf("Data writen = %0h", req.wdata), UVM_LOW)
			for (int i = 0; i<7 ; i= i+1)begin 
       				 temp[i] = req.wdata[i] ^ req.wdata[i + 1];
			end
                        temp[7]= req.wdata[7];
     			refw_fifo.push_back(temp);
			if(refw_fifo.size()== 16) begin 
				ref_ctrl_start[1] =1;
			regmodel.CTL_STAT.fifo_full.predict(1);
			end
		`uvm_info("", $sformatf("Data converted = %0h", temp), UVM_LOW)		
	        end
	  end  
	  if (req.addr == 3) begin 
		if(req.wdata[4]==1) begin 
		refw_fifo.delete();
		refr_fifo.delete();
		ref_ctrl_start= 00000001;
		regmodel.CTL_STAT.predict(00000001);
	 end 
	 end
	end

endfunction
//------------------------------------------------------------------------------------------------------------
function void b2gfifo_scoreboard::phase_ready_to_end(uvm_phase phase);
 if (phase.get_name() != "run") return;
 if (refr_fifo.size() != 0) begin

  `uvm_fatal ("phase_ready_to_end","queue not empty")
 end
endfunction


       
task b2gfifo_scoreboard:: run_phase (uvm_phase phase);
	bit [7:0] expcteddata, recveddata; 
fork
	forever begin 
	  `uvm_info("SCOREBOARD", "run task, for reset", UVM_LOW)
		@(negedge b2gfifo_vif.rst_n == 0) begin	 	
		refw_fifo.delete();
		refr_fifo.delete();
		ref_ctrl_start= 00000001;
		regmodel.CTL_STAT.predict(00000001);
	end 
	end 
	forever begin
	  `uvm_info("SCOREBOARD", "run task", UVM_LOW)
		  wait (refr_fifo.size()>0 && refw_fifo.size()>0);
		if(refw_fifo.size()== 16) begin 
				ref_ctrl_start[1] =0;
			regmodel.CTL_STAT.fifo_full.predict(0);
			end
		
		 expcteddata=refw_fifo.pop_front(); 
		 recveddata=refr_fifo.pop_front();
		if(refw_fifo.size()== 0) begin 
				ref_ctrl_start[0] =1;
			regmodel.CTL_STAT.fifo_empty.predict(1);
			end
		    // Compare 
		    if (expcteddata == recveddata) begin
		        `uvm_info("SCOREBOARD", "Data match", UVM_LOW)
		    end else begin
		        `uvm_error("SCOREBOARD", $sformatf(" EEROR expected= %0h, receved= %0h", expcteddata, recveddata))
		    end



	end
join_none
endtask


