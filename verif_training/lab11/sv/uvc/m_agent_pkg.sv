package m_agent_pkg::*;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

   //Typedef used by the m_agent
   typedef enum bit[1:0]  {READ, WRITE} instruction_type;

 `include "b2gfifo_item.sv"
 `include "b2gfifo_cfg.sv"
  `include "b2gfifo_master_driver.sv"
  `include "b2gfifo_monitor.sv"
  `include "b2gfifo_master_sequencer.sv"
  //`include "b2gfifo_master_sequence.sv"



  `include "b2gfifo_agent.sv"

  //Sequences used by the m_agent
  `include "m_seq_lib.sv"
 
 
endpackage : m_agent_pkg

