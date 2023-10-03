
class fifo_slave_driver extends uvm_driver #(fifo_item);
    
    `uvm_component_utils(fifo_slave_driver)

    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual task  run_phase (uvm_phase phase);
    extern virtual task  do_drive(fifo_item req);
    
endclass // fifo_slave_driver

//-------------------------------------------------------------------------------------------------------------
function fifo_slave_driver::new(string name, uvm_component parent);

    super.new(name, parent);

endfunction // fifo_slave_driver::new

//-------------------------------------------------------------------------------------------------------------
function void fifo_slave_driver::build_phase(uvm_phase phase);

    super.build_phase(phase); 

endfunction // fifo_slave_driver::build_phase

//-------------------------------------------------------------------------------------------------------------
task fifo_slave_driver::run_phase(uvm_phase phase);

endtask// fifo_slave_driver::run_phase

//-------------------------------------------------------------------------------------------------------------

task fifo_slave_driver::do_drive(fifo_item req);
// * * * Write driving logic here * * *

endtask

