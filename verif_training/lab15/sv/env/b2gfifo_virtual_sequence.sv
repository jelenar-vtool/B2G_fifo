class b2gfifo_virtual_sequence extends uvm_sequence #(uvm_sequence_item);
    // TODO: * * * Add to factory * * *
    `uvm_object_utils(b2gfifo_virtual_sequence)
   `uvm_declare_p_sequencer(b2gfifo_virtual_sequencer)

   b2gfifo_basic_sequence seq1;
   b2gfifo_multiple_delayed_items_sequence seq2;
   b2gfifo_empty_sequence seq3;
   b2gfifo_write_full_sequence seq4;
   b2gfifo_write_wrong_addr_sequence seq5;
	b2gfifo_clr_sequence seq6;
	b2gfifo_rst_sequence seq7;
    extern function new(string name = "b2gfifo_virtual_sequence");
    extern virtual task pre_body();
    extern virtual task body();   
    extern virtual task post_body();
endclass : b2gfifo_virtual_sequence

//-------------------------------------------------------------------
function b2gfifo_virtual_sequence::new(string name = "b2gfifo_virtual_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
  task b2gfifo_virtual_sequence::pre_body();
    // raise objection if started as a root sequence
    if(starting_phase != null)
      starting_phase.raise_objection(this);
  endtask

task b2gfifo_virtual_sequence::body();
event k;
fork 
	 begin 
	@(k);
	`uvm_do_on(seq7, p_sequencer.seqr) 
	end 
	begin
	`uvm_do_on(seq1, p_sequencer.seqr)  
	`uvm_do_on(seq4, p_sequencer.seqr)
	->k;   
	`uvm_do_on(seq6, p_sequencer.seqr)  
	 end   
join
endtask : body
 task b2gfifo_virtual_sequence::post_body();
    // drop objection if started as a root sequence
    if(starting_phase != null)
      starting_phase.drop_objection(this);
  endtask
