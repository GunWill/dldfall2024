`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 112;   

   logic [MSG_SIZE-1:0] message;   
	logic [511:0] hashed;
	logic [511:0] golden;

  // assign golden = 512'hD693DB7749949506622261A533EF98E54ED5F60920F60AD03BC338D05BD9C90514919AE8B3DE1F25F7D99F87B0565D0A402493C5B40166A5EB7665C9E3ACAF2B;

   logic 	 clk;

	//do we need to change these sizes?
	
	logic [63:0]  errors;
	logic [63:0]  vectornum;
	logic [127:0]  result;
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
   initial
     begin
	// Add message here : "Hello SHA-512!"	
	#1 message = 112'h48656c6c6f205348412d35313221;
	// Expected result 
        #0 result = 512'hD693DB7749949506622261A533EF98E54ED5F60920F60AD03BC338D05BD9C90514919AE8B3DE1F25F7D99F87B0565D0A402493C5B40166A5EB7665C9E3ACAF2B;
	     #0 golden = 512'hD693DB7749949506622261A533EF98E54ED5F60920F60AD03BC338D05BD9C90514919AE8B3DE1F25F7D99F87B0565D0A402493C5B40166A5EB7665C9E3ACAF2B;
     
     //"OSU ROCKS! YAY"
  #200 message = 112'h4f535520524f434b532120594159;
     #0 result = 512'h4c3076f620c46d2a350fc0459f85d8454539ff314ad9b873a782e1b837da837c1a972eacea14cfcdec571b66957451574f664a65066412e2504ad3ae61749b0c;
     #0 golden = 512'h4c3076f620c46d2a350fc0459f85d8454539ff314ad9b873a782e1b837da837c1a972eacea14cfcdec571b66957451574f664a65066412e2504ad3ae61749b0c;


     //"Christmas!!!!!"

  #200 message = 112'h4368726973746d61732121212121;
     #0 result = 512'h9c8c5301dd51c49e3f0adb2cd24bf1df1219f5c5c6983dc208301f032f16119cd11f092886ffccdd702761d6ad52521bba6e076b66910a8c27bd2c836f9e4ec7;
     #0 golden = 512'h9c8c5301dd51c49e3f0adb2cd24bf1df1219f5c5c6983dc208301f032f16119cd11f092886ffccdd702761d6ad52521bba6e076b66910a8c27bd2c836f9e4ec7;


     //"No More Tests!"

  #200 message = 112'h4e6f204d6f726520546573747321;
     #0 result = 512'h6ab4611f0729f0675686a4b661ebaef732b1a69c1c936f455b26d9a0f9ad4c133686aa13ae257841f0207ff053ead36649212ab22abc271f7ecf7c697fa20b9b;
     #0 golden = 512'h6ab4611f0729f0675686a4b661ebaef732b1a69c1c936f455b26d9a0f9ad4c133686aa13ae257841f0207ff053ead36649212ab22abc271f7ecf7c697fa20b9b;

     //"Thanksgiving!!"

  #200 message = 112'h5468616e6b73676976696e672121;
     #0 result = 512'h8d5a91c2a2c50b4c18c43dbba7f43d2c4ec51033a2241fd39ce6f7430381f08bc84b4fbfee8fe5a433d2110e0052b721595b1794f35ff47151d4e7ee00f685d0;
     #0 golden = 512'h8d5a91c2a2c50b4c18c43dbba7f43d2c4ec51033a2241fd39ce6f7430381f08bc84b4fbfee8fe5a433d2110e0052b721595b1794f35ff47151d4e7ee00f685d0;

     
     end  

   // check results on falling edge of clk
   initial
     begin
	if (result != hashed)
          errors = errors + 1;
        $fdisplay(desc3, "%h %h || %h || %b", 
                  message, hashed, result, (result == hashed));
	//vectornum = vectornum + 1;
	    // if (testvectors[vectornum] === 352'bx) //do i need to change this ?
          //begin 
            //$display("%d tests completed with %d errors", 
                     // vectornum, errors);
            // $finish;
         // end
     end   

endmodule // stimulus
