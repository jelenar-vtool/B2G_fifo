`include "b2gfifo_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_pkg::*;


    // * * * TODO: Declare all the necessary signals * * * //

    // * * * TODO: Insantiate the interface * * * //

    // * * * TODO: Insantiate the DUT and connect it to the interface * * * //
 
    // * * * TODO: Generate the clock signal * * * //

    // * * * TODO: Initialize the reset signal * * * //

    // * * * TODO: Pass the interface to other components through configuration database
    

    //// DO NOT COPY THE CODE BELLOW TO YOUR NEXT LAB ////

    // Invoking simulation phases of all components
    initial begin      
        #1ms; 
        $display({{100{"*"}}, "\nSimulation finished, please check waves!\n", {100{"*"}}});  
    end

    // Dump the waveform file
   initial begin
	   $recordfile("dump");
	   $recordvars(top);
   end

endmodule 

