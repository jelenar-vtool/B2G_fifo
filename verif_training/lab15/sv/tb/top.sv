`include "b2gfifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_test_pkg::*;
	bit clk;


    // * * * TODO: Declare all the necessary signals * * * //

    //Generate the clock signal 
	always begin 

		#10 clk=~clk;
	end
	
    //Insantiate the interface
    b2gfifo_if b2gfifo_vif(clk, b2gfifo_topif.rst_n);     
    b2gfifo_topvif b2gfifo_topif();
    //Insantiate the DUT and connect it to the interface
    simple_bin2gray m_dut0 (b2gfifo_vif.clk, b2gfifo_topif.rst_n, b2gfifo_vif.enable, b2gfifo_vif.addr, b2gfifo_vif.write,  b2gfifo_vif.read, b2gfifo_vif.wdata, b2gfifo_vif.rdata, b2gfifo_vif.resp);



    //Initialize the reset signal 

    //Pass the interface to other components through configuration database
    
    initial begin   
	b2gfifo_topif.rst_n =1'b0; 
 	#100;
	b2gfifo_topif.rst_n =1'b1;
	

    end    
    initial begin    
        uvm_config_db#(virtual b2gfifo_if)::set(null,"*","b2gfifo_vif", b2gfifo_vif);  
	uvm_config_db#(virtual b2gfifo_topvif)::set(null,"*","b2gfifo_topif", b2gfifo_topif);  
        run_test();
    	

    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

