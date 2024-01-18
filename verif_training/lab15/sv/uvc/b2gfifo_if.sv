
interface b2gfifo_if(input clk,input  rst_n);
  logic enable;
  logic write;
  logic read;  
  logic resp;  
  logic [1:0] addr;
  logic [7:0] wdata;
  logic [7:0] rdata;  
  //Declare all inputs and outputs


property wr();
	@(posedge clk)
	not(write && read);
	endproperty 

     assert property  (wr);

/*property resp_a();
	@(negedge enable)
	resp == 0;
endproperty

    assert property (resp_a);*/
endinterface
  
    


