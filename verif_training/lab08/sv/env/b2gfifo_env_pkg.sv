
//`include "uvm_pkg.sv"
`include "uvm_macros.svh" 
`include "b2gfifo_pkg.sv"
package b2gfifo_env_pkg;

import uvm_pkg::*;
import b2gfifo_pkg::*;

`include "b2gfifo_env_cfg.sv"
`include "b2gfifo_scoreboard.sv"
`include "b2gfifo_env.sv"
`include "b2gfifo_test_list.sv"

endpackage 

//------------------------------------------------------------------------------------------------------------


