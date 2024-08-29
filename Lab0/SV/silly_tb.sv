`timescale 1ns / 1ps
module tb ();

	logic        [2:0] a;
	logic 	[2:0] b;
	logic 	[2:0] c;
	logic 	[1:0] y;
   logic        clk;   
   
  // instantiate device under test
   silly dut (a, b, c, y);

   // 2 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end


   initial
     begin
    
	#20  a = 1'b0;	
	#0   b = 1'b0;	
	#0   c = 1'b0;

	#20  a = 1'b0;	
	#0   b = 1'b0;	
	#0   c = 1'b1;

	#20  a = 1'b0;	
	#0   b = 1'b1;	
	#0   c = 1'b0;	

	#20  a = 1'b0;	
	#0   b = 1'b1;	
	#0   c = 1'b1;	

	#20  a = 1'b1;	
	#0   b = 1'b0;	
	#0   c = 1'b0;	

	#20  a = 1'b1;	
	#0   b = 1'b0;	
	#0   c = 1'b1;	

	#20  a = 1'b1;	
	#0   b = 1'b1;	
	#0   c = 1'b0;	

	#20  a = 1'b1;	
	#0   b = 1'b1;	
	#0   c = 1'b1;	

	#20 a=1'b0;
	#0 b=1'b0;
	#0 c=1'b0;		//default 
	
     end

   
endmodule
