module fifo_basic( 
		clk, 
		rst,
		data_in, 
		read,
		write,
		enable, 
		data_out, 
		empty, 
		full
		); 

input  		clk; 
input 		rst;
input 		read;
input 		write;
input 		enable;
input   [7:0]	data_in;	
output 		empty; 
output		full;
output  [7:0] 	data_out;  
reg     [7:0] 	data_out; 
reg     [7:0] 	fifo [7:0]; 

reg     [2:0]  	counter    = 0;
reg 	[2:0] 	rd_counter = 0; 
reg	[2:0]   wr_counter = 0; 

//assign wr_counter 		= 0; 
//assign counter 		= 0;
//assign rd_counter		= 0;
assign empty = (counter == 0) ? 1'b1 : 1'b0; 
assign full  = (counter == 8) ? 1'b1 : 1'b0; 

always @ (posedge clk) 
begin 
  if (enable == 0); 
    else 
      begin 
        if (rst) 
        begin 
          rd_counter 	  = 0; 
          wr_counter 	  = 0; 
        end 
    else if (read == 1'b1 && counter!= 0) 
      begin 
	data_out  	  = fifo[rd_counter]; 
	rd_counter 	  = rd_counter+1; 
      end
    else if (write ==1 && counter<8) 
      begin
   	fifo[wr_counter]  = data_in; 
	wr_counter  	  = wr_counter+1; 
    end
    else; 
  end 

 if (wr_counter == 8) 
	wr_counter	  = 0; 
 else if (rd_counter == 8) 
	rd_counter	  = 0; 
 else;

 if (rd_counter > wr_counter) 
 begin 
	counter = rd_counter - wr_counter; 
 end 
 else if (wr_counter > rd_counter) 
  	counter = wr_counter - rd_counter; 
 else;

end 

endmodule
