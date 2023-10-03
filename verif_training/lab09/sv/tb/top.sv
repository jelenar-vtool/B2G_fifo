`include "b2gfifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_test_pkg::*;
    
    // * * * TODO add code from previous lab here
    
    initial begin      
        run_test();
    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

