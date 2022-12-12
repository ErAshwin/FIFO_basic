`timescale 1ns / 1ps

module fifo_basic_tb;

 reg 	    clk;
 reg [7:0] data_in;
 reg 	    read;
 reg 	    write;
 reg 	    enable;
 reg  	    rst;

 wire [7:0] data_out;
 wire 	     empty;
 wire 	     full;


fifo_basic i_fifo(
                  .clk		(clk), 
                  .data_in	(data_in), 
                  .read		(read), 
                  .write	(write), 
                  .enable	(enable), 
                  .data_out	(data_out), 
                  .rst		(rst), 
                  .empty	(empty), 
                  .full		(full)
                  );

 initial 
 begin
	 $display("Starting Testbench");
  		clk  		= 1'b0;
 		data_in  	= 8'hz;
  		read  		= 1'b0;
 		write  		= 1'b0;
  		enable  	= 1'b0;
  		rst  		= 1'b1;

  #100;         enable  	= 1'b1;
  		rst  		= 1'b1;
  #20;		rst  		= 1'b0;
  		write  		= 1'b1;

		data_in 	= 8'h0;
  #20;		data_in 	= 8'h1;
  #20;		data_in 	= 8'h2;
  #20;		data_in 	= 8'h3;
  #20;		data_in 	= 8'h4; 
  #20;		data_in 	= 8'h5; 
  #20;		data_in 	= 8'h6; 
  #20;		data_in 	= 8'h7;

  #20;		write 		= 1'b0;
	 $display("DATA WRITE COMPLETE");
  		read 		= 1'b1;
  #160;		read 		= 1'b0;
	 $display("DATA READ COMPLETE");
  #800 $finish;	
	
 end 

 initial begin
	clk = 0;
   	forever #10 clk = ~clk;    
 end

 initial begin
	 $monitor("simtime = %0t\t\tdataIN = %0d\tdataOUT = %0d",$time, data_in, data_out);
	 $dumpfile("fifo_basic.vcd");
	 $dumpvars();
 end

endmodule
