`timescale 1ns / 1ps		//1 ns display cycle, 1 ps calculation cycle 
module tb ();

	logic        [3:0]a;
	logic 	[3:0]b;
   logic 	c;
	logic 	[3:0]sum;
   logic        cout;
   logic        clk;
   logic [4:0] sum_correct;


assign sum_correct = a + b + c;
assign error_sum = sum != sum_correct; 

   
  // instantiate device under test
	
ripple_carry_adder dut( a, b,  c, sum, cout);
	
	
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
			handle3 = $fopen("rca.out"); //generating a file
			desc3 = handle3;
			#1250 $finish; 
		end

initial
	begin
		for(i=0; i<175; i=i+1)
			begin

				@(posedge clk)
				begin
				a = $random;
				b = $random;
				c=0;
				end

				@(negedge clk)
				begin
					$fdisplay(desc3, "%h %h || %h | %h | %b", a, b, {cout,sum}, sum_correct, ({cout,sum}==sum_correct));
				end
			end
	end
				


   
endmodule
