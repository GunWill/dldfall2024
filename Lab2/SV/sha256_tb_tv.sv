`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 120;   

   logic [MSG_SIZE-1:0] message;   
   logic [255:0] hashed;
   //logic [255:0] golden;

   logic 	 clk;
   logic [31:0]  errors;
   logic [31:0]  vectornum;
   logic [63:0]  result;
	// Size of [375:0] is size of vector in file: 120 + 256 = 375 bits

  //change this?
	logic [375:0] testvectors[511:0];
   
   integer 	 handle3;
   integer 	 desc3;
   integer 	 i;  
   integer   j;

   // Instantiate DUT
   top #(MSG_SIZE, 512) dut (message, hashed);

   // 1 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	handle3 = $fopen("sha256.out");
	vectornum = 0;
	errors = 0;		
	desc3 = handle3;
     end

  initial 
    begin

      $readmemb("sha256.tv", testvectors);
      vectornum =0; errors=0;
      reset=1 #22 ; reset=0;

    end

    // apply test vectors on rising edge of clk
   always @(posedge clk)
     begin

	     #1; result = testvectors[vectornum[255:0]] ; message = testvectors[vectornum[375:256]]; golden = result;
	     
       //put in message

    


         
	// Add message here : "Hello, SHA-256!"	
	//#1 message = 120'h48656c6c6f2c205348412d32353621;
	// Expected result 
        //#0 result = 256'hd0e8b8f11c98f369016eb2ed3c541e1f01382f9d5b3104c9ffd06b6175a46271;
       //assign golden = 256'hd0e8b8f11c98f369016eb2ed3c541e1f01382f9d5b3104c9ffd06b6175a46271;



         
     end  

   // check results on falling edge of clk
   always @(negedge clk)
     begin
	if (result != hashed)
          errors = errors + 1;
        $fdisplay(desc3, "%h %h || %h || %b", 
                  message, hashed, result, (result == hashed));
	vectornum = vectornum + 1;
       if (testvectors[vectornum] === 376'bx) 
          begin 
             $display("%d tests completed with %d errors", 
                      vectornum, errors);
             $finish;
          end
     end   

endmodule // stimulus