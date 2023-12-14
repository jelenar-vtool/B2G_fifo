class b2gfifo_empty_sequence extends uvm_sequence #(b2gfifo_item);
    
      b2gfifo_item req;
  
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_empty_sequence)
      

   `uvm_object_utils_end
    
  
    extern function new(string name = "b2gfifo_empty_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_empty_sequence

//-------------------------------------------------------------------
function b2gfifo_empty_sequence::new(string name = "b2gfifo_empty_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_empty_sequence::body();
   

   
endtask : body
//----------------------------------------------------------------------------------------
class b2gfifo_basic_sequence extends b2gfifo_empty_sequence;
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
   for (int i = 0; i < 5; i++) begin
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
   for (int i = 0; i < 5; i++) begin
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
class b2gfifo_multiple_delayed_items_sequence extends b2gfifo_empty_sequence; 
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
//-------------------------------------------------------------------
class b2gfifo_empty_check_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand bit [7:0] seq_wdata;
   bit [7:0] seq_rdata;
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_empty_check_sequence)
      `uvm_field_int(seq_wdata, UVM_ALL_ON)

   `uvm_object_utils_end
    
 
    extern function new(string name = "b2gfifo_empty_check_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_empty_check_sequence

//-------------------------------------------------------------------
function b2gfifo_empty_check_sequence::new(string name = "b2gfifo_empty_check_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_empty_check_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
  `uvm_info(get_type_name(), "Inside test_sequence body() \n", UVM_HIGH)
   req = b2gfifo_item::type_id::create("req");

      //req.new();
      start_item(req);
          if(!req.randomize() with {
                addr == 3;
		read==1;
 		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed!")
          end
      `uvm_info(get_type_name(), $psprintf("Read item, queue empty\n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
      //req.new();
      start_item(req);
      if(!req.randomize() with {
                addr == 0;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Attempty to read from empty queue \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
      start_item(req);
      if(!req.randomize() with {
                addr == 3;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Read item, after attempt to read from empty queue \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
endtask : body
//-----------------------------------------------------------------------------------------------------------------------
class b2gfifo_write_full_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand bit [1:0] seq_addr;
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_write_full_sequence)
      `uvm_field_int(seq_addr, UVM_ALL_ON)

   `uvm_object_utils_end
    
   constraint s_addr {
      seq_addr < 2'b11;
        }
    extern function new(string name = "b2gfifo_write_full_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_write_full_sequence

//-------------------------------------------------------------------
function b2gfifo_write_full_sequence::new(string name = "b2gfifo_write_full_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_write_full_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
  `uvm_info(get_type_name(), "Inside basic_sequence body() \n", UVM_HIGH)
   req = b2gfifo_item::type_id::create("req");
   for (int i = 0; i < 3; i++) begin
   for (int i = 0; i < 16; i++) begin
      //req.new();
      start_item(req);
     seq_addr = $urandom_range(0, 2);
          if(!req.randomize() with {
                addr == seq_addr;
		read==0;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_wdata!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
      start_item(req);
      if(!req.randomize() with {
                addr == 3;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Read item, full fifo\n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
	start_item(req);
          if(!req.randomize() with {
                addr == seq_addr;
		wdata == 0;
             	read==0;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Write item to full fifo \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
      start_item(req);
      if(!req.randomize() with {
                addr == 3;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Read item, overflow fifo\n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
for (int i = 0; i < 18; i++) begin
      //req.new();
      start_item(req);
          if(!req.randomize() with {
                addr ==0;
		read==1;
		write==0;
		wdata ==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_wdata!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
	start_item(req);
      if(!req.randomize() with {
                addr == 3;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Read item, empty fifo\n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
endtask : body
//-----------------------------------------------------------------------------------------------------------------------
class b2gfifo_write_wrong_addr_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand bit [1:0] seq_addr;
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_write_wrong_addr_sequence)
      `uvm_field_int(seq_addr, UVM_ALL_ON)

   `uvm_object_utils_end
    
   constraint s_addr {
      seq_addr < 2'b11;
        }
    extern function new(string name = "b2gfifo_basic_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_write_wrong_addr_sequence

//-------------------------------------------------------------------
function b2gfifo_write_wrong_addr_sequence::new(string name = "b2gfifo_basic_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_write_wrong_addr_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
  `uvm_info(get_type_name(), "Inside basic_sequence body() \n", UVM_HIGH)
   req = b2gfifo_item::type_id::create("req");

   for (int i = 0; i < 6; i++) begin
       req = new();
      start_item(req);
     seq_addr = $urandom_range(0, 2);
          if(!req.randomize() with {
                addr == seq_addr;
		read==0;
		rdata==0;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_wdata!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
     
for (int i = 0; i < 6; i++) begin
      req = new();
      start_item(req);
     seq_addr = $urandom_range(0, 2);
          if(!req.randomize() with {
                addr == seq_addr;
		read==1;
		write==0;
		wdata ==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_wdata!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end
	

   
endtask : body
//-----------------------------------------------------------------------------------------------------------------------
class b2gfifo_clr_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand bit [1:0] seq_addr;
	
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_clr_sequence)
      `uvm_field_int(seq_addr, UVM_ALL_ON)

   `uvm_object_utils_end
    
   constraint s_addr {
      seq_addr < 2'b11;
        }
    extern function new(string name = "b2gfifo_basic_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_clr_sequence

//-------------------------------------------------------------------
function b2gfifo_clr_sequence::new(string name = "b2gfifo_basic_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_clr_sequence::body();
    // TODO: * * * Create, randomize and start a sequence item * * * 
  `uvm_info(get_type_name(), "Inside basic_sequence body() \n", UVM_HIGH)
   req = b2gfifo_item::type_id::create("req");
//----------------reseting empty FIFO---------------
	req = new();
      start_item(req);

          if(!req.randomize() with {
                addr == 3;
		read==0;
		wdata[4]==1;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("Reseted empty queue\n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//----------------reading address 3 from empty resteded FIFO----------
	req = new();
      start_item(req);

          if(!req.randomize() with {
                addr == 3;
		read==1;
		write==0;
		wdata ==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//----------------reading from empty queue [uf should be set]-----------------
    req=new();
      start_item(req);
      if(!req.randomize() with {
                addr == 0;
             	read==1;
		wdata == 0;
		write==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_rdata!")
          end
       `uvm_info(get_type_name(), $psprintf("Attempty to read from empty queue \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//---------------reseting FIFO------------------
	req = new();
      start_item(req);

          if(!req.randomize() with {
                addr == 3;
		read==0;
		wdata[4]==1;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("Reseted queue \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//----------------reading address 3 from resteded FIFO----------
	req = new();
      start_item(req);

          if(!req.randomize() with {
                addr == 3;
		read==1;
		write==0;
		wdata ==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("Addr 3 \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//----------------filling up FIFO [full should be set] +writing to full FIFO [ovf should be set]----------------
 for (int i = 0; i < 17; i++) begin
       req = new();
      start_item(req);
     seq_addr = $urandom_range(0, 2);
          if(!req.randomize() with {
                addr == seq_addr;
		read==0;
		rdata==0;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed for seq_addr!")
          end
      `uvm_info(get_type_name(), $psprintf("Writen  item \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);

   end

//---------------reseting FIFO------------------
	req = new();
 	start_item(req);

          if(!req.randomize() with {
                addr == 3;
		read==0;
		wdata[4]==1;
		write==1;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("Reseted queue \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
//----------------reading address 3 from resteded FIFO----------
	req = new();
	start_item(req);
          if(!req.randomize() with {
                addr == 3;
		read==1;
		write==0;
		wdata ==0;
          }) begin
         `uvm_error(get_type_name(), "Randomization failed !")
          end
      `uvm_info(get_type_name(), $psprintf("REading addr 3 \n %s", req.sprint()), UVM_HIGH)
      finish_item(req);
endtask : body
//----------------------------------------------------------------------------------------
class b2gfifo_rst_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    

   
   b2gfifo_item req;
   rand int begin_time;
   rand int end_time;
   rand int duration;

   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_rst_sequence)
      `uvm_field_int(begin_time, UVM_ALL_ON)
      `uvm_field_int(end_time, UVM_ALL_ON)
      `uvm_field_int(duration, UVM_ALL_ON)
   `uvm_object_utils_end
     constraint time_c {
      begin_time >= 500;
      begin_time <=2000;

        };
  
    extern function new(string name = "b2gfifo_rst_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_rst_sequence

//-------------------------------------------------------------------
function b2gfifo_rst_sequence::new(string name = "b2gfifo_rst_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_rst_sequence::body();

	begin
		`uvm_info(get_type_name(), "Inside b2gfifo_rst_sequence body() \n", UVM_HIGH)
		std::randomize (duration) with { duration >= 10;
	      	       duration <=20; };
		#(begin_time);
		p_sequencer.b2gfifo_topif.rst_n <=1'b0;
		repeat(duration) @(posedge p_sequencer.b2gfifo_vif.clk);
		p_sequencer.b2gfifo_topif.rst_n <=1'b1;	
	end 

endtask : body
//----------------------------------------------------------------------------------------
class b2gfifo_rand_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    


   b2gfifo_item req;
   rand int reps;
   rand bit [7:0] seq_wdata;
   rand bit [1:0] seq_addr;
   rand bit r;
   rand bit w;
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_rand_sequence)
      `uvm_field_int(reps, UVM_ALL_ON)
      `uvm_field_int(seq_wdata, UVM_ALL_ON)
      `uvm_field_int(seq_addr, UVM_ALL_ON)
      `uvm_field_int(r, UVM_ALL_ON)
      `uvm_field_int(w, UVM_ALL_ON)
   `uvm_object_utils_end

    extern function new(string name = "b2gfifo_rand_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_rand_sequence

//-------------------------------------------------------------------
function b2gfifo_rand_sequence::new(string name = "b2gfifo_rand_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_rand_sequence::body();

	
		`uvm_info(get_type_name(), "Inside b2gfifo_rand_sequence body() \n", UVM_HIGH)
   	
 		req = b2gfifo_item::type_id::create("req");
		std::randomize (reps) with { reps >= 56;
	      	       reps <=100; };
		for(int i=0; i<reps; i=i+1) begin 
     //seq_addr = $urandom_range(0, 3);
     //seq_wdata = $urandom_range(0, 32);
       `uvm_do(req);
		end 
		 	
	 

endtask : body//----------------------------------------------------------------------------------------
class b2gfifo_error_sequence extends b2gfifo_empty_sequence;
    // TODO: * * * Declare all necessary rand fields, and define constraints if needed * * * 

    // TODO: * * * Add to factory and declare p_sequencer * * *    


   b2gfifo_item req;
   rand int reps;
   rand bit [7:0] seq_wdata;
   rand bit [1:0] seq_addr;
   rand bit r;
   rand bit w;
   `uvm_declare_p_sequencer(b2gfifo_master_sequencer)	
   `uvm_object_utils_begin(b2gfifo_error_sequence)
      `uvm_field_int(reps, UVM_ALL_ON)
      `uvm_field_int(seq_wdata, UVM_ALL_ON)
      `uvm_field_int(seq_addr, UVM_ALL_ON)
      `uvm_field_int(r, UVM_ALL_ON)
      `uvm_field_int(w, UVM_ALL_ON)
   `uvm_object_utils_end
    
    extern function new(string name = "b2gfifo_error_sequence"); 
    extern virtual task body();   
endclass : b2gfifo_error_sequence

//-------------------------------------------------------------------
function b2gfifo_error_sequence::new(string name = "b2gfifo_error_sequence");
    super.new(name);
endfunction : new

//-------------------------------------------------------------------
task b2gfifo_error_sequence::body();

	
		`uvm_info(get_type_name(), "Inside b2gfifo_error_sequence body() \n", UVM_HIGH)
   		req = b2gfifo_item::type_id::create("req");
		std::randomize (reps) with { reps >= 15;
	      	       reps <=32; };
		for(int i=0; i<reps; i=i+1) begin 
     r = $urandom_range(0, 1);
     w = $urandom_range(0, 1);
       `uvm_do_with (req, {read==r; write==w;});
		end 	
	 

endtask : body


