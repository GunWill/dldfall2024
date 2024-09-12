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
	
	
   //clock

	initial 
     	begin	
		clk = 1'b1;
		forever #10 clk = ~clk;
     	end

integer handle3;
integer desc3;
integer i;

	initial 
		begin
			handle3 = $fopen("rca.out");
			desc3 = handle3;
			#1250 $finish; 
		end

initial
	begin
		for(i=0; i<175; i+i+1)
			begin
				

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
