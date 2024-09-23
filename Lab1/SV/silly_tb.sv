`timescale 1ns / 1ps		//1 ns display cycle, 1 ps calculation cycle 
module tb ();

	logic        [3:0]a;
	logic 	[3:0]b;
   logic 	cin;
	logic 	[3:0]sum;
   logic        cout;
   logic        clk;
   logic [4:0] sum_correct;


assign sum_correct = a + b + cin;
assign error_sum = sum != sum_correct; 
   
  // instantiate device under test
	
	ripple_carry_adder dut( a, b,  cin, sum, cout); //
	
	
   	//clock
	initial 
     	begin	
		clk = 1'b1;
		forever #10 clk = ~clk;
     	end

	//

integer handle3;
integer desc3;
integer i;

	initial 
		begin
			handle3 = $fopen("rca.out"); //generating a file
			desc3 = handle3;
			#4000 $finish; 
		end

initial
	begin
		for(i=0; i<175; i=i+1) //For loop for the number of iterations
			begin

				@(posedge clk) //Numbers generated at the positive edge of the clock
				begin
				a = $random;
				b = $random;
				cin=0;
				end

				@(negedge clk) //Numbers checked at the negative edge of the clock
				begin
					$fdisplay(desc3, "%h %h || %h | %h | %b", a, b, {cout,sum}, sum_correct, ({cout,sum}==sum_correct)); //Checks generated sums against golden vectors, verifying answers as correct
				end
			end
		end		


   
endmodule
	

