/*
      * * * Coverage class, fill your specific coverpoints down bellow * * *
*/

/*    * * * UNCOMMENT AND WRITE COVERAGE BELOW * * *

class temp_coverage extends uvm_component;
	`uvm_component_param_utils(temp_coverage)
	
    temp_cfg cfg; 
    
    covergroup temp_cg with function sample(
        temp_item item
        );
        
        // * * * * WRITE YOUR COVERPOINTS HERE * * * * 
        
    endgroup
	
    extern function new(string name = "temp_coverage", uvm_component parent);
    extern virtual function void build_phase(uvm_phase phase);
endclass

function temp_coverage::new(string name = "temp_coverage", uvm_component parent);
    super.new(name, parent);
    temp_cg = new();	
endfunction // temp_coverage::new

function void  temp_coverage::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(temp_cfg)::get(this, "", "cfg", cfg))   
        `uvm_fatal("build_phase", "cfg wasn't set through config db");
endfunction // temp_coverage::build_phase

*/
