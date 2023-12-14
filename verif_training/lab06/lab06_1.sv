//lab 6.1
//def tipa 
typedef enum logic { SINGLE, BURST} trans_t;



class Packet;
  //fields
  int packet_length;
  bit [31:0] start_address;
  trans_t burst_type;
  bit [31:0] data_queue[$];

  // Constructor with arguments
  function new(int packet_length, bit [31:0] start_address,trans_t burst_type);
	int temp;
	this.packet_length = packet_length;
    	this.start_address = start_address;
    	this.burst_type = burst_type;
		
    // Initialize the queue of data based on burst type
    if (burst_type == BURST) begin
     	 for (int i = 0; i < packet_length; i++) begin
			temp=start_address + i;
			data_queue.push_back(temp);

			$display(temp);
    	 end
    end 
    else if (burst_type == SINGLE) begin
     	 if (packet_length != 1) begin
      		$display("ERROR: Packet length must be 1 for SINGLE burst type.");
        	$finish;
      	 end else if(packet_length != 1) begin
         	data_queue.push_back(start_address);
      	end   
      	data_queue.push_back($random);
   end
  endfunction

  function void print;
    $display("Start Address: 0x%h", start_address);
    $display("Packet Length: %d", packet_length);
    $display("Burst Type: %s", burst_type.name());
  endfunction
endclass




class Memory;
 // Packet packet;
  bit [31:0] memory [255:0];

  function new();
  	  this.memory= memory;
  endfunction  
  function void write(Packet packet);
    //packet (object of Packet class) as an input argument, and updates the memory locations accordingly - starting from start_address of packet
    bit [31:0] start_addr= packet.start_address;
    for(int i=0; i< packet.data_queue.size(); i++) begin 
    	memory[start_addr]= packet.data_queue[i];
      	start_addr += 1;    
			$display("start_addr:0x%h ",start_addr);
			$display("packet.data_queue[i]:0x%h ",packet.data_queue[i]);
			$display("packet.data_queue[i]:0x%h ",packet.data_queue[i]);
			$display("memory[start_addr]:0x%h ",memory[start_addr][i]);

	end   

  endfunction 
   
  // Read and print memory content
  function void read(int start_addr, int read_length);
    for (int i = 0; i < read_length; i++) begin 
      $display("Memory[0x%h] = 0x%h",(start_addr + i), memory[start_addr]);
    end
  endfunction
 
    
endclass




module MemoryTest;
  initial begin
    // Instantiate two Packet object, Memory
    Packet packet1 = new(10, 1, BURST);
    Packet packet2 = new(11, 1, SINGLE);

    Memory memory = new();
    Memory memory1 = new();
    packet1.print();
    packet2.print();

    memory.write(packet1);
    memory.write(packet2);

    memory.read(1, 11);
    $display("----");
    //memory.read(1, 2);



  end
endmodule
