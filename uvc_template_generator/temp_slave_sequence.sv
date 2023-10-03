
class temp_slave_sequence extends uvm_sequence #(temp_item);
 
    `uvm_object_utils(temp_slave_sequence)
    `uvm_declare_p_sequencer(temp_slave_sequencer)
    temp_cfg cfg;
    extern function new(string name = "temp_slave_sequence");
    extern virtual task body();  
endclass // temp_slave_sequence

//-------------------------------------------------------------------
function temp_slave_sequence::new(string name = "temp_slave_sequence");
    super.new(name);
endfunction //temp_sequence::new

//-------------------------------------------------------------------
task temp_slave_sequence::body();
    
    uvm_config_db#(temp_cfg)::set(null, "*", "cfg", p_sequencer.cfg);
    if (!uvm_config_db#(temp_cfg)::get(p_sequencer,"", "cfg",cfg))
        `uvm_fatal("body", "cfg wasn't set through config db");

	// * * * uvm_do or uvm_do_with can be used * * * 
    `uvm_do(req)

endtask 

