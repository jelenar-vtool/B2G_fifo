/*
      * * * Environment class, by default creates two agents and scoreboard.
            One agent is configured as Master, other as Slave.
            Both agent's monitors are connected to Scoreboards through Analysis ports.
            Feel free to adapt ENV to meet your specific needs.
*/


class fifo_env extends uvm_env;

    `uvm_component_param_utils(fifo_env)


    extern function new (string name, uvm_component parent);
    extern virtual function void build_phase (uvm_phase phase);
    extern virtual function void connect_phase (uvm_phase phase);

endclass : fifo_env

function fifo_env :: new (string name, uvm_component parent);

    super.new(name, parent);

endfunction : new

function void fifo_env:: build_phase (uvm_phase phase);

    super.build_phase(phase);
    
endfunction : build_phase 
 
function void fifo_env:: connect_phase (uvm_phase phase);

    super.connect_phase(phase);

endfunction : connect_phase



