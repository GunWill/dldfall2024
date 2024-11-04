module FSM (input logic clk, reset, input logic [1:0] LR, output logic [5:0] light);

   typedef enum 	logic [3:0] {S0, S1, S2, S3, S4, S5, S6, S7, S8, S9} statetype;
   statetype [3:0] state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  light <= 6'b000000;	  
	  if (LR == 2'b00) nextstate <= S0;
	  else if (LR == 2'b10)   nextstate <= S1;
    	  else if (LR == 2'b01)   nextstate <= S4;
   	  else if (LR == 2'b11)   nextstate <= S7;
       end
       S1: begin
	  light <= 6'b100000;	  	  
	 nextstate <= S2;
       end
       S2: begin
	  light <= 6'b110000;	  	  
	  nextstate <= S3;
       end
       S3: begin
	  light <= 6'b111000;	  
	  nextstate <= S0;
       end
       S4: begin
	  light <= 6'b000100;	  
	  nextstate <= S5;
       end
       S5: begin
	  light <= 6'b000110;	  
	  nextstate <= S6;
       end
       S6: begin
	  light <= 6'b000111;	  
    	  nextstate <= S0;
       end
       S7: begin
	  light <= 6'b100100;	  
	  nextstate <= S8;
       end
       S8: begin
	  light <= 6'b110110;	  
	  nextstate <= S9;
       end
       S9: begin
	  light <= 6'b111111;	  
    	  nextstate <= S0;
       end

       default: begin
	  light <= 6'b000000;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule
