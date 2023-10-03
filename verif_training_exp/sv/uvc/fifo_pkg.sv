//`ifndef fifo_PKG_SV
//`define fifo_PKG_SV

//------------------------------------------------------------------------------------------------------------
`include "uvm_macros.svh"
package fifo_pkg;
   import uvm_pkg::*;
   `include "fifo_defines.sv"
   `include "fifo_cfg.sv"
   `include "fifo_item.sv"
   `include "fifo_coverage.sv"
   `include "fifo_monitor.sv" 
   `include "fifo_master_sequencer.sv"
   `include "fifo_slave_sequencer.sv"
   `include "fifo_master_sequence.sv"
   `include "fifo_slave_sequence.sv"
   `include "fifo_master_driver.sv"
   `include "fifo_slave_driver.sv"
   `include "fifo_agent.sv"
endpackage 

//`endif //fifo_PKG_SV

