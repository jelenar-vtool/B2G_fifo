// TODO: * * * Call the imp_decl macro * * *

//------------------------------------------------------------------------------------------------------------
class b2gfifo_scoreboard extends uvm_scoreboard;

    // TODO: * * * Add scoreboard to factory* * *

    // TODO: * * * Declare the analysis import for received data items * * * 
    
    // TODO: * * * Declare all the expected data queue and variables needed for checkers * * *
    
    extern function new(string name = "", uvm_component parent);
    extern function void build_phase(uvm_phase phase);
    
    // TODO: * * * Declare the write function prototype * * *
endclass

//------------------------------------------------------------------------------------------------------------
function b2gfifo_scoreboard::new(string name = "", uvm_component parent);
    super.new(name,parent);
endfunction

//------------------------------------------------------------------------------------------------------------
function void b2gfifo_scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // TODO: * * * Instantiate the analysis port * * *
    
    // TODO: * * * Don't forget to connect this A.P. to the monitor's A.P. later! * * *
endfunction    

//------------------------------------------------------------------------------------------------------------
// TODO: * * * Write the definition of the write function * * *
//       * * * Inside the function, update the expected data queues, compare the data if needed
//       * * * What other checkers do you need?
//       * * * Note: Add run phase if needed
