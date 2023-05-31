class ahb_environment extends uvm_env;
  
  `uvm_component_utils(ahb_environment)
  
  ahb_agent      agent;
  ahb_scoreboard scoreboard;
  //TO_DO
  
  function new(string name="ahb_enviroment",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    agent = ahb_agent::type_id::create("agent",this);
    scoreboard = ahb_scoreboard::type_id::create("scoreboard",this);
    //TO_DO
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
  
     //TO_DO  

       
     agent.monitor.w_mon_port.connect(scoreboard.w_port);
     agent.monitor.r_mon_port.connect(scoreboard.r_port);
       
   endfunction
  
endclass
       
  
 
