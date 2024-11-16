//
// Secure Hash Standard (SHA-256)
//

module top #(parameter MSG_SIZE = 120,
	     parameter PADDED_SIZE = 512)
   (input logic [MSG_SIZE-1:0] message,
    output logic [255:0] hashed);

   logic [PADDED_SIZE-1:0] padded;
   sha_padder #(.MSG_SIZE(MSG_SIZE), .PADDED_SIZE(PADDED_SIZE)) padder (.message(message), .padded(padded));
   sha256 #(.PADDED_SIZE(PADDED_SIZE)) main (.padded(padded), .hashed(hashed));
     counter dut(clk, rst, start, count);
   
endmodule // sha_256



module sha_padder #(parameter MSG_SIZE = 120,
		    parameter PADDED_SIZE = 512) 
   (input logic [MSG_SIZE-1:0] message,
    output logic [PADDED_SIZE-1:0] padded);

   localparam zero_width = PADDED_SIZE-MSG_SIZE-1-64;
   localparam back_0_width = 64-$bits(MSG_SIZE);
   
   assign padded = {message, 1'b1, {zero_width{1'b0}}, {back_0_width{1'b0}}, MSG_SIZE};

endmodule // sha_padder



module sha256 #(parameter PADDED_SIZE = 512)
   (input logic [PADDED_SIZE-1:0] padded,
    output logic [255:0] hashed);   

   logic [255:0] H = {32'h6a09e667, 32'hbb67ae85,
		      32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c,
		      32'h1f83d9ab, 32'h5be0cd19};   
	
   logic [2047:0] K = {32'h428a2f98, 32'h71374491, 32'hb5c0fbcf,
		       32'he9b5dba5, 32'h3956c25b, 32'h59f111f1, 32'h923f82a4,
		       32'hab1c5ed5, 32'hd807aa98, 32'h12835b01, 32'h243185be,
		       32'h550c7dc3, 32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7,
		       32'hc19bf174, 32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6,
		       32'h240ca1cc, 32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc,
		       32'h76f988da, 32'h983e5152, 32'ha831c66d, 32'hb00327c8,
		       32'hbf597fc7, 32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351,
		       32'h14292967, 32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc,
		       32'h53380d13, 32'h650a7354, 32'h766a0abb, 32'h81c2c92e,
		       32'h92722c85, 32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70,
		       32'hc76c51a3, 32'hd192e819, 32'hd6990624, 32'hf40e3585,
		       32'h106aa070, 32'h19a4c116, 32'h1e376c08, 32'h2748774c,
		       32'h34b0bcb5, 32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f,
		       32'h682e6ff3, 32'h748f82ee, 32'h78a5636f, 32'h84c87814,
		       32'h8cc70208, 32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7,
		       32'hc67178f2};

   logic [31:0]	  a, b, c, d, e, f, g, h;
   logic [31:0]   h0, h1, h2, h3, h4, h5, h6, h7;   
   logic [31:0] W, M;

   prepare p1 (padded[511:480], padded[479:448], padded[447:416],
	       padded[415:384], padded[383:352], padded[351:320],
	       padded[319:288], padded[287:256], padded[255:224],
	       padded[223:192], padded[191:160], padded[159:128],
	       padded[127:96], padded[95:64], padded[63:32],
	       padded[31:0], W );

   assign a = H[255:224];
   assign b = H[223:192];
   assign c = H[191:160];
   assign d = H[159:128];
   assign e = H[127:96];
   assign f = H[95:64];
   assign g = H[63:32];
   assign h = H[31:0];

//Muxes
   //s=select -> chooses either first input or outputs to continue with computation
   //A-Hout -> Output of computation
   //MuxA-Hout -> whichever choice is made with s, (a-h or A-Hout), Whichever path is gone down
   //a-h -> input a, defined before muxes

mux2 #(32) muxA ( a, Aout, en, muxAout);
mux2 #(32) muxB ( b, Bout, en, muxBout);
mux2 #(32) muxC ( c, Cout, en, muxCout);
mux2 #(32) muxD ( d, Dout, en, muxDout);
mux2 #(32) muxE ( e, Eout, en, muxEout);
mux2 #(32) muxF ( f, Fout, en, muxFout);
mux2 #(32) muxG ( g, Gout, en, muxGout);
mux2 #(32) muxH ( h, Hout, en, muxHout);

//needs each K value as an input, counter as s, and output y

mux64 #(32) muxK (K[2047:2016], K[2015:1984], K[1983:1952], K[1951:1920], K[1919:1888], K[1887:1856],
K[1855:1824], K[1823:1792], K[1791:1760], K[1759:1728], K[1727:1696], K[1695:1664], K[1663:1632], K[1631:1600],
K[1599:1568], K[1567:1536], K[1535:1504], K[1503:1472], K[1471:1440], K[1439:1408], K[1407:1376], K[1375:1344],
K[1343:1312], K[1311:1280], K[1279:1248], K[1247:1216], K[1215:1184], K[1183:1152], K[1151:1120], K[1119:1088], 
K[1087:1056], K[1055:1024], K[1023:992], K[991:960], K[959:928], K[927:896], K[895:864], K[863:832], K[831:800],
K[799:768], K[767:736], K[735:704], K[703:672], K[671:640], K[639:608], K[607:576], K[575:544], K[543:512], en, K);

 //Make another one for W0-W63

mux64 #(32) muxW (M, W, en, muxWout);


main_comp mc01 (muxAout, muxBout, muxCout, muxDout, 
		muxEout, muxFout, muxGout, muxHout, 
		K, W,
	    a0_out, b0_out, c0_out, d0_out, 
		e0_out, f0_out, g0_out, h0_out);



//registers
flopenr #(32) instanceA(clk, reset, en, a0_out, Aout);
flopenr #(32) instanceB(clk, reset, en, b0_out, Bout);
flopenr #(32) instanceC(clk, reset, en, c0_out, Cout);
flopenr #(32) instanceD(clk, reset, en, d0_out, Dout);
flopenr #(32) instanceE(clk, reset, en, e0_out, Eout);
flopenr #(32) instanceF(clk, reset, en, f0_out, Fout);
flopenr #(32) instanceG(clk, reset, en, g0_out, Gout);
flopenr #(32) instanceH(clk, reset, en, h0_out, Hout);




                                 
   intermediate_hash ih1 (Aout, Bout, Cout, d63_out,
			  e63_out, f63_out, g63_out, h63_out,
			  a, b, c, d, e, f, g, h,
			  h0, h1, h2, h3, h4, h5, h6, h7);

   assign hashed = {h0, h1, h2, h3, h4, h5, h6, h7};


endmodule // sha_main

//control logic

module FSM (
    input logic clk,
    input logic reset,
    input logic start,
    output logic [5:0] index, //number (0 to 63)
    output logic en,    //starts computation for the current round
    output logic done   //end of computation
);

   typedef enum logic [1:0] {S0, S1, S2} statetype;
   statetype state, nextstate;

   logic [5:0] count;

   // State register
   always_ff @(posedge clk or posedge reset) begin
       if (reset) 
           state <= S0;
       else 
           state <= nextstate;
   end

   //counter determines the round index 
   always_ff @(posedge clk or posedge reset) begin
       if (reset) 
           count <= 6'd0;
       else if (state == S1)
           count <= count + 6'd1;
   end

   // Next state logic
   always_comb begin
       nextstate = state;
       en = 1'b0;
       done = 1'b0;
       case (state)
           S0: begin
               if (start) nextstate = S1;
           end
           S1: begin
               en = 1'b1;
               if (count == 6'd63) nextstate = S2;
           end
           S2: begin
               done = 1'b1;
               if (!start) nextstate = S0;
           end
       endcase
   end

   assign index = count;



endmodule


module W
 #(MSG_SCHEDULE_SIZE = 64)
 (input logic [31:0] M, input logic [5:0] count,
  output logic [31:0] W);

   logic [31:0] sigma0_out [16:63];
   logic [31:0] sigma1_out [16:63];

   genvar i;

   generate
      for (i = 0; i < 16; i = i + 1) begin: forloop
         assign W[i] = M[i];
      end

	for (i = 16; i < 64; i = i + 1) begin:
	 sigma1 sig1_inst (.x(W[i-2]), .sig1(sigma1_out[i])); // σ1(W[i-2])
         sigma0 sig0_inst (.x(W[i-15]), .sig0(sigma0_out[i])); // σ0(W[i-15])
         assign W[i] = sigma1_out[i] + W[i-7] + sigma0_out[i] + W[i-16];
      end
   endgenerate

endmodule





module main_comp (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
		  input logic [31:0] K_in, W_in,
		  output logic [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out,
		  output logic [31:0] h_out);

   logic [31:0] 		      t1;
   logic [31:0] 		      t2;
   logic [31:0] 		      temp1;
   logic [31:0] 		      temp2;
   logic [31:0] 		      temp3;
   logic [31:0] 		      temp4;   

   Sigma1 comp1 (e_in, temp1);
   Sigma0 comp2 (a_in, temp2);
   choice comp3 (e_in, f_in, g_in, temp3);
   majority comp4 (a_in, b_in, c_in, temp4);
   
   assign t1 = h_in + temp1 + temp3 + K_in + W_in;
   assign t2 = temp2 + temp4;
   assign h_out = g_in;
   assign g_out = f_in;
   assign f_out = e_in;   
   assign e_out = d_in + t1;
   assign d_out = c_in;
   assign c_out = b_in;
   assign b_out = a_in;
   assign a_out = t1 + t2;

endmodule // main_comp






module intermediate_hash (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
			  input logic [31:0]  h0_in, h1_in, h2_in, h3_in, h4_in, h5_in, h6_in, h7_in, 
			  output logic [31:0] h0_out, h1_out, h2_out, h3_out, h4_out, h5_out, h6_out, h7_out);

   assign h0_out = a_in + h0_in;
   assign h1_out = b_in + h1_in;
   assign h2_out = c_in + h2_in;
   assign h3_out = d_in + h3_in;
   assign h4_out = e_in + h4_in;
   assign h5_out = f_in + h5_in;
   assign h6_out = g_in + h6_in;
   assign h7_out = h_in + h7_in;
   
endmodule






//these are the majority, choice, Sigma1, sigma1, Sigma0, sigma0 functions 




			  
module majority (input logic [31:0] x, y, z, output logic [31:0] maj);

   assign maj = (x & y) ^ (x & z) ^ (y & z);   

endmodule // majority





module choice (input logic [31:0] x, y, z, output logic [31:0] ch);

   assign ch = (x & y) ^ (~x & z);

endmodule // choice






module Sigma0 (input logic [31:0] x, output logic [31:0] Sig0);

   assign Sig0 = {x[1:0],x[31:2]} ^ {x[12:0],x[31:13]} ^ {x[21:0],x[31:22]};

endmodule // Sigma0






module sigma0 (input logic [31:0] x, output logic [31:0] sig0);

   assign sig0 = {x[6:0],x[31:7]} ^ {x[17:0],x[31:18]} ^ (x >> 3);

endmodule // sigma0






module Sigma1 (input logic [31:0] x, output logic [31:0] Sig1);

   assign Sig1 = {x[5:0],x[31:6]} ^ {x[10:0],x[31:11]} ^ {x[24:0],x[31:25]};

endmodule // Sigma1





module sigma1 (input logic [31:0] x, output logic [31:0] sig1);

   assign sig1 = {x[16:0],x[31:17]} ^ {x[18:0],x[31:19]} ^ (x >> 10);

endmodule // sigma1


     
   

