//
// Secure Hash Standard (SHA-256)
//

module top #(parameter MSG_SIZE = 24,
	     parameter PADDED_SIZE = 512)
   (input logic [MSG_SIZE-1:0] message,
    output logic [255:0] hashed);

   logic [PADDED_SIZE-1:0] padded;
   counter instance(clk, rst, start, count);
   sha_padder #(.MSG_SIZE(MSG_SIZE), .PADDED_SIZE(PADDED_SIZE)) padder (.message(message), .padded(padded));
   sha256 #(.PADDED_SIZE(PADDED_SIZE)) main (.padded(padded), .hashed(hashed));
   
endmodule // sha_256

module sha_padder #(parameter MSG_SIZE = 24,
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
   logic [31:0]   W0, W1, W2, W3, W4, W5, W6, W7, W8, W9;
   logic [31:0]   W10, W11, W12, W13, W14, W15, W16, W17, W18, W19;
   logic [31:0]   W20, W21, W22, W23, W24, W25, W26, W27, W28, W29;
   logic [31:0]   W30, W31, W32, W33, W34, W35, W36, W37, W38, W39;
   logic [31:0]   W40, W41, W42, W43, W44, W45, W46, W47, W48, W49;
   logic [31:0]   W50, W51, W52, W53, W54, W55, W56, W57, W58, W59;
   logic [31:0]   W60, W61, W62, W63;
   
   logic [31:0]   a0_out, b0_out, c0_out, d0_out, e0_out, f0_out, g0_out, h0_out;
   logic [31:0]   a1_out, b1_out, c1_out, d1_out, e1_out, f1_out, g1_out, h1_out;
   logic [31:0]   a2_out, b2_out, c2_out, d2_out, e2_out, f2_out, g2_out, h2_out;
   logic [31:0]   a3_out, b3_out, c3_out, d3_out, e3_out, f3_out, g3_out, h3_out;
   logic [31:0]   a4_out, b4_out, c4_out, d4_out, e4_out, f4_out, g4_out, h4_out;
   logic [31:0]   a5_out, b5_out, c5_out, d5_out, e5_out, f5_out, g5_out, h5_out;
   logic [31:0]   a6_out, b6_out, c6_out, d6_out, e6_out, f6_out, g6_out, h6_out;
   logic [31:0]   a7_out, b7_out, c7_out, d7_out, e7_out, f7_out, g7_out, h7_out;
   logic [31:0]   a8_out, b8_out, c8_out, d8_out, e8_out, f8_out, g8_out, h8_out;
   logic [31:0]   a9_out, b9_out, c9_out, d9_out, e9_out, f9_out, g9_out, h9_out;

   logic [31:0]   a10_out, b10_out, c10_out, d10_out, e10_out, f10_out, g10_out, h10_out;
   logic [31:0]   a11_out, b11_out, c11_out, d11_out, e11_out, f11_out, g11_out, h11_out;
   logic [31:0]   a12_out, b12_out, c12_out, d12_out, e12_out, f12_out, g12_out, h12_out;
   logic [31:0]   a13_out, b13_out, c13_out, d13_out, e13_out, f13_out, g13_out, h13_out;
   logic [31:0]   a14_out, b14_out, c14_out, d14_out, e14_out, f14_out, g14_out, h14_out;
   logic [31:0]   a15_out, b15_out, c15_out, d15_out, e15_out, f15_out, g15_out, h15_out;
   logic [31:0]   a16_out, b16_out, c16_out, d16_out, e16_out, f16_out, g16_out, h16_out;
   logic [31:0]   a17_out, b17_out, c17_out, d17_out, e17_out, f17_out, g17_out, h17_out;
   logic [31:0]   a18_out, b18_out, c18_out, d18_out, e18_out, f18_out, g18_out, h18_out;
   logic [31:0]   a19_out, b19_out, c19_out, d19_out, e19_out, f19_out, g19_out, h19_out;   

   logic [31:0]   a20_out, b20_out, c20_out, d20_out, e20_out, f20_out, g20_out, h20_out;
   logic [31:0]   a21_out, b21_out, c21_out, d21_out, e21_out, f21_out, g21_out, h21_out;
   logic [31:0]   a22_out, b22_out, c22_out, d22_out, e22_out, f22_out, g22_out, h22_out;
   logic [31:0]   a23_out, b23_out, c23_out, d23_out, e23_out, f23_out, g23_out, h23_out;
   logic [31:0]   a24_out, b24_out, c24_out, d24_out, e24_out, f24_out, g24_out, h24_out;
   logic [31:0]   a25_out, b25_out, c25_out, d25_out, e25_out, f25_out, g25_out, h25_out;
   logic [31:0]   a26_out, b26_out, c26_out, d26_out, e26_out, f26_out, g26_out, h26_out;
   logic [31:0]   a27_out, b27_out, c27_out, d27_out, e27_out, f27_out, g27_out, h27_out;
   logic [31:0]   a28_out, b28_out, c28_out, d28_out, e28_out, f28_out, g28_out, h28_out;
   logic [31:0]   a29_out, b29_out, c29_out, d29_out, e29_out, f29_out, g29_out, h29_out;

   logic [31:0]   a30_out, b30_out, c30_out, d30_out, e30_out, f30_out, g30_out, h30_out;
   logic [31:0]   a31_out, b31_out, c31_out, d31_out, e31_out, f31_out, g31_out, h31_out;
   logic [31:0]   a32_out, b32_out, c32_out, d32_out, e32_out, f32_out, g32_out, h32_out;
   logic [31:0]   a33_out, b33_out, c33_out, d33_out, e33_out, f33_out, g33_out, h33_out;
   logic [31:0]   a34_out, b34_out, c34_out, d34_out, e34_out, f34_out, g34_out, h34_out;
   logic [31:0]   a35_out, b35_out, c35_out, d35_out, e35_out, f35_out, g35_out, h35_out;
   logic [31:0]   a36_out, b36_out, c36_out, d36_out, e36_out, f36_out, g36_out, h36_out;
   logic [31:0]   a37_out, b37_out, c37_out, d37_out, e37_out, f37_out, g37_out, h37_out;
   logic [31:0]   a38_out, b38_out, c38_out, d38_out, e38_out, f38_out, g38_out, h38_out;
   logic [31:0]   a39_out, b39_out, c39_out, d39_out, e39_out, f39_out, g39_out, h39_out;

   logic [31:0]   a40_out, b40_out, c40_out, d40_out, e40_out, f40_out, g40_out, h40_out;
   logic [31:0]   a41_out, b41_out, c41_out, d41_out, e41_out, f41_out, g41_out, h41_out;
   logic [31:0]   a42_out, b42_out, c42_out, d42_out, e42_out, f42_out, g42_out, h42_out;
   logic [31:0]   a43_out, b43_out, c43_out, d43_out, e43_out, f43_out, g43_out, h43_out;
   logic [31:0]   a44_out, b44_out, c44_out, d44_out, e44_out, f44_out, g44_out, h44_out;
   logic [31:0]   a45_out, b45_out, c45_out, d45_out, e45_out, f45_out, g45_out, h45_out;
   logic [31:0]   a46_out, b46_out, c46_out, d46_out, e46_out, f46_out, g46_out, h46_out;
   logic [31:0]   a47_out, b47_out, c47_out, d47_out, e47_out, f47_out, g47_out, h47_out;
   logic [31:0]   a48_out, b48_out, c48_out, d48_out, e48_out, f48_out, g48_out, h48_out;
   logic [31:0]   a49_out, b49_out, c49_out, d49_out, e49_out, f49_out, g49_out, h49_out;

   logic [31:0]   a50_out, b50_out, c50_out, d50_out, e50_out, f50_out, g50_out, h50_out;
   logic [31:0]   a51_out, b51_out, c51_out, d51_out, e51_out, f51_out, g51_out, h51_out;
   logic [31:0]   a52_out, b52_out, c52_out, d52_out, e52_out, f52_out, g52_out, h52_out;
   logic [31:0]   a53_out, b53_out, c53_out, d53_out, e53_out, f53_out, g53_out, h53_out;
   logic [31:0]   a54_out, b54_out, c54_out, d54_out, e54_out, f54_out, g54_out, h54_out;
   logic [31:0]   a55_out, b55_out, c55_out, d55_out, e55_out, f55_out, g55_out, h55_out;
   logic [31:0]   a56_out, b56_out, c56_out, d56_out, e56_out, f56_out, g56_out, h56_out;
   logic [31:0]   a57_out, b57_out, c57_out, d57_out, e57_out, f57_out, g57_out, h57_out;
   logic [31:0]   a58_out, b58_out, c58_out, d58_out, e58_out, f58_out, g58_out, h58_out;
   logic [31:0]   a59_out, b59_out, c59_out, d59_out, e59_out, f59_out, g59_out, h59_out;

   logic [31:0]   a60_out, b60_out, c60_out, d60_out, e60_out, f60_out, g60_out, h60_out;
   logic [31:0]   a61_out, b61_out, c61_out, d61_out, e61_out, f61_out, g61_out, h61_out;
   logic [31:0]   a62_out, b62_out, c62_out, d62_out, e62_out, f62_out, g62_out, h62_out;
   logic [31:0]   a63_out, b63_out, c63_out, d63_out, e63_out, f63_out, g63_out, h63_out;
   logic [31:0]   h0, h1, h2, h3, h4, h5, h6, h7;   

   prepare p1 (padded[511:480], padded[479:448], padded[447:416],
	       padded[415:384], padded[383:352], padded[351:320],
	       padded[319:288], padded[287:256], padded[255:224],
	       padded[223:192], padded[191:160], padded[159:128],
	       padded[127:96], padded[95:64], padded[63:32],
	       padded[31:0], W0, W1, W2, W3, W4, W5, W6, W7, W8, W9,
	       W10, W11, W12, W13, W14, W15, W16, W17, W18, W19,
	       W20, W21, W22, W23, W24, W25, W26, W27, W28, W29,
	       W30, W31, W32, W33, W34, W35, W36, W37, W38, W39,
	       W40, W41, W42, W43, W44, W45, W46, W47, W48, W49,
	       W50, W51, W52, W53, W54, W55, W56, W57, W58, W59,
	       W60, W61, W62, W63);

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
mux2 #(32) muxA ( a, Aout, s, muxAout);
mux2 #(32) muxB ( b, Bout, s, muxBout);
mux2 #(32) muxC ( c, Cout, s, muxCout);
mux2 #(32) muxD ( d, Dout, s, muxDout);
mux2 #(32) muxE ( e, Eout, s, muxEout);
mux2 #(32) muxF ( f, Fout, s, muxFout);
mux2 #(32) muxG ( g, Gout, s, muxGout);
mux2 #(32) muxH ( h, Hout, s, muxHout);


   main_comp mc01 (muxAout, muxBout, muxCout, muxDout, 
		   muxEout, muxFout, muxGout, muxHout, 
		  k, w,
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




                                 
   intermediate_hash ih1 (a63_out, b63_out, c63_out, d63_out,
			  e63_out, f63_out, g63_out, h63_out,
			  a, b, c, d, e, f, g, h,
			  h0, h1, h2, h3, h4, h5, h6, h7);

   assign hashed = {h0, h1, h2, h3, h4, h5, h6, h7};


endmodule // sha_main

//EDIT
module FSM (clk, reset, a, y);

   input logic  clk;
   input logic  reset;
   input logic 	a;
   
   output logic y;

   typedef enum 	logic [1:0] {S0, S1, S2} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 1'b0;	  
	  if (a) nextstate <= S0;
	  else   nextstate <= S1;
       end
       S1: begin
	  y <= 1'b0;	  	  
	  if (a) nextstate <= S2;
	  else   nextstate <= S1;
       end
       S2: begin
	  y <= 1'b1;	  	  
	  if (a) nextstate <= S2;
	  else   nextstate <= S0;
       end
       default: begin
	  y <= 1'b0;	  	  
	  nextstate <= S0;
       end
     endcase
   
endmodule//FSM


module prepare (input logic [31:0] M0, M1, M2, M3,
		input logic [31:0]  M4, M5, M6, M7,
		input logic [31:0]  M8, M9, M10, M11,
		input logic [31:0]  M12, M13, M14, M15,
		output logic [31:0] W0, W1, W2, W3, W4, 
		output logic [31:0] W5, W6, W7, W8, W9,
		output logic [31:0] W10, W11, W12, W13, W14, 
		output logic [31:0] W15, W16, W17, W18, W19,
		output logic [31:0] W20, W21, W22, W23, W24, 
		output logic [31:0] W25, W26, W27, W28, W29,
		output logic [31:0] W30, W31, W32, W33, W34, 
		output logic [31:0] W35, W36, W37, W38, W39,
		output logic [31:0] W40, W41, W42, W43, W44, 
		output logic [31:0] W45, W46, W47, W48, W49,
		output logic [31:0] W50, W51, W52, W53, W54, 
		output logic [31:0] W55, W56, W57, W58, W59,
		output logic [31:0] W60, W61, W62, W63);

   logic [31:0] 		    W14_sigma1_out, W15_sigma1_out, W16_sigma1_out;
   logic [31:0] 		    W17_sigma1_out, W18_sigma1_out, W19_sigma1_out;
   logic [31:0] 		    W20_sigma1_out, W21_sigma1_out, W22_sigma1_out;
   logic [31:0] 		    W23_sigma1_out, W24_sigma1_out, W25_sigma1_out;
   logic [31:0] 		    W26_sigma1_out, W27_sigma1_out, W28_sigma1_out;
   logic [31:0] 		    W29_sigma1_out;
   logic [31:0] 		    W30_sigma1_out, W31_sigma1_out, W32_sigma1_out;
   logic [31:0] 		    W33_sigma1_out, W34_sigma1_out, W35_sigma1_out;
   logic [31:0] 		    W36_sigma1_out, W37_sigma1_out, W38_sigma1_out;
   logic [31:0] 		    W39_sigma1_out;
   logic [31:0] 		    W40_sigma1_out, W41_sigma1_out, W42_sigma1_out;
   logic [31:0] 		    W43_sigma1_out, W44_sigma1_out, W45_sigma1_out;
   logic [31:0] 		    W46_sigma1_out, W47_sigma1_out, W48_sigma1_out;
   logic [31:0] 		    W49_sigma1_out;
   logic [31:0] 		    W50_sigma1_out, W51_sigma1_out, W52_sigma1_out;
   logic [31:0] 		    W53_sigma1_out, W54_sigma1_out, W55_sigma1_out;
   logic [31:0] 		    W56_sigma1_out, W57_sigma1_out, W58_sigma1_out;
   logic [31:0] 		    W59_sigma1_out;
   logic [31:0] 		    W60_sigma1_out, W61_sigma1_out, W62_sigma1_out;

   logic [31:0] 		    W1_sigma0_out, W2_sigma0_out;
   logic [31:0] 		    W3_sigma0_out, W4_sigma0_out, W5_sigma0_out;
   logic [31:0] 		    W6_sigma0_out, W7_sigma0_out, W8_sigma0_out;
   logic [31:0] 		    W9_sigma0_out;
   logic [31:0] 		    W10_sigma0_out, W11_sigma0_out, W12_sigma0_out;
   logic [31:0] 		    W13_sigma0_out;
   logic [31:0] 		    W14_sigma0_out, W15_sigma0_out, W16_sigma0_out;
   logic [31:0] 		    W17_sigma0_out, W18_sigma0_out, W19_sigma0_out;
   logic [31:0] 		    W20_sigma0_out, W21_sigma0_out, W22_sigma0_out;
   logic [31:0] 		    W23_sigma0_out, W24_sigma0_out, W25_sigma0_out;
   logic [31:0] 		    W26_sigma0_out, W27_sigma0_out, W28_sigma0_out;
   logic [31:0] 		    W29_sigma0_out;
   logic [31:0] 		    W30_sigma0_out, W31_sigma0_out, W32_sigma0_out;
   logic [31:0] 		    W33_sigma0_out, W34_sigma0_out, W35_sigma0_out;
   logic [31:0] 		    W36_sigma0_out, W37_sigma0_out, W38_sigma0_out;
   logic [31:0] 		    W39_sigma0_out;
   logic [31:0] 		    W40_sigma0_out, W41_sigma0_out, W42_sigma0_out;
   logic [31:0] 		    W43_sigma0_out, W44_sigma0_out, W45_sigma0_out;
   logic [31:0] 		    W46_sigma0_out, W47_sigma0_out, W48_sigma0_out;
   logic [31:0] 		    W49_sigma0_out;

   assign W0 = M0;
   assign W1 = M1;
   assign W2 = M2;
   assign W3 = M3;
   assign W4 = M4;
   assign W5 = M5;
   assign W6 = M6;
   assign W7 = M7;
   assign W8 = M8;
   assign W9 = M9;
   assign W10 = M10;
   assign W11 = M11;
   assign W12 = M12;
   assign W13 = M13;
   assign W14 = M14;
   assign W15 = M15;
   
   sigma1 sig1_1 (W14, W14_sigma1_out);   
   sigma1 sig1_2 (W15, W15_sigma1_out);
   sigma1 sig1_3 (W16, W16_sigma1_out);
   sigma1 sig1_4 (W17, W17_sigma1_out);
   sigma1 sig1_5 (W18, W18_sigma1_out);
   sigma1 sig1_6 (W19, W19_sigma1_out);
   sigma1 sig1_7 (W20, W20_sigma1_out);
   sigma1 sig1_8 (W21, W21_sigma1_out);
   sigma1 sig1_9 (W22, W22_sigma1_out);
   sigma1 sig1_10 (W23, W23_sigma1_out);
   sigma1 sig1_11 (W24, W24_sigma1_out);
   sigma1 sig1_12 (W25, W25_sigma1_out);
   sigma1 sig1_13 (W26, W26_sigma1_out);
   sigma1 sig1_14 (W27, W27_sigma1_out);
   sigma1 sig1_15 (W28, W28_sigma1_out);
   sigma1 sig1_16 (W29, W29_sigma1_out);
   sigma1 sig1_17 (W30, W30_sigma1_out);
   sigma1 sig1_18 (W31, W31_sigma1_out);
   sigma1 sig1_19 (W32, W32_sigma1_out);
   sigma1 sig1_20 (W33, W33_sigma1_out);
   sigma1 sig1_21 (W34, W34_sigma1_out);
   sigma1 sig1_22 (W35, W35_sigma1_out);
   sigma1 sig1_23 (W36, W36_sigma1_out);
   sigma1 sig1_24 (W37, W37_sigma1_out);
   sigma1 sig1_25 (W38, W38_sigma1_out);   
   sigma1 sig1_26 (W39, W39_sigma1_out);
   sigma1 sig1_27 (W40, W40_sigma1_out);
   sigma1 sig1_28 (W41, W41_sigma1_out);
   sigma1 sig1_29 (W42, W42_sigma1_out);
   sigma1 sig1_30 (W43, W43_sigma1_out);
   sigma1 sig1_31 (W44, W44_sigma1_out);
   sigma1 sig1_32 (W45, W45_sigma1_out);
   sigma1 sig1_33 (W46, W46_sigma1_out);
   sigma1 sig1_34 (W47, W47_sigma1_out);
   sigma1 sig1_35 (W48, W48_sigma1_out);
   sigma1 sig1_36 (W49, W49_sigma1_out);
   sigma1 sig1_37 (W50, W50_sigma1_out);
   sigma1 sig1_38 (W51, W51_sigma1_out);
   sigma1 sig1_39 (W52, W52_sigma1_out);
   sigma1 sig1_40 (W53, W53_sigma1_out);
   sigma1 sig1_41 (W54, W54_sigma1_out);
   sigma1 sig1_42 (W55, W55_sigma1_out);
   sigma1 sig1_43 (W56, W56_sigma1_out);
   sigma1 sig1_44 (W57, W57_sigma1_out);
   sigma1 sig1_45 (W58, W58_sigma1_out);
   sigma1 sig1_46 (W59, W59_sigma1_out);
   sigma1 sig1_47 (W60, W60_sigma1_out);
   sigma1 sig1_48 (W61, W61_sigma1_out);

   sigma0 sig0_1 (W1, W1_sigma0_out);
   sigma0 sig0_2 (W2, W2_sigma0_out);
   sigma0 sig0_3 (W3, W3_sigma0_out);
   sigma0 sig0_4 (W4, W4_sigma0_out);
   sigma0 sig0_5 (W5, W5_sigma0_out);
   sigma0 sig0_6 (W6, W6_sigma0_out);
   sigma0 sig0_7 (W7, W7_sigma0_out);
   sigma0 sig0_8 (W8, W8_sigma0_out);
   sigma0 sig0_9 (W9, W9_sigma0_out);
   sigma0 sig0_10 (W10, W10_sigma0_out);
   sigma0 sig0_11 (W11, W11_sigma0_out);
   sigma0 sig0_12 (W12, W12_sigma0_out);
   sigma0 sig0_13 (W13, W13_sigma0_out);   
   sigma0 sig0_14 (W14, W14_sigma0_out);   
   sigma0 sig0_15 (W15, W15_sigma0_out);
   sigma0 sig0_16 (W16, W16_sigma0_out);
   sigma0 sig0_17 (W17, W17_sigma0_out);
   sigma0 sig0_18 (W18, W18_sigma0_out);
   sigma0 sig0_19 (W19, W19_sigma0_out);
   sigma0 sig0_20 (W20, W20_sigma0_out);
   sigma0 sig0_21 (W21, W21_sigma0_out);
   sigma0 sig0_22 (W22, W22_sigma0_out);
   sigma0 sig0_23 (W23, W23_sigma0_out);
   sigma0 sig0_24 (W24, W24_sigma0_out);
   sigma0 sig0_25 (W25, W25_sigma0_out);
   sigma0 sig0_26 (W26, W26_sigma0_out);
   sigma0 sig0_27 (W27, W27_sigma0_out);
   sigma0 sig0_28 (W28, W28_sigma0_out);
   sigma0 sig0_29 (W29, W29_sigma0_out);
   sigma0 sig0_30 (W30, W30_sigma0_out);
   sigma0 sig0_31 (W31, W31_sigma0_out);
   sigma0 sig0_32 (W32, W32_sigma0_out);
   sigma0 sig0_33 (W33, W33_sigma0_out);
   sigma0 sig0_34 (W34, W34_sigma0_out);
   sigma0 sig0_35 (W35, W35_sigma0_out);
   sigma0 sig0_36 (W36, W36_sigma0_out);
   sigma0 sig0_37 (W37, W37_sigma0_out);
   sigma0 sig0_38 (W38, W38_sigma0_out);   
   sigma0 sig0_39 (W39, W39_sigma0_out);
   sigma0 sig0_40 (W40, W40_sigma0_out);
   sigma0 sig0_41 (W41, W41_sigma0_out);
   sigma0 sig0_42 (W42, W42_sigma0_out);
   sigma0 sig0_43 (W43, W43_sigma0_out);
   sigma0 sig0_44 (W44, W44_sigma0_out);
   sigma0 sig0_45 (W45, W45_sigma0_out);
   sigma0 sig0_46 (W46, W46_sigma0_out);
   sigma0 sig0_47 (W47, W47_sigma0_out);
   sigma0 sig0_48 (W48, W48_sigma0_out);
   
   assign W16 = W14_sigma1_out + W9 + W1_sigma0_out + W0;
   assign W17 = W15_sigma1_out + W10 + W2_sigma0_out + W1;
   assign W18 = W16_sigma1_out + W11 + W3_sigma0_out + W2;
   assign W19 = W17_sigma1_out + W12 + W4_sigma0_out + W3;
   assign W20 = W18_sigma1_out + W13 + W5_sigma0_out + W4;
   assign W21 = W19_sigma1_out + W14 + W6_sigma0_out + W5;
   assign W22 = W20_sigma1_out + W15 + W7_sigma0_out + W6;
   assign W23 = W21_sigma1_out + W16 + W8_sigma0_out + W7;
   assign W24 = W22_sigma1_out + W17 + W9_sigma0_out + W8;
   assign W25 = W23_sigma1_out + W18 + W10_sigma0_out + W9;
   assign W26 = W24_sigma1_out + W19 + W11_sigma0_out + W10;
   assign W27 = W25_sigma1_out + W20 + W12_sigma0_out + W11;
   assign W28 = W26_sigma1_out + W21 + W13_sigma0_out + W12;
   assign W29 = W27_sigma1_out + W22 + W14_sigma0_out + W13;
   assign W30 = W28_sigma1_out + W23 + W15_sigma0_out + W14;
   assign W31 = W29_sigma1_out + W24 + W16_sigma0_out + W15;
   assign W32 = W30_sigma1_out + W25 + W17_sigma0_out + W16;
   assign W33 = W31_sigma1_out + W26 + W18_sigma0_out + W17;
   assign W34 = W32_sigma1_out + W27 + W19_sigma0_out + W18;
   assign W35 = W33_sigma1_out + W28 + W20_sigma0_out + W19;
   assign W36 = W34_sigma1_out + W29 + W21_sigma0_out + W20;
   assign W37 = W35_sigma1_out + W30 + W22_sigma0_out + W21;
   assign W38 = W36_sigma1_out + W31 + W23_sigma0_out + W22;
   assign W39 = W37_sigma1_out + W32 + W24_sigma0_out + W23;
   assign W40 = W38_sigma1_out + W33 + W25_sigma0_out + W24;
   assign W41 = W39_sigma1_out + W34 + W26_sigma0_out + W25;
   assign W42 = W40_sigma1_out + W35 + W27_sigma0_out + W26;
   assign W43 = W41_sigma1_out + W36 + W28_sigma0_out + W27;
   assign W44 = W42_sigma1_out + W37 + W29_sigma0_out + W28;
   assign W45 = W43_sigma1_out + W38 + W30_sigma0_out + W29;
   assign W46 = W44_sigma1_out + W39 + W31_sigma0_out + W30;
   assign W47 = W45_sigma1_out + W40 + W32_sigma0_out + W31;
   assign W48 = W46_sigma1_out + W41 + W33_sigma0_out + W32;
   assign W49 = W47_sigma1_out + W42 + W34_sigma0_out + W33;
   assign W50 = W48_sigma1_out + W43 + W35_sigma0_out + W34;
   assign W51 = W49_sigma1_out + W44 + W36_sigma0_out + W35;
   assign W52 = W50_sigma1_out + W45 + W37_sigma0_out + W36;
   assign W53 = W51_sigma1_out + W46 + W38_sigma0_out + W37;
   assign W54 = W52_sigma1_out + W47 + W39_sigma0_out + W38;
   assign W55 = W53_sigma1_out + W48 + W40_sigma0_out + W39;
   assign W56 = W54_sigma1_out + W49 + W41_sigma0_out + W40;
   assign W57 = W55_sigma1_out + W50 + W42_sigma0_out + W41;
   assign W58 = W56_sigma1_out + W51 + W43_sigma0_out + W42;
   assign W59 = W57_sigma1_out + W52 + W44_sigma0_out + W43;
   assign W60 = W58_sigma1_out + W53 + W45_sigma0_out + W44;
   assign W61 = W59_sigma1_out + W54 + W46_sigma0_out + W45;
   assign W62 = W60_sigma1_out + W55 + W47_sigma0_out + W46;
   assign W63 = W61_sigma1_out + W56 + W48_sigma0_out + W47;

endmodule // prepare


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

//module decrementK(input logic [5:0] count, input logic [2047:0] K, output logic [31:0] Kout);
//login [10:0] IN;
//logic [10:0] END;
//assign IN = 2047 - 32*count;
//assign END = IN-31;


//if counter <= 6'b111110
   //K-=32;
   //get value
//else
   //get value 
   //end loop

   //(K>>32) 

 
//assign Kout = (K>>2016 - 32*count) ;




//endmodule //decrementK

     
   

