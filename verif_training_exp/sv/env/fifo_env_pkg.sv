
//`include "uvm_pkg.sv"
`include "uvm_macros.svh" 
`include "fifo_pkg.sv"
`include "fifo_ral_pkg.sv"
package fifo_env_pkg;

   import uvm_pkg::*;
   import fifo_pkg::*;
   import fifo_ral_pkg::*;

   `include "fifo_env_cfg.sv"
   `include "fifo_scoreboard.sv"
   `include "fifo_env.sv"
   `include "fifo_test_list.sv"

endpackage 

//------------------------------------------------------------------------------------------------------------


