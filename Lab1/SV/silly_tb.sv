`timescale 1ns / 1ps		//1 ns display cycle, 1 ps calculation cycle 
module tb ();

   logic        a;
   logic 	b;
   logic 	c;
   logic 	sum;
   logic        cout;
   logic        clk;   
   
  // instantiate device under test
	
	fulladder_1 dut (a, b, c, sum, cout);
	
   // 20 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end


   initial
     begin

	//all inputs have a 20ns delay

	//testing truth table of the fulladder 
    
	#20  a = 1'b0;
	#0   b = 1'b0;
	#0   c = 1'b0;

	#20  a = 1'b1;
	#0   b = 1'b0;
	#0   c = 1'b0;

	#20  a = 1'b0;
	#0   b = 1'b1;
	#0   c = 1'b0;

	#20  a = 1'b1;
	#0   b = 1'b1;
	#0   c = 1'b0;

	#0   a = 1'b0;	
	#0   b = 1'b0;
	#0   c = 1'b1;

	#20  a = 1'b1;
	#0   b = 1'b0;
	#0   c = 1'b1;

	#20  a = 1'b0;
	#0   b = 1'b1;
	#0   c = 1'b1;

	#20  a = 1'b1;
	#0   b = 1'b1;
	#0   c = 1'b1;		


	
     end

   
endmodule
