class fifo_sb extends uvm_scoreboard;

    `uvm_component_utils(fifo_sb)
    
    // * * * Add fields here * * * 
    
    function new(string name = "", uvm_component parent);

        super.new(name,parent);

    endfunction

    function void build_phase(uvm_phase phase);

        super.build_phase(phase);

    endfunction    

endclass
