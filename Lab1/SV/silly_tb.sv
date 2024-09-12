`timescale 1ns / 1ps		//1 ns display cycle, 1 ps calculation cycle 
module tb ();

   logic        a;
   logic 	b;
   logic 	c;
   logic        c0, c1, c2;
   logic 	sum;
   logic        cout;
   logic        clk;  


assign sum_correct = a + b + c;
assign cout_correct = a&b | a&c | b&c;
assign error_sum = sum != sum_correct; 
assign error_out = cout != cout_correct;
   
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
				end

				@(negedge clk)
				begin
					$fdisplay(desc3, "%h %h || %h | %h | %b", a, b, sum, sum_correct, (sum==sum_correct));
				end
			end
	end
				


   
endmodule
