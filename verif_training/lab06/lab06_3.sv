  // The rest of your module
  // ...//lab 6.1
//def tipa 


class Frame;
   rand  bit [7:0] payload;
   bit parity;
  


     function new();
	


     endfunction
  

    function  void update_parity();
       // bit parity=0;
       foreach (payload[i]) begin
      this.parity ^=payload[i];
         
         end
     // $display("payload %b, parity %b",payload, parity);
   	endfunction
  
    function void corrupt();

	parity=~parity;
    endfunction
  
    function int check_parity();
 	bit check=0;
       foreach (payload[i]) begin
      check ^=payload[i];
    end
	// $display(parity, check);
      
     // $display("U cek periti payload %b, calc parity %b",payload, check);

      if (parity==check) return 1;
	else return 0;
    endfunction 

endclass  

class Start_frame extends Frame;
  function new();
    super.new();
    payload = 8'hFF; // Fixed payload
    update_parity();
  endfunction
endclass 

class End_frame extends Frame;
  function new();
    super.new();
    payload = 8'hFE; // Fixed payload
   update_parity();
  endfunction
endclass

class High_payload_frames extends Frame; 
  function new();
    super.new();
   payload = 8'hF0; // konstanta
  endfunction
  constraint high_payload_constraint { payload dist {[8'h00:8'hEF] := 1, [8'hF0:8'hFF] := 9}; }

endclass

class Base_packet;

  rand bit[4:0] queue_length;         
  Frame frames_q[$];              


  function new();
    this.queue_length=queue_length;             
    this.frames_q =frames_q;            // Initialize an empty queue
  endfunction
  virtual task populate;
    
  //  $display("aaaaaaa queue_length %d", queue_length);
	for (int i = 0; i < queue_length; i++) begin
     	 	Frame frame = new();
      		frame.randomize();        // Randomize Frame object
			frame.update_parity();       
      		frames_q.push_back(frame);  // push back na queue
    //  $display("Frame %b, indeks %d", frames_q[$].payload, i);
    end
  endtask

  function void print();
    	$display("Frames in the packet:");
    	foreach (frames_q[i]) begin
          $display("Frame[%0d] = %b",i, frames_q[i].payload);
   		end
  endfunction
  
  virtual function void replace_frame(int i, Frame newframe);
	if(i<= queue_length ) begin
		frames_q[i]= newframe;
	end
  endfunction
    function int check_frame_corruption(); //detects if there is a frame with corrupted parity.
      foreach (frames_q[i])begin 
      if (frames_q[i].check_parity() == -1) return -1; 
      else return 0;
      end 
    
     
  endfunction 
  
endclass

class uart_packet extends Base_packet;

  function new();
    Frame frame;
    Start_frame start;
    End_frame endic;
    super.new();
    frame = new();
    start=new();
    endic=new();
    queue_length=8;

	frames_q.push_front(start);
 	frames_q.push_back(endic);
  endfunction 
  task populate; //add random frames to uart_packet
    for (int i = 1; i < queue_length-1; i++) begin
     	Frame frame = new();
      	frame.randomize();        // Randomize Frame object
      frame.update_parity();
      	frames_q.insert(i,frame);  // upise se Frame 
    end
  endtask

  function void replace_frame(int i, Frame newframe); 	 // it can't replace first and last frame
    if (!(i==1 && i == queue_length-1)) begin 
      frames_q.insert(i,newframe);
	end
  endfunction 
  


endclass 

module test;

  // Define your classes (Base_packet, uart_packet, Frame, High_payload_frames)
  // ...

  initial begin
    
    int random_packet_index=0;
    int random_index =0;
    int i=0;
    int j=0;
    int result=0;
    int return1=0;
    Frame frames;
    Base_packet base_packet;
    uart_packet uart_packe;
    High_payload_frames corrupted_frame;
    Base_packet packet_q[$];
    frames= new();
    frames.randomize();
    frames.update_parity();
     corrupted_frame=new();


    //some randomized Base_packet objects
    for (int i = 0; i < 5; i++) begin
      base_packet =new();
      base_packet.randomize();
      base_packet.populate();
	 packet_q.push_back(base_packet);
    //  $display("Frame[%0d] = %p",i, packet_q[i]);
	end
    // Add some randomized uart_packet objects
    for (int i = 5; i < 40; i++) begin
      uart_packe=new();
      uart_packe.populate();
      packet_q.push_back(uart_packe);
     
    end

    // Generate and corrupt 15 High_payload_frames objects
    for (int i = 0; i <15; i++) begin
     corrupted_frame.randomize();
      corrupted_frame.corrupt();
    //corrupted_frame.update_parity();
      // Insert the corrupted frames into random packets in packet_q
      random_packet_index = $urandom_range(0, packet_q.size() );
      random_index = $urandom_range(0, 7);
      packet_q[random_packet_index].replace_frame(random_index,corrupted_frame);
           //$display("random_packet_index[%0d].", random_packet_index);
           // $display("random_index[%0d].", random_index);
    //  $display("Packet[%0d] = %p",random_packet_index, packet_q[random_packet_index].frames_q[random_index]);

     end
	foreach (packet_q[i]) begin
       
      //$display("Packett[%0d].", i);
             foreach (packet_q[i].frames_q[j]) begin
	 //$display(" Frame[%0d] = %p",j, packet_q[i].frames_q[j]);
               if(packet_q[i].frames_q[j].check_parity()==0)begin 
                 $display("Corrupted frames found in packet[%0d].", i);
                 $display(" Frame[%0d] = %p",j, packet_q[i].frames_q[j]);
               end 
            end
    end
     
    // Check for corrupted frames in each packet
     /*foreach (packet_q[i]) begin
         result = packet_q[i].check_frame_corruption();
        if (result == -1) begin 
             $display("Corrupted frames found in packet[%0d].", i);
             foreach (packet_q[i].frames_q[j]) begin

            if (packet_q[i].frames_q[j].check_parity()== -1) begin
              $display(" CoruptedFrame[%0d] = %p",j, packet_q[i].frames_q[j]);
            end
           
                end
   
        end 
     end */
      
   

  end 


endmodule

