`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  reset; 
   
   logic  [1:0] LR;
   logic [5:0] light;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, LR, light);   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#5 $fdisplay(desc3, "%b || %b || %b", 
		     reset, LR, light);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#20  reset = 1'b0;	
	#0   LR = 2'b00;
	#50  LR = 2'b10;
	#50  LR = 2'b01;
     #50  LR = 2'b11;
     end

endmodule // FSM_tb