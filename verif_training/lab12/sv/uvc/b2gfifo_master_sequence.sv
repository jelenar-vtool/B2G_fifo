class b2gfifo_master_sequence extends uvm_sequence #(b2gfifo_item);
 
    `uvm_object_utils(b2gfifo_master_sequence)
    `uvm_declare_p_sequencer(b2gfifo_master_sequencer)
    
    extern function new(string name = "b2gfifo_master_sequence");
    
    extern virtual task pre_body();   
    extern virtual task body();   
    extern virtual task post_body();   

endclass // b2gfifo_master_sequence

//-------------------------------------------------------------------
function b2gfifo_master_sequence::new(string name = "b2gfifo_master_sequence");
    super.new(name);
endfunction //b2gfifo_sequence::new

//-------------------------------------------------------------------
task b2gfifo_master_sequence::body();
	// * * * `uvm_do or `uvm_do_with can be used here * * * 
    repeat(5) begin
        `uvm_do(req)
	#40;
    end
endtask 

//-------------------------------------------------------------------
task b2gfifo_master_sequence::pre_body();
    uvm_test_done.raise_objection(this);
endtask

//-------------------------------------------------------------------
task b2gfifo_master_sequence::post_body();
    uvm_test_done.drop_objection(this);
endtask
