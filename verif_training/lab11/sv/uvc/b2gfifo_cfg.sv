/*
* * * * *   AGENT CONFIGURATION     * * * * * 
    You can add specific fields for your agents here
*/

class b2gfifo_cfg extends uvm_object;  

// * * * TODO Add configuration fields here

// * * * TODO Add constraints if needed

// * * * TODO Register the fields with the factory

    
    extern function new(string name = "b2gfifo_cfg");

endclass // b2gfifo_cfg

//-------------------------------------------------------------------------------------------------------------
function b2gfifo_cfg::new(string name = "b2gfifo_cfg");
    super.new(name);
endfunction // new


