
`include "uvm_macros.svh"
`include "fifo_env_pkg.sv"

module top;
    
    import uvm_pkg::*;
    import fifo_pkg::*;
    import fifo_env_pkg::*;

      
    bit system_clock, reset_n; 
    
    // 25MHz clock freq for timescale 1ns
    parameter CLK_CYCLE = 20; 
    localparam delay_reset = 105;
    string logfile = "dump.vcd";
      
    initial begin
        system_clock =0;
        forever #(CLK_CYCLE) system_clock = ~system_clock;
    end 

    //reset initialization
    
    // invoking simulation phases of all components
    initial begin
        run_test(""); 
    end
    // Waves
    initial begin
        $value$plusargs("DUMPNAME=%s", logfile);
        $dumpfile(logfile); 
        $dumpvars;
    end
endmodule 

