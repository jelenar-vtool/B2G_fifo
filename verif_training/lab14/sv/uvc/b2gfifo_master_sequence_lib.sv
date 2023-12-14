class b2gfifo_basic_sequence extends uvm_sequence #(b2gfifo_item);
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand bit [7:0] seq_wdata;
   bit [7:0] seq_rdata;
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_basic_sequence)
      `uvm_field_int(seq_wdata, UVM_ALL_ON)

   `uvm_object_utils_end
    
   constraint seq_c {
      seq_wdata >= 8'b00100001;
        }
    extern function new(string name = "b2gfifo_basic_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_basic_sequence

//-------------------------------------------------------------------
function b2gfifo_basic_sequence::new(string name = "b2gfifo_basic_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_basic_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
  `uvm_info(get_type_name(), "Inside basic_sequence body() \n", UVM_HIGH)
   req = b2gfifo_item::type_id::create("req");
   for (int i = 0; i < 7; i++) begin
      //req.new();
      start_item(req);
          if(!req.randomize() with {
                addr == 0;
		read==0;
             	//wdata == seq_wdata; 
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_wdata!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
   for (int i = 0; i < 7; i++) begin
      //req.new();
      start_item(req);
      
          if(!req.randomize() with {
                addr == 0;
		//req.rdata = seq_rdata;
		wdata == 0;
             	read==1;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Read item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
endtask : body



//-------------------------------------------------------------------
//-------------------------------------------------------------------
class b2gfifo_multiple_delayed_items_sequence extends uvm_sequence#(b2gfifo_item); 
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *   

   
    rand int num_repetitions;
   rand int delay;
   int max_num_rep = 10;
   int min_delay = 1;
   int max_delay = 20;

   `uvm_object_utils_begin(b2gfifo_multiple_delayed_items_sequence)
      `uvm_field_int(num_repetitions, UVM_ALL_ON)
      `uvm_field_int(delay, UVM_ALL_ON)
   `uvm_object_utils_end
         `uvm_declare_p_sequencer(b2gfifo_master_sequencer)
constraint reps {
      num_repetitions <= max_num_rep;
        }
constraint del {
      delay >= min_delay;
      delay <= max_delay;
        }
    extern function new(string name = "b2gfifo_multiple_delayed_items_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_multiple_delayed_items_sequence

//-------------------------------------------------------------------
function b2gfifo_multiple_delayed_items_sequence::new(string name = "b2gfifo_multiple_delayed_items_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_multiple_delayed_items_sequence::body();
     // TODO: * * * Create an instance of a basic_sequence * * * 
      b2gfifo_basic_sequence basic_seq;
      basic_seq = b2gfifo_basic_sequence::type_id::create("basic_seq");
     // TODO: * * * Randomize and start the basic_sequence sequence * * *
         // Randomize delay for each repetition
     num_repetitions = $urandom_range(1, max_num_rep);
      for (int rep = 0; rep < num_repetitions ; rep++) begin
          delay = $urandom_range(min_delay, max_delay);
         `uvm_info(get_type_name(), $sformatf("Delay before executing basic sequence: %0d cycles", delay), UVM_HIGH)
         wait(delay);


        `uvm_do_on(basic_seq, p_sequencer)


      end
   
     //       * * * Use the fields defined in this sequence to randomize the basic sequence * * *
endtask : body







