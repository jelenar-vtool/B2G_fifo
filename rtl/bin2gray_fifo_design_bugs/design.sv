
// Top level design
`include "fifo_mem.v"
`include "bin2gray.v"

module simple_bin2gray (clk, rst_n, enable, addr, write, read, wdata, rdata, resp);
  
  input logic clk;
  input logic rst_n;
  input logic enable;
  input logic [1:0] addr;
  input logic write;
  input logic read;
  input logic  [7:0] wdata;
  output logic [7:0] rdata;
  output logic resp;
  
  logic [7:0] bin_data;
  logic [7:0] gray_data;
  
  logic fifo_wr;
  logic fifo_rd;
  logic fifo_reg_write;
  
  logic[7:0] CTL_STAT;
  
  logic[7:0] fifo_data_out;
  
  logic fifo_underflow, fifo_overflow, fifo_full, fifo_empty;
    
  always_comb begin
	fifo_rd = enable && rst_n ? (addr == 'h0) && read : 0;
	fifo_wr = enable && rst_n ? (addr == 'h0 || addr == 'h1 || addr == 'h2) && write : 0;
	bin_data = enable && rst_n ? {8{fifo_wr}} &  wdata : 0; 
	fifo_reg_write = enable && rst_n ? (addr == 'h3) && write && (wdata[4] == 'h1) : 0;
  end  
  
  //top level outputs 
  always_comb begin    
    resp = (addr == 'h1 || addr == 'h2) && read;
	case(addr)
	   0 : rdata = fifo_data_out;
	   1 : rdata = 0;
	   2 : rdata = 0;
	   3 : rdata = CTL_STAT;
	   default : rdata = 0;
	endcase	
  end
  
 //Status registers should reflect the values from fifo
 assign CTL_STAT[7:5] = 0;
 assign CTL_STAT[4] = fifo_reg_write;
 assign CTL_STAT[3] = fifo_underflow;
 assign CTL_STAT[2] = fifo_overflow;
 assign CTL_STAT[1] = fifo_full;
 assign CTL_STAT[0] = fifo_empty; 
         
  fifo_mem fifo_mem(
    .data_out(fifo_data_out),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .fifo_overflow(fifo_overflow),
    .fifo_underflow(fifo_underflow),
    .clk(clk),
    .rst_n(rst_n),
    .wr(fifo_wr),
    .rd(fifo_rd),
    .data_in(gray_data),
	.clear(CTL_STAT[4])
  );    
  
  bin2gray bin2gray(
    .in(bin_data),
    .out(gray_data) 
  );
  
  
endmodule
