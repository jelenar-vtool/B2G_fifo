//`ifndef b2gfifo_PKG_SV
//`define b2gfifo_PKG_SV

//------------------------------------------------------------------------------------------------------------
`include "uvm_macros.svh"

package b2gfifo_pkg;
    import uvm_pkg::*;
    
    `include "b2gfifo_item.sv"
    `include "b2gfifo_master_sequencer.sv"
    `include "b2gfifo_master_sequence.sv"
    `include "b2gfifo_master_driver.sv"
endpackage 

//`endif //b2gfifo_PKG_SV

