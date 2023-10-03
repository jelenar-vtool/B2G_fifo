//`ifndef temp_PKG_SV
//`define temp_PKG_SV

//------------------------------------------------------------------------------------------------------------
`include "uvm_macros.svh"
`include "temp_if.sv"
package temp_pkg;
import uvm_pkg::*;
    `include "temp_defines.sv"
    `include "temp_cfg.sv"
    `include "temp_item.sv"
    `include "temp_coverage.sv"
    `include "temp_monitor.sv" 
    `include "temp_master_sequencer.sv"
    `include "temp_slave_sequencer.sv"
    `include "temp_master_sequence.sv"
    `include "temp_slave_sequence.sv"
    `include "temp_master_driver.sv"
    `include "temp_slave_driver.sv"
    `include "temp_agent.sv"
endpackage 

//`endif //temp_PKG_SV

