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
    
	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;	

	#20  a = $random;	
	#0   b = $random;	
	#0   c = $random;		
	
     end

   
endmodule
