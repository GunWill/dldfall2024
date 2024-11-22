`timescale 1ns/1ps
module stimulus;

   parameter MSG_SIZE = 120;   

   logic [MSG_SIZE-1:0] message;   
   logic [255:0] hashed;

   logic 	 clk;
   logic [31:0]  errors;
   logic [255:0] golden;


   top #(MSG_SIZE, 512) dut (
    .clk(clk),
    .reset(reset),
    .start(start),
    .message(message),
    .hashed(hashed),
    .done(done)
);

   // 1 ns clock
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end



   
   // apply test vectors on rising edge of clk

   always @(posedge clk)
     begin

     errors = 32'd0;

    //Add message here : "Hello, SHA-256!"	

	#1 message = 120'h48656c6c6f2c205348412d32353621;
    #0 golden = 256'hd0e8b8f11c98f369016eb2ed3c541e1f01382f9d5b3104c9ffd06b6175a46271;


    //Add message here : "Onomonopea!!!!!

    #45 message = 120'h4f6e6f6d6f6e6f7065612121212121;
    #0 golden = 256'ha9981acfc95bdf6639b1179a70958217cc691d7fe12cac70d02406798a4af676;


    //Add message here : "SassySasquatch!"

    #45 message = 120'h536173737953617371756174636821;
    #0 golden = 256'h6c71746ce552f1640cfb0eaf52cef686c9e45e4cdd7150def1a5da11ee7a3b25;


    //Add message here: "LiloAndStitch!!"

    #45 message = 120'h4c696c6f416e645374697463682121;
    #0 golden = 256'h5ed99fcb5cda7939fd089fe1435860638fe1af435e4d1710f705bdcb743f6262;

    //Add message here: "OSU Rocks !!!!!!"

    #45 message = 120'h4f535520526f636b73212121212121;
    #0 golden = 256'hbad9a6c7eff030cb83b1e45e78cae5c7b29df3c1c035424fb592f93877357828;
         
     end   




   // check results on falling edge of clk
  always @(negedge clk)
    begin
       if (golden != hashed)
            errors = errors + 1;
    end

endmodule // stimulus
