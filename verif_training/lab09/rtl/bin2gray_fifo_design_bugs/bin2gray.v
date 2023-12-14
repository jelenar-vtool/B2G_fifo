
module bin2gray (in, out);
  
  input wire [7:0] in;
  output wire [7:0] out;

  assign out = ~(in ^ (in >> 1));

endmodule    // bin_gray
