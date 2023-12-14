//lab 6.1
//def tipa 
typedef enum logic { SINGLE, BURST} trans_t;
typedef  enum logic [1:0] {
 	ENABLE  = 2'b00,
  	THRESHOLD_ADDRESS  = 2'b01,
  	THRESHOLD_LENGTH  = 2'b10,
  	RESET  = 2'b11
  } RegisterADR;
typedef  enum logic {READ, WRITE} RW; 


class Packet;
  //fields
  int packet_length;
  bit [31:0] start_address;
  trans_t burst_type;
  bit [31:0] data_queue[$];

  // Constructor with arguments
  function new(int packet_length, bit [31:0] start_address,trans_t burst_type);
		this.packet_length = packet_length;
    	this.start_address = start_address;
    	this.burst_type = burst_type;

    // Initialize the queue of data based on burst type
    if (burst_type == BURST) begin
     	 for (int i = 0; i < packet_length; i++) begin
			data_queue.push_back(start_address + i);
    	  end
    end else if (burst_type == SINGLE) begin
     	 if (packet_length != 1) begin
      		$display("ERROR: Packet length must be 1 for SINGLE burst type.");
        	
         end else if(packet_length == 1) begin
      		data_queue.push_back($random);

      	end   
      	//data_queue.push_back($random);
   end
  endfunction

  function void print;
    $display("Start Address: 0x%h", start_address);
    $display("Packet Length: %d", packet_length);
    $display("Burst Type: %s", burst_type.name());
  endfunction
endclass

class Configuration;
  
  RegisterADR reg_adr;
  RW  rw;
  bit [15:0] data;

  function new (RW  rw, RegisterADR reg_adr, bit [16:0] data);
    this.rw = rw;
    this.reg_adr = reg_adr;
    this.data = data;
  endfunction  
 
 /* function new (RW  rw, RegisterADR reg_adr);
    this.rw = rw;
    this.reg_adr = reg_adr;
    this.data = 0;
  endfunction  */

endclass

class Memory;
  Packet packet;
  bit [31:0] memory [255:0];
  logic [15:0] registers [0:3];
 // randomize (packet);
  function new();
    this.memory= memory;
    registers[ENABLE] = 16'h0000; // ENABLE
    registers[THRESHOLD_ADDRESS] = 16'h0001; // THRESHOLD_ADDRESS
    registers[THRESHOLD_LENGTH] = 16'h0010; // THRESHOLD_LENGTH
    registers[RESET] = 16'h0011; // RESET
  endfunction  
  function void write(Packet packet);
    //packet (object of Packet class) as an input argument, and updates the memory locations accordingly - starting from start_address of packet
    for (int i = 0; i < packet.packet_length; i++) begin 
      memory[packet.start_address + i] = packet.data_queue[i];
 	   
		//	$display("start_addr:0x%h ",start_addr);
			$display("packet.data_queue[i]:0x%h ",packet.data_queue[i]);
			//$display("memory[start_addr]:0x%h ",memory[start_addr][i]);
	end
  endfunction 
   
  // Read and print memory content
  function void read(int start_addr, int read_length);
    for (int i = 0; i < read_length; i++) begin 
      $display("Memory[0x%h] = 0x%h",(start_addr + i), memory[start_addr+i]);
    end
  endfunction
  
  function void corrupt(int memory_location_index, int memory_bit_position_index);
    memory[memory_location_index][memory_bit_position_index] = ~memory[memory_location_index][memory_bit_position_index];
  endfunction  
               
  
  function configure(Configuration configuration);
    logic [1:0] addr = configuration.reg_adr;
    
    if (configuration.rw == WRITE) begin 
      registers[addr]= configuration.data;
       memory[addr] = configuration.data;
    end else if (configuration.rw == READ) begin
       $display("Register[%d] = 16'h%h", addr, registers[addr]);
    end  
    
  endfunction 
    
endclass

/*class Frame;
    bit [7:0] payload;
    bit parity;
     function new(bit [7:0] payload, bit parity);
   		 this.payload = payload;
   	 	 this.parity = parity;
  	endfunction
endclass  */


module MemoryTest;
  initial begin
    // Instantiate two Packet object, Memory
    Packet packet1 = new(10, 1, BURST);
    Packet packet2 = new(1, 11, SINGLE);//packet_length,start_address,burst_type
    Configuration config_write= new(WRITE,RESET, 16'hAAAA);
    Configuration config_read = new(READ, ENABLE, 16'hA00A);
    Configuration config_read1 = new(READ, RESET, 16'hAA0A);
    //Configuration config_read;
     Memory memory = new();
      Memory memory1 = new();
    packet1.print();
    packet2.print();
    //Configuration config_write;
    memory.write(packet1);
    memory.write(packet2);
         //Apply configurations to the memory
    memory.configure(config_write);
    memory.configure(config_read);
    memory.configure(config_read1);
   memory.read(1, 10);//start_addr,read_length
    $display("----");
    memory.read(10, 3);



  end
endmodule

