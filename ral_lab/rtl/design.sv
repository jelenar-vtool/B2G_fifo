/******************************************************/
//############ AHB SLAVE INTERFACE FOR REGISTERS ##############//
// AUTHOR: VTOOL company //
// SUPPORTS SINGLE WORD TRANSFER ONLY ///
// IF TRYED TO ACCESS OTHER THAN SINGLE WORD TRANSFER,XFER_ERROR_ACCESS ASSERTS ///
// SUPPORTS SLAVE ERROR RESPONSE FOR WRONG ADDRESS ///////////////////////////////

module AHB_REGISTERS(HCLK,
                     HRESETN,
                     HADRESS,
                     HTRANS,
                     HWRITE,
                     HSIZE,
                     HBURST,
                     HWDATA,
                     HSELx,
                     HRDATA,
                     HREADY_IN,
                     HREADY_OUT,
                     HRESP,
                     XFER_ERROR_ACCESS);
  
  //INPUT
  
  input HCLK;
  input HRESETN;
  input HWRITE;
  input [31:0] HADRESS;
  input [31:0] HWDATA;
  input [1:0] HTRANS;
  input [2:0] HSIZE;
  input [2:0] HBURST;
  input HSELx;
  input HREADY_IN;
  //output
  output reg [31:0] HRDATA;
  output reg HREADY_OUT;
  output reg [1:0] HRESP;
 
  
  reg hsel1;
  reg hsel2;
  reg hsel3;
  reg hsel4;
  reg derror;
  
  localparam A_REG1=16'h0000;
  localparam A_REG2=16'h0004;
  localparam A_REG3=16'h0008;

  
  output reg XFER_ERROR_ACCESS;
  
  reg [31:0] A_REGISTER1; //WRITE AND READ 
  reg [31:0] A_REGISTER2; //WRITE ONLY
  reg [31:0] A_REGISTER3; //READ ONLY

  reg [31:0] A_MEMORY[15:0];
  
  reg [31:0] in_address;
  reg a_en;
 
  
  
  
  
  always @(posedge HCLK or negedge HRESETN)
    begin
      if(!HRESETN)begin
        HREADY_OUT<=1;
        hsel1<=0;
        hsel2<=0;
        hsel3<=0;
        derror<=0;
        HRESP<=0;
      end
      
      else if(HSELx==1&&HTRANS==2&&HREADY_IN==1&&HSIZE==2&&HBURST==0)
      begin
        //$display("hitted this address");
        in_address<=HADRESS;
        a_en<=1;
        HREADY_OUT<=0 ;
      end
      
      else if((HTRANS==0)||(HTRANS==1))begin
         HREADY_OUT<=1;
        //FOR DEBUGGING SHOULD BE REMOVED
     //   $display("HITTED THIS AREA");
        end
      
      else if(HTRANS==3 ||(!(HSIZE==2)) ||(!(HBURST==0)))
        begin
        HREADY_OUT<=1;
        XFER_ERROR_ACCESS<=1;
        end
     end
  
  
  
  always@(a_en)
    begin
      //$display("the in_address %h",in_address);
      if(in_address[15:0]==A_REG1&a_en)
        begin
         hsel1<=1;
         HRESP<=0;
         a_en<=0;end

      else if(in_address[15:0]==A_REG2&a_en)  
       begin
         hsel2<=1;
         HRESP<=0;
         a_en<=0;end

      else if(in_address[15:0]==A_REG3&a_en)  
       begin
         hsel3<=1;
         HRESP<=0;
         a_en<=0;end
         
	  else if((16'h000A <= in_address[15:0] ) && (in_address[15:0] <= 16'h0019 )& a_en) begin
			hsel4<=1;
			HRESP<=0;
			a_en<=0; 
	  end
      else if(((in_address[15:0] != (A_REG1 ||A_REG2|| A_REG3) && (16'h000A >=in_address[15:0] ) && (in_address[15:0] >=16'h0019 )))&a_en) begin
        HRESP<=1;
        a_en<=0; 
        derror<=1;end


	end
  
  
  
        
  always@(posedge HCLK or negedge HRESETN)
 
  begin
   
    if(!HRESETN)
      begin
        A_REGISTER1<=0;
        A_REGISTER2<=0;
        A_REGISTER3<=32'h76543210;
		for (int i=0; i<16; i++)
			A_MEMORY[i] <= 32'b0;
      end
      
 else if(hsel1==1)
    begin
      if(HWRITE==1) begin
        A_REGISTER1<=HWDATA;
        HREADY_OUT<=1;
         hsel1<=0;
      end
      else begin
         HRDATA<=A_REGISTER1;
        HREADY_OUT<=1;
        hsel1<=0;
      end
    end

  else if(hsel2==1)
    begin
      if(HWRITE==1) begin
        A_REGISTER2<=HWDATA;
        HREADY_OUT<=1;
       hsel2<=0;
      end
    end

  else if(hsel3==1)
    begin
      if(HWRITE==0) begin
        HRDATA<=A_REGISTER3;
        HREADY_OUT<=1;
        hsel3<=0;
      end
    end

  else if(hsel4==1)
    begin

      if(HWRITE==1) begin
		A_MEMORY[in_address-32'ha]<=HWDATA;
        HREADY_OUT<=1;
        hsel4<=0;
      end

      else if(HWRITE==0) begin
        HRDATA<=A_MEMORY[in_address-32'ha];
        HREADY_OUT<=1;
        hsel4<=0;
      end
    end
    
    else if(derror==1)
      begin
        HREADY_OUT<=1;
        derror<=0;
      end
 
    
  end
  
  
  
endmodule

  
