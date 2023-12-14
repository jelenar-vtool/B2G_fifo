
interface b2gfifo_if(input clk);
//inteface signals
	logic 		enable;
	logic 		write;
	logic 		read;
	logic 		resp;
	logic[2:0]  addr;
	logic[7:0]  wdata;
	logic[7:0]  rdata;
//Declare all inputs and outputs
	modport temp(
		input enable, write, read, addr, wdata,
		output resp, rdata
	);


endinterface

