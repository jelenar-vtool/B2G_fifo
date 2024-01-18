
//`include "uvm_pkg.sv"

package b2gfifo_test_pkg;

    import uvm_pkg::*;
    import b2gfifo_pkg::*;
    import b2gfifo_env_pkg::*;
    
    `include "uvm_macros.svh" 
    `include "b2gfifo_base_test.sv"
    `include "b2gfifo_simple_test.sv"
    `include "b2gfifo_factory_ovrd_test.sv"
   // `include "b2gfifo_clr_test.sv"
    //`include "b2gfifo_empty_check_test.sv"
    //`include "b2gfifo_multiple_delayed_items_test.sv"
    `include "b2gfifo_write_full_test.sv"
    `include "b2gfifo_write_wrong_addr_test.sv"
    `include "b2gfifo_error_test.sv"
    `include "b2gfifo_rand_test.sv"
    `include "b2gfifo_backdoor_test.sv"
    // * * * You can include different sequences for specific test bellow * * *

endpackage 

//------------------------------------------------------------------------------------------------------------


