`uvm_analysis_imp_decl(_m_mon) //master monitor
`uvm_analysis_imp_decl(_s_mon) //slave monitor

class temp_sb extends uvm_scoreboard;

    `uvm_component_utils(temp_sb)

    uvm_analysis_imp_m_mon #(temp_item, temp_sb) m_mon_imp; // master monitor
    uvm_analysis_imp_s_mon #(temp_item, temp_sb) s_mon_imp; // slave monitor
    
    // * * * Add fields here * * * 
    
    function new(string name = "", uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        m_mon_imp = new("m_mon_imp", this);
        s_mon_imp = new("s_mon_imp", this);

    endfunction    

    virtual function void write_m_mon(temp_item data);
        `uvm_info("Scoreboard", "Just recieved item from master monitor", UVM_LOW)
    endfunction

    virtual function void write_s_mon(temp_item data); //what slave monitor sampled
        `uvm_info("Scoreboard", "Just recieved item from slave monitor", UVM_LOW)
    endfunction

    

endclass
