
`include "uvm_macros.svh"
`include "temp_env_pkg.sv"

module top;
    
    import uvm_pkg::*;
    import temp_pkg::*;
    import temp_env_pkg::*;

      
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
    initial begin
        reset_n = 0;
        #delay_reset; //async reset
        reset_n = 1;
    end
    
    temp_if#(32,32)temp_vif (system_clock,reset_n);

    //interface
    initial begin
        uvm_config_db#(virtual temp_if#(32,32))::set(null,"*", "temp_vif", temp_vif);
    end
    
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

