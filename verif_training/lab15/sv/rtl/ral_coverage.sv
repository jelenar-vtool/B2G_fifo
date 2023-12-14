class ral_coverage extends uvm_object;

`uvm_object_utils(ral_coverage)

covergroup ra_cov(string name) with function sample(uvm_reg_field field_name , bit is_read);

	option.per_instance = 1; 
	option.name = name;
	REG: coverpoint ral { 
  		wildcard bins underflow =  {8'b00001??1};
    		wildcard bins overrflow =  {8'b00000110};
		wildcard bins full =  {8'b00000?10};
		wildcard bins empty =  {8'b0000?001};
                wildcard bins clr =  {8'b0001????};
		}
// Standard code - always the same
	RW: coverpoint is_read {
		bins RD = {1};
		bins WR = {0};
		}
	ACCES: cross REG, RW;
endgroup: ral
function new(string name = "ral_coverage"); 
ral = new(name);
    r_cg.set_inst_name("ral");
endfunction


