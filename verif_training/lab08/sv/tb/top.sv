`include "b2gfifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_test_pkg::*;


    // * * * TODO: Declare all the necessary signals * * * //

    // * * * TODO: Insantiate the interface * * * //

    // * * * TODO: Insantiate the DUT and connect it to the interface * * * //
 
    // * * * TODO: Generate the clock signal * * * //

    // * * * TODO: Initialize the reset signal * * * //

    // * * * TODO: Pass the interface to other components through configuration database
    
    
    initial begin      
        run_test();
    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

