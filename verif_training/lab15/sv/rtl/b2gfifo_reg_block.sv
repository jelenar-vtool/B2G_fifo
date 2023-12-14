class b2gfifo_reg_block extends uvm_reg_block;
  `uvm_object_utils(b2gfifo_reg_block)

	rand b2gfifo_reg CTL_STAT;//RW
	ral_coverage cg;
    function new(string name="b2gfifo_reg_block");
		super.new(name, UVM_NO_COVERAGE);
	endfunction
    extern virtual function void build();
	
	/*function void add_hdl_path (
	   	uvm_hdl_path_slice 	slices[],	  	
	   	string 	kind	 = 	"RTL"
	)
function void add_hdl_path_slice(
   	string 	name,	  	
   	int 	offset,	  	
   	int 	size,	  	
   	bit 	first	 = 	0,
   	string 	kind	 = 	"RTL"
)*/
endclass:b2gfifo_reg_block
//--------------------------------------------------------------------
function void b2gfifo_reg_block::build();
    CTL_STAT = b2gfifo_reg::type_id::create("CTL_STAT");
    CTL_STAT.build();
    CTL_STAT.configure(this);
    CTL_STAT.add_hdl_path_slice("CTL_STAT", 0, 8);      // name, offset, bitwidth, sta je ovaj nemae?????????

 	default_map = create_map("default_map", 0,1, UVM_LITTLE_ENDIAN); // name, base, nBytes
    default_map.add_reg(this.CTL_STAT, 8'h3, "RW");  // reg, offset, access
	default_map.set_auto_predict(1);
	default_map.set_check_on_read(1);
	lock_model();


endfunction: build

