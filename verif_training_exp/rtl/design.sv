// Top level design

`include "fifo_mem.v"
`include "bin2gray.v"

module simple_bin2gray (clk, rst_n, enable, addr, write, read, wdata, rdata, ready, resp);
  
  input wire clk;
  input wire rst_n;
  input wire enable;
  input wire [1:0] addr;
  input wire write;
  input wire read;
  input wire  [7:0] wdata;
  output reg [7:0] rdata;
  output reg ready;
  output reg resp;
  
  reg [7:0] wdata_to_encode;
  wire [7:0] wdata_encoded;
  reg fifo_push;
  reg fifo_pop;
  
  reg clear;
  
  wire[7:0] CTL_STAT;
  wire[7:0] data_out;
  wire fifo_underflow, fifo_overflow, fifo_full, fifo_empty;
  
  assign CTL_STAT[7:4] = 4'b0;
  assign CTL_STAT[3] = fifo_underflow;
  assign CTL_STAT[2] = fifo_overflow;
  assign CTL_STAT[1] = fifo_full;
  assign CTL_STAT[0] = fifo_empty;
  
  always @(*) begin
    wdata_to_encode <= (enable & ((addr == 0)||(addr == 1)||(addr==2)) & write) ? wdata : 0;
    fifo_push <= (enable & ((addr == 0)||(addr == 1)||(addr==2)) & write);
    fifo_pop <= (enable & (addr == 0) & read);
  end
  
  always @(*) begin
     resp <= (((addr == 1) || (addr == 2)) & enable & read);
     rdata <= (addr == 0) ? data_out : (addr == 1) ? 0 : (addr == 2) ? 0 : (addr == 3) ? CTL_STAT : 0;
  end
  
  fifo_mem fifo_mem(
    .data_out(data_out),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .fifo_threshold(),
    .fifo_overflow(fifo_overflow),
    .fifo_underflow(fifo_underflow),
    .clk(clk),
    .rst_n(rst_n & ~clear),
    .wr(fifo_push),
    .rd(fifo_pop),
    .data_in(wdata_encoded)
  );  
  
  
  bin2gray bin2gray(
    .in(wdata_to_encode),
    .out(wdata_encoded) 
  );
  
  
endmodule
