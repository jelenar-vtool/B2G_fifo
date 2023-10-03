/*
      * * * Coverage class, fill your specific coverpoints down bellow * * *
*/

/*    * * * UNCOMMENT AND WRITE COVERAGE BELOW * * *

class fifo_coverage extends uvm_component;
	`uvm_component_param_utils(fifo_coverage)
	
    fifo_cfg cfg; 
    
    covergroup fifo_cg with function sample(
        fifo_item item
        );
        
        // * * * * WRITE YOUR COVERPOINTS HERE * * * * 
        
    endgroup
	
    extern function new(string name = "fifo_coverage", uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
endclass

function fifo_coverage::new(string name = "fifo_coverage", uvm_component parent);
    super.new(name, parent);
    fifo_cg = new();	
endfunction // fifo_coverage::new

function void  fifo_coverage::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(fifo_cfg)::get(this, "", "cfg", cfg))   
        `uvm_fatal("build_phase", "cfg wasn't set through config db");
endfunction // fifo_coverage::build_phase

*/
