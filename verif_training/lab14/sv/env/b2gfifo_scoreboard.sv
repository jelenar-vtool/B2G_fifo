// TODO: * * * Call the imp_decl macro * * *
`uvm_analysis_imp_decl(_master)
//------------------------------------------------------------------------------------------------------------
class b2gfifo_scoreboard extends uvm_scoreboard;

    //Add scoreboard to factory
      `uvm_component_utils (b2gfifo_scoreboard)
      b2gfifo_item req;

   //ref model 
      bit [7:0]  refr_fifo[$];
      bit [7:0]  refw_fifo[$];
      bit [7:0]  ref_ctrl_start;

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
    
endclass

//------------------------------------------------------------------------------------------------------------
function b2gfifo_scoreboard::new(string name = "", uvm_component parent);
    super.new(name,parent);
endfunction

//------------------------------------------------------------------------------------------------------------
function void b2gfifo_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // TODO: * * * Instantiate the analysis port * * *
      m_ap= new("m_ap", this);
    //m_analysis_export = new("m_analysis_export", this);
    
    // TODO: * * * Don't forget to connect this A.P. to the monitor's A.P. later! * * *
endfunction    

//------------------------------------------------------------------------------------------------------------
// TODO: * * * Write the definition of the write function * * *
//       * * * Inside the function, update the expected data queues, compare the data if needed
//       * * * What other checkers do you need?
//       * * * Note: Add run phase if needed
 function void b2gfifo_scoreboard::write_master (b2gfifo_item req);
bit [7:0] temp;
`uvm_info("SCOREBOARD", "uso u write", UVM_LOW)

	if (refw_fifo.size() <16) begin 
		if (req.write == 1) begin 
                       `uvm_info("", $sformatf("Data writen = %0h", req.wdata), UVM_LOW)
                         temp[7] =  req.wdata[7];
			for (int i = 6; i>=0 ; i= i-1)begin 
       				 temp[i] = req.wdata[i] ^ req.wdata[i + 1];
			end
     			refw_fifo.push_back(temp);
		`uvm_info("", $sformatf("Data converted = %0h", temp), UVM_LOW)
		end else if (req.read == 1) begin 
			
			refr_fifo.push_back(req.rdata); 
			`uvm_info("ms_scoreboard - write", $sformatf("Data read = %0h", req.rdata), UVM_LOW)
		end
		
	end
    //What should be done with the data packet received goes here   
    
endfunction
//------------------------------------------------------------------------------------------------------------
function void b2gfifo_scoreboard::phase_ready_to_end(uvm_phase phase);
 if (phase.get_name() != "run") return;
 if ((refw_fifo.size() != 0)||(refw_fifo.size() != 0)) begin

  `uvm_fatal ("phase_ready_to_end","queue not empty")
 end
endfunction


       
task b2gfifo_scoreboard:: run_phase (uvm_phase phase);
	bit [7:0] expcteddata, recveddata; 
	forever begin
  `uvm_info("SCOREBOARD", "uso u run task", UVM_LOW)
	  wait (refr_fifo.size()>0 && refw_fifo.size()>0);
	 expcteddata=refw_fifo.pop_front(); 
         recveddata=refr_fifo.pop_front();
            // Compare 
            if (expcteddata == recveddata) begin
                `uvm_info("SCOREBOARD", "Data match", UVM_LOW)
            end else begin
                `uvm_error("SCOREBOARD", $sformatf(" EEROR expected= %0h, receved= %0h", expcteddata, recveddata))
            end
        end 
endtask
