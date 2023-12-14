class b2gfifo_covergroup extends uvm_component;
    `uvm_component_utils(b2gfifo_covergroup)
	
covergroup r_cg with function sample(bit [7:0] rdata,bit[1:0] addr, bit resp );
   rdata_value: coverpoint rdata {
      bins data_min = {0};
      bins data_low_range = {[1:127]};
      bins data_high_range = {[128:254]};
      bins data_max = {255};
    }
   wild_rdata: coverpoint rdata{
    wildcard bins underflow =  {8'b00001??1};
    wildcard bins overrflow =  {8'b00000110};
	wildcard bins full =  {8'b00000?10};
	wildcard bins empty =  {8'b0000?001};
}
    addr_value: coverpoint addr {
      bins addr_zero = {0};
      bins addr_onetwo = {[1:2]};
      bins addr_three = {3};
    }
    resp_value: coverpoint resp {
      bins resp_min = {0};
      bins resp_max = {1};
    }
     respXaddr: cross resp_value, addr_value{
	bins expected1= binsof(resp_value.resp_min)&& (binsof(addr_value.addr_zero ) || binsof(addr_value.addr_three ));
	bins expected2= binsof(resp_value.resp_max)&& binsof(addr_value.addr_onetwo );
}
     rdataXaddr: cross wild_rdata, addr_value{
	bins uf= binsof(addr_value.addr_three)&& binsof(wild_rdata.underflow );
	bins ovf= binsof(addr_value.addr_three)&& binsof(wild_rdata.overrflow );
	bins ful= binsof(addr_value.addr_three)&& binsof(wild_rdata.full );
	bins empy= binsof(addr_value.addr_three)&& binsof(wild_rdata.empty );	
}
  endgroup: r_cg
covergroup w_cg with function sample(bit[7:0] wdata,bit[1:0] addr);     
    wdata_value: coverpoint wdata {
      bins data_min = {0};
      bins data_low_range = {[1:127]};
      bins data_high_range = {[128:254]};
      bins data_max = {255};
    }
 wild_wdata: coverpoint wdata{
    wildcard bins clr =  {8'b0001????};
    
}
    addr_value: coverpoint addr {
      bins addr_zero = {0};
      bins addr_one = {1};
      bins addr_two = {2};
      bins addr_three = {3};
    }
    wdataXaddr: cross wild_wdata, addr_value{
	bins clear= binsof(addr_value.addr_three)&& binsof(wild_wdata.clr );
}
  endgroup: w_cg
 extern function new(string name, uvm_component parent=null);
endclass: b2gfifo_covergroup

 function b2gfifo_covergroup:: new(string name, uvm_component parent=null);
    super.new(name,parent);
    r_cg=new();
    r_cg.set_inst_name("r_cg");
    w_cg=new();
    w_cg.set_inst_name("w_cg");
endfunction: new
