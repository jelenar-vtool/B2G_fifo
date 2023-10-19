/*
    Extended test creates and runs 50 random transactions.
*/


class temp_extended_test extends temp_base_test;

    `uvm_component_utils(temp_extended_test)
    
    int number_of_transactions = 50;
   
    temp_master_sequence m_seq;
    temp_slave_sequence s_seq;
        
    extern function new(string name = "temp_extended_test", uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void start_of_simulation_phase(uvm_phase phase);
    extern virtual task run_phase (uvm_phase phase);
    extern virtual function void report_phase(uvm_phase phase);
endclass 

//-------------------------------------------------------------------------------------------------------------
function temp_extended_test::new(string name = "temp_extended_test", uvm_component parent=null);    
    super.new(name,parent);
endfunction : new

//-------------------------------------------------------------------------------------------------------------
function void temp_extended_test::build_phase(uvm_phase phase);
    super.build_phase(phase);
	m_seq = temp_master_sequence :: type_id :: create ("m_seq");
	s_seq = temp_slave_sequence :: type_id :: create ("s_seq");
endfunction : build_phase

//-------------------------------------------------------------------------------------------------------------
function void temp_extended_test::start_of_simulation_phase(uvm_phase phase);    
    super.start_of_simulation_phase(phase);    
endfunction

//-------------------------------------------------------------------------------------------------------------
task temp_extended_test:: run_phase (uvm_phase phase);        
    super.run_phase(phase);
    phase.raise_objection(this);
    for (int i = 0; i < number_of_transactions; i++) begin
        fork
            begin
                if (!m_seq.randomize() with {                     
                    //constraints               
                })
                `uvm_fatal("run_phase","temp_master_sequence randomization failed"); 
                m_seq.start(env.master_agent.m_seqr);
            end 
            begin
                if (!s_seq.randomize() with { 
				//constraints
                })
                `uvm_fatal("run_phase","temp_slave_sequence randomization failed");        
                s_seq.start(env.slave_agent.s_seqr);
            end                
        join
    end
    #100;
    phase.drop_objection (this);
endtask
    
//---------------------------------------------------------------------------------------------------------------------
function void temp_extended_test::report_phase(uvm_phase phase);
    super.report_phase(phase);
endfunction


