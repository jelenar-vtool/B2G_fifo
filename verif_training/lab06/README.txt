//lab 6.1
// Define the enumerator "trans_t"
typedef enum logic [1:0] { SINGLE = 2'b00, BURST = 2'b01 } trans_t;

sv_class Packet;
  // Declare class fields
  int packet_length;
  reg [31:0] start_address;
  trans_t burst_type;
  reg [31:0] data_queue[$];

  // Constructor with arguments
  function new(int packet_length, reg [31:0] start_address, trans_t burst_type);
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
        $finish;
      end
      // For a SINGLE burst, you can randomize the data here
      data_queue.push_back($random);
    end
  endfunction

  // Member function to print packet information
  function void print;
    $display("Start Address: 0x%h", start_address);
    $display("Packet Length: %d", packet_length);
    $display("Burst Type: %s", burst_type.name());
  endfunction
endclass

sv_class Memory;
  logic [31:0] memory [0:255][0:31];
  
  function void write(Packet packet);
    int start_addr = packet.start_address;
    foreach (packet_data) packet.data_queue
      memory[start_addr/32][start_addr%32] = packet_data;
      start_addr += 32;
    end
  endfunction

  function void read(logic [31:0] start_address, int read_length);
    $display("Read from memory starting at address 0x%h for %d words:", start_address, read_length);
    for (int i = 0; i < read_length; i++) begin
      $display("memory[%d][%d] = 0x%h", (start_address + i) / 32, (start_address + i) % 32, memory[(start_address + i) / 32][(start_address + i) % 32]);
    end
  endfunction
endclass

module MemoryTest;
  initial begin
    // Instantiate two Packet objects
    Packet packet1 = new(4, 0, Packet::trans_t::BURST);
    Packet packet2 = new(1, 128, Packet::trans_t::SINGLE);
    
    // Instantiate Memory object
    Memory mem;

    // Write packets to memory
    mem.write(packet1);
    mem.write(packet2);

    // Display memory content
    mem.read(0, 8);
    mem.read(128, 2);
  end
endmodule
