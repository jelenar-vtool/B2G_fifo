interface ahb_interface(input bit HCLK,HRESETN);
  logic [31:0] HADDR;
  logic [1:0] HTRANS;
  logic HWRITE;
  logic [2:0]HSIZE;
  logic [2:0]HBURST;
  logic [3:0]HPROT;
  logic [31:0]HWDATA;
  logic [31:0]HRDATA;
  logic HSELx;
  logic HREADY_OUT;
  logic HREADY_IN;
  logic [1:0]HRESP;
  logic HBUSREQx;
  logic HLOCKx;
  logic HGRANTx;
  logic [3:0]HMASTERx;
  logic HMASTLOCK;
  logic HSPLITx[15:0];
  logic XFER_ERROR_ACCESS;
endinterface

