`include "b2gfifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_test_pkg::*;
	bit clk;
	logic rst_n =1'b1; 
    // * * * TODO: Declare all the necessary signals * * * //

    //Generate the clock signal 
	always #10 clk=~clk;

    //Insantiate the interface
    b2gfifo_if m_vif(clk, rst_n);     
	always #4 rst_n=~rst_n;
    //Insantiate the DUT and connect it to the interface
    simple_bin2gray m_dut0 (m_vif.clk, m_vif.rst_n, m_vif.enable, m_vif.addr, m_vif.write, m_vif.read, m_vif.wdata, m_vif.rdata, m_vif.resp);



    //Initialize the reset signal 

    //Pass the interface to other components through configuration database
    
    
    initial begin    
        uvm_config_db#(virtual b2gfifo_if)::set(null,"*","m_vif", m_vif);  
        run_test();
    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

