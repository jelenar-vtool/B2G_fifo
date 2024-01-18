//`ifndef b2gfifo_PKG_SV
//`define b2gfifo_PKG_SV

//------------------------------------------------------------------------------------------------------------
`include "uvm_macros.svh"

package b2gfifo_pkg;
    import uvm_pkg::*;
 //`include "b2gfifo_topvif"
 `include "b2gfifo_item.sv"
 `include "../rtl/b2gfifo_reg.sv"
   `include "../rtl/b2gfifo_reg_block.sv"


   `include "../rtl/b2gfifo_reg2bus.sv"
 `include "b2gfifo_cfg.sv"
  `include "b2gfifo_master_sequencer.sv"
  //`include "b2gfifo_master_sequence.sv"
  `include "b2gfifo_master_sequence_lib.sv"
  `include "b2gfifo_master_driver.sv"
  `include "b2gfifo_monitor.sv"

  `include "b2gfifo_agent.sv"

  //Sequences used by the m_agent

endpackage 

//`endif //b2gfifo_PKG_SV

