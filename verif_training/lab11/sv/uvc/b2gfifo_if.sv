
interface b2gfifo_if(input clk,input  rst_n);
  logic enable;
  logic write;
  logic read;  
  logic resp;  
  logic [1:0] addr;
  logic [7:0] wdata;
  logic [7:0] rdata;  
  //Declare all inputs and outputs
 /* modport temp (  
    input enable, addr,write,read,wdata, 
    output resp, addr, rdata
  );*/


endinterface
  
    


