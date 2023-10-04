`include "b2gfifo_test_pkg.sv"

module top;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import b2gfifo_test_pkg::*;

    string logfile = "dump.vcd";

    logic clk;
    logic rst_n;

    b2gfifo_if fifo_if(
        .clk(clk), 
        .rst_n(rst_n)
    );

    simple_bin2gray dut(
        .clk(clk), 
        .rst_n(rst_n), 
        .enable(fifo_if.enable), 
        .addr(fifo_if.addr),  
        .write(fifo_if.write),  
        .read(fifo_if.read),  
        .wdata(fifo_if.wdata),  
        .rdata(fifo_if.rdata),  
        .resp(fifo_if.resp)
    );
 
    initial begin
        clk = 0;
        #100;
        forever begin
            clk = ~clk;
            #10;
        end
    end
    
    initial begin
        rst_n = 0;
        #150;
        rst_n = 1;
    end
    
    initial begin
        uvm_config_db#(virtual b2gfifo_if)::set(null,"*", "b2gfifo_vif", fifo_if);
    end
    
    initial begin      
        run_test();
    end

    initial begin
	$recordfile("dump");
	$recordvars(top);
    end
endmodule 

