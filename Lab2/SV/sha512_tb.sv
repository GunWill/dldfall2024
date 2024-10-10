`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 112;   

   logic [MSG_SIZE-1:0] message;   
	logic [512:0] hashed;
	logic [512:0] golden;

   assign golden = 512'hD693DB7749949506622261A533EF98E54ED5F60920F60AD03BC338D05BD9C90514919AE8B3DE1F25F7D99F87B0565D0A402493C5B40166A5EB7665C9E3ACAF2B;

   logic 	 clk;

	//do we need to change these sizes?
	
   logic [31:0]  errors;
   logic [31:0]  vectornum;
   logic [63:0]  result;
   // Size of [351:0] is size of vector in file: 96 + 256 = 352 bits
   logic [351:0] testvectors[511:0];
   
   integer 	 handle3;
   integer 	 desc3;
   integer 	 i;  
   integer       j;

   // Instantiate DUT
	//num was 512 but chnaged to 1024, ????
	
	top #(MSG_SIZE, 1024) dut (message, hashed);

   // 1 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	     handle3 = $fopen("sha512.out");
	vectornum = 0;
	errors = 0;		
	desc3 = handle3;
     end

    // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin
	// Add message here : "Hello SHA-512!"	
	#1 message = 112'h48656c6c6f205348412d35313221;
	// Expected result 
        #0 result = 512'hD693DB7749949506622261A533EF98E54ED5F60920F60AD03BC338D05BD9C90514919AE8B3DE1F25F7D99F87B0565D0A402493C5B40166A5EB7665C9E3ACAF2B;	
     end  

   // check results on falling edge of clk
   always @(negedge clk)
     begin
	if (result != hashed)
          errors = errors + 1;
        $fdisplay(desc3, "%h %h || %h || %b", 
                  message, hashed, result, (result == hashed));
	vectornum = vectornum + 1;
	     if (testvectors[vectornum] === 352'bx) //do i need to change this ?
          begin 
             $display("%d tests completed with %d errors", 
                      vectornum, errors);
             $finish;
          end
     end   

endmodule // stimulus
