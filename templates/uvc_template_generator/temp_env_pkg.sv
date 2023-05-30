
//`include "uvm_pkg.sv"
`include "uvm_macros.svh" 
`include "temp_pkg.sv"
package temp_env_pkg;

import uvm_pkg::*;
import temp_pkg::*;

`include "temp_env_cfg.sv"
`include "temp_scoreboard.sv"
`include "temp_env.sv"
`include "temp_test_list.sv"

endpackage 

//------------------------------------------------------------------------------------------------------------


