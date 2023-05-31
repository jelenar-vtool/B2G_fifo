`include "uvm_macros.svh"
`include "../verif/tests/test_lib_pkg.sv"
import uvm_pkg::*;
import env_pkg::*;
import test_lib_pkg::*;
module top;


  bit clk ;
  bit hresetn;
  
  ahb_interface u_ahb(.HCLK(clk),
                      .HRESETN(hresetn));
  
  AHB_REGISTERS U_AHBR(.HCLK(u_ahb.HCLK),
                       .HRESETN(u_ahb.HRESETN),
                       .HADRESS(u_ahb.HADDR),
                       .HTRANS(u_ahb.HTRANS),
                       .HWRITE(u_ahb.HWRITE),
                       .HSIZE(u_ahb.HSIZE),
                       .HBURST(u_ahb.HBURST),
                       .HWDATA(u_ahb.HWDATA),
                       .HSELx(u_ahb.HSELx),
                       .HRDATA(u_ahb.HRDATA),
                       .HREADY_IN(u_ahb.HREADY_OUT),
                       .HREADY_OUT(u_ahb.HREADY_OUT),
                       .HRESP(u_ahb.HRESP),
                       .XFER_ERROR_ACCESS(u_ahb.XFER_ERROR_ACCESS));
  
  
  always
    #5 clk =!clk;
  
  initial
    begin
      hresetn=1;
      #5 hresetn=0;
      #13 hresetn=1;
    end
  
  initial
    begin
      uvm_config_db#(virtual ahb_interface)::set(null,"*","AHB_INTERFACE",u_ahb);
      run_test();
    end
  
  initial
    begin
      $dumpfile("dump.vcd"); $dumpvars;
    end
  
endmodule

      
  
