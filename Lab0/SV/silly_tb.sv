`timescale 1ns / 1ps
module tb ();

	logic        a;
	logic 	     b;
	logic 	     c;
	logic        sum;
	logic        cout;
	
	// logic y; // not needed in lab 0, was just given in silly_tb.sv file as an example
	
   	logic        clk;   
   
	// instantiate device under test - dut
   fulladder dut (a, b, c, sum, cout);

   // 2 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #10 clk = ~clk;
     end


   initial
     begin
	//all tests have 20ns delay from previous test, indicated by the #20
    	// tests 000
	#20  a = 1'b0;	
	#0   b = 1'b0;	
	#0   c = 1'b0;
	     
	//tests 001
	#20  a = 1'b0;	
	#0   b = 1'b0;	
	#0   c = 1'b1;

	//test 010
	#20  a = 1'b0;	
	#0   b = 1'b1;	
	#0   c = 1'b0;	
	     
	//tests 011
	#20  a = 1'b0;	
	#0   b = 1'b1;	
	#0   c = 1'b1;	

	//tests 100
	#20  a = 1'b1;	
	#0   b = 1'b0;	
	#0   c = 1'b0;	

	//tests 101
	#20  a = 1'b1;	
	#0   b = 1'b0;	
	#0   c = 1'b1;	

	//tests 110
	#20  a = 1'b1;	
	#0   b = 1'b1;	
	#0   c = 1'b0;	

	//tests 111
	#20  a = 1'b1;	
	#0   b = 1'b1;	
	#0   c = 1'b1;	

	//#20 a=1'b0;
	//#0 b=1'b0;
	//#0 c=1'b0;		//default -> not needed ! 
	
     end

   
endmodule
