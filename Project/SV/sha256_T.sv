module top #(parameter MSG_SIZE = 120,
	     parameter PADDED_SIZE = 512)
   (input logic [MSG_SIZE-1:0] message, input logic clk, reset, start, 
    output logic [255:0] hashed);

   logic [PADDED_SIZE-1:0] padded;

   

   sha_padder #(.MSG_SIZE(MSG_SIZE), .PADDED_SIZE(PADDED_SIZE)) padder (.message(message), .padded(padded));


   sha256 #(.PADDED_SIZE(PADDED_SIZE)) main (.padded(padded),  .clk(clk), .reset(reset), .start(start),.hashed(hashed));



// Instantiate main_comp with new signals


   
endmodule // sha_256




module sha_padder #(parameter MSG_SIZE = 120,	     
		    parameter PADDED_SIZE = 512) 
   (input logic [MSG_SIZE-1:0] message, 
    output logic [PADDED_SIZE-1:0] padded);

localparam zero_width = PADDED_SIZE - 64 - MSG_SIZE - 1;
localparam back_0_width = 64 - $bits(MSG_SIZE);
	assign padded = {message, 1'b1, {zero_width{1'b0}}, {back_0_width{1'b0}}, MSG_SIZE};


endmodule // sha_padder




module sha256 #(parameter PADDED_SIZE = 512)
   (input logic [PADDED_SIZE-1:0] padded, input logic clk, reset, start,
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

              // logic [5:0] count;

    //counter64 inst(clk, rst, start, count);

   logic en, en2, done;
   logic [5:0]  index;
   logic [31:0]   a, b, c, d, e, f, g, h;
   logic [31:0]   a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out;
   logic [31:0]   Aout, Bout, Cout, Dout, Eout, Fout, Gout, Hout;
   logic [31:0]   flopA, flopB, flopC, flopD, flopE, flopF, flopG, flopH;
  

   logic [31:0]   muxAout, muxBout, muxCout, muxDout, muxEout, muxFout, muxGout, muxHout;

   logic [31:0] h0, h1, h2, h3, h4, h5, h6, h7;
   logic [31:0] h0_q, h1_q, h2_q, h3_q, h4_q, h5_q, h6_q, h7_q;
   logic [31:0] K_selected, W_selected;


   logic [31:0] W0, W1, W2, W3, W4, W5, W6, W7, W8, W9, W10, W11, W12, W13, W14, W15, W16, W17, W18, W19, W20, W21, W22, W23, W24, W25;
   logic [31:0] W26, W27, W28, W29, W30, W31, W32, W33, W34, W35, W36, W37, W38, W39, W40, W41, W42, W43, W44, W45, W46, W47, W48;
   logic [31:0] W49, W50, W51, W52, W53, W54, W55, W56, W57, W58, W59, W60, W61, W62, W63;


    prepare p1 (padded[511:480], padded[479:448], padded[447:416],
	       padded[415:384], padded[383:352], padded[351:320],
	       padded[319:288], padded[287:256], padded[255:224],
	       padded[223:192], padded[191:160], padded[159:128],
	       padded[127:96], padded[95:64], padded[63:32],
	       padded[31:0],  W0, W1, W2, W3, W4, W5, W6, W7, W8, W9,
               W10, W11, W12, W13, W14, W15, W16, W17, W18, W19,
               W20, W21, W22, W23, W24, W25, W26, W27, W28, W29,
               W30, W31, W32, W33, W34, W35, W36, W37, W38, W39,
               W40, W41, W42, W43, W44, W45, W46, W47, W48, W49,
               W50, W51, W52, W53, W54, W55, W56, W57, W58, W59,
               W60, W61, W62, W63);



   //wire [511:0] M = {padded[511:480], padded[479:448], padded[447:416],
              // padded[415:384], padded[383:352], padded[351:320],
             //  padded[319:288], padded[287:256], padded[255:224],
             //  padded[223:192], padded[191:160], padded[159:128],
             //  padded[127:96], padded[95:64], padded[63:32],
             //  padded[31:0]};
	
	//


//check
//Muxes
   //these are the muxes for initially choosing between a and a_out (round 0 or round 1-63)
   //muxes choose between a and a_out, if en=0 (rounds havent started, a is chosen)

mux2 #(32) muxA ( a, flopA, index, muxAout);
mux2 #(32) muxB ( b, flopB, index, muxBout);
mux2 #(32) muxC ( c, flopC, index, muxCout);
mux2 #(32) muxD ( d, flopD, index, muxDout);
mux2 #(32) muxE ( e, flopE, index, muxEout);
mux2 #(32) muxF ( f, flopF, index, muxFout);
mux2 #(32) muxG ( g, flopG, index, muxGout);
mux2 #(32) muxH ( h, flopH, index, muxHout);

//needs each K value as an input, counter as s, and output y

mux64 #(32) muxW (
    W0, W1, W2, W3, W4, W5, W6, W7, W8, W9,
               W10, W11, W12, W13, W14, W15, W16, W17, W18, W19,
               W20, W21, W22, W23, W24, W25, W26, W27, W28, W29,
               W30, W31, W32, W33, W34, W35, W36, W37, W38, W39,
               W40, W41, W42, W43, W44, W45, W46, W47, W48, W49,
               W50, W51, W52, W53, W54, W55, W56, W57, W58, W59,
               W60, W61, W62, W63,    
    index,  
    W_selected 
);

mux64 #(32) muxK (
    K[2047:2016], K[2015:1984], K[1983:1952], K[1951:1920], K[1919:1888], K[1887:1856],
    K[1855:1824], K[1823:1792], K[1791:1760], K[1759:1728], K[1727:1696], K[1695:1664],
    K[1663:1632], K[1631:1600], K[1599:1568], K[1567:1536], K[1535:1504], K[1503:1472],
    K[1471:1440], K[1439:1408], K[1407:1376], K[1375:1344], K[1343:1312], K[1311:1280],
    K[1279:1248], K[1247:1216], K[1215:1184], K[1183:1152], K[1151:1120], K[1119:1088],
    K[1087:1056], K[1055:1024], K[1023:992],  K[991:960],  K[959:928],  K[927:896],
    K[895:864],  K[863:832],  K[831:800],    K[799:768],  K[767:736],  K[735:704],
    K[703:672],  K[671:640],  K[639:608],    K[607:576],  K[575:544],  K[543:512],
    K[511:480],  K[479:448],  K[447:416],    K[415:384],  K[383:352],  K[351:320],
    K[319:288],  K[287:256],  K[255:224],    K[223:192],  K[191:160],  K[159:128],
    K[127:96],   K[95:64],    K[63:32],      K[31:0],  
    index,  
    K_selected 
);



//what are these for ???

    flopenr #(32) regA (clk, reset, en, a_out,  flopA);
    flopenr #(32) regB (clk, reset, en, b_out,  flopB );
    flopenr #(32) regC (clk, reset, en, c_out,  flopC );
    flopenr #(32) regD (clk, reset, en, d_out,  flopD );
    flopenr #(32) regE (clk, reset, en, e_out,  flopE );
    flopenr #(32) regF (clk, reset, en, f_out,  flopF);
    flopenr #(32) regG (clk, reset, en, g_out,  flopG );
    flopenr #(32) regH (clk, reset, en, h_out,  flopH);


FSM dut01(~clk,reset,start,index,  en,  done , en2, en0);
   


 //W64 W_gen(clk,  reset,  en,  M , index,  W_selected);

   // Initialize a through h
   assign a = H[255:224];
   assign b = H[223:192];
   assign c = H[191:160];
   assign d = H[159:128];
   assign e = H[127:96];
   assign f = H[95:64];
   assign g = H[63:32];
   assign h = H[31:0];

   //check
	
   main_comp mc01 (muxAout, muxBout, muxCout, muxDout, muxEout, muxFout, muxGout, muxHout, 
                   K_selected, W_selected,
                   a_out, b_out, c_out, d_out, 
                   e_out, f_out, g_out, h_out);


   intermediate_hash ih1 (a_out, b_out, c_out, d_out,
			  e_out, f_out, g_out, h_out,
			  a, b, c, d, e, f, g, h,
			  h0, h1, h2, h3, h4, h5, h6, h7);

    flopenr #(32) regH0 (clk, reset, en2, h0,  h0_q);
    flopenr #(32) regH1 (clk, reset, en2, h1,  h1_q );
    flopenr #(32) regH2 (clk, reset, en2, h2,  h2_q );
    flopenr #(32) regH3 (clk, reset, en2, h3,  h3_q );
    flopenr #(32) regH4 (clk, reset, en2, h4,  h4_q );
    flopenr #(32) regH5 (clk, reset, en2, h5,  h5_q);
    flopenr #(32) regH6 (clk, reset, en2, h6,  h6_q );
    flopenr #(32) regH7 (clk, reset, en2, h7,  h7_q);

	assign hashed ={h0_q, h1_q, h2_q, h3_q, h4_q, h5_q, h6_q, h7_q};

endmodule // sha_main




module main_comp (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
		  input logic [31:0] K_in, W_in,
		  output logic [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out,
		  output logic [31:0] h_out);


logic [31:0] ch, maj, Sig0, Sig1;	
choice ch1 ( e_in, f_in, g_in, ch);
majority m1(a_in, b_in, c_in, maj);
Sigma0 S0(a_in, Sig0);	
Sigma1 S1(e_in, Sig1);
logic [31:0] t1, t2;
logic [31:0] T1, T2;
assign t1=(h_in+Sig1+ch+K_in+W_in)  ;
assign t2=(Sig0+maj) ;
assign T1 = t1;
assign T2 = t2;


assign h_out=g_in;
assign g_out=f_in;
assign f_out=e_in;
assign e_out=(d_in+T1) ;

assign d_out=c_in;
assign c_out=b_in;
assign b_out=a_in;
assign a_out = (T1+T2) ;


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

assign Sig0 = ({x[1:0], x[31:2]})^({x[12:0], x[31:13]})^({x[21:0], x[31:22]});

	//ror^2 ^ ror^13 ^ ror^22


endmodule // Sigma0



module Sigma1 (input logic [31:0] x, output logic [31:0] Sig1);

   // See Section 2.3.3, Number 4
   assign Sig1 = ({x[5:0], x[31:6]})^({x[10:0], x[31:11]})^({x[24:0], x[31:25]});

	//ror^6 ^ ror^11 ^ ror^25

endmodule // Sigma1




/*module W64 (
    input  logic clk,                   // Clock signal
    input  logic reset,                   // Reset signal (active high)
  input  logic en,                 // Start signal
    input  logic [511:0] M,             // Padded message input
    input  logic [5:0] index,           // Current round index (0 to 63)
    output logic [31:0] W_selected      // Output W value for current round
);

    // Internal registers for W values
    logic [31:0] W_reg [0:63];          // Array to store 64 W values
    logic [31:0] sigma0_out, sigma1_out;

    // **Sigma0 and Sigma1 Calculation Modules**
    // These compute the required transformations for rounds > 15
    sigma0 sig0_inst (
        .x(W_reg[index - 15]), 
        .sig0(sigma0_out)
    );

    sigma1 sig1_inst (
        .x(W_reg[index - 2]), 
        .sig1(sigma1_out)
    );

    // **W_reg Update Logic**
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset W registers to 0
            for (int i = 0; i < 64; i++) begin
                W_reg[i] <= 32'b0;
            end
        end else if (en) begin
            // Initialize first 16 W values directly from M (message words)
            if (index < 16) begin
                W_reg[index] <= M[32 * (16 - index) +: 32]; // Extract 32-bit words
            end else begin
                // Compute W values for rounds 16 to 63
                W_reg[index] <= sigma1_out + W_reg[index - 7] + sigma0_out + W_reg[index - 16];
            end
        end
    end

    // **W_selected Output Logic**
    always_comb begin
        if (index < 16) begin
            W_selected = M[32 * (16 - index) +: 32]; // Extract 32-bit words from M
        end else begin
            W_selected = W_reg[index]; // Use computed W value
        end
    end

endmodule*/




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

	logic [31:0] 		W14_sigma1_out, W15_sigma1_out, W16_sigma1_out, W17_sigma1_out, W18_sigma1_out, W19_sigma1_out, W20_sigma1_out, W21_sigma1_out;
	logic [31:0] 		W22_sigma1_out, W23_sigma1_out, W24_sigma1_out, W25_sigma1_out, W26_sigma1_out, W27_sigma1_out, W28_sigma1_out, W29_sigma1_out;
	logic [31:0] 		W30_sigma1_out, W31_sigma1_out, W32_sigma1_out, W33_sigma1_out, W34_sigma1_out, W35_sigma1_out, W36_sigma1_out, W37_sigma1_out;
	logic [31:0] 		W38_sigma1_out, W39_sigma1_out, W40_sigma1_out, W41_sigma1_out, W42_sigma1_out, W43_sigma1_out, W44_sigma1_out, W45_sigma1_out;
	logic [31:0] 		W46_sigma1_out, W47_sigma1_out, W48_sigma1_out, W49_sigma1_out, W50_sigma1_out, W51_sigma1_out, W52_sigma1_out, W53_sigma1_out;
	logic [31:0] 		W54_sigma1_out, W55_sigma1_out, W56_sigma1_out, W57_sigma1_out, W58_sigma1_out, W59_sigma1_out, W60_sigma1_out, W61_sigma1_out;
   //logic [31:0]      W62_sigma1_out, W63_sigma1_out;

	logic [31:0] 		W1_sigma0_out, W2_sigma0_out, W3_sigma0_out, W4_sigma0_out, W5_sigma0_out, W6_sigma0_out, W7_sigma0_out, W8_sigma0_out; 
	logic [31:0] 		W9_sigma0_out, W10_sigma0_out, W11_sigma0_out, W12_sigma0_out, W13_sigma0_out, W14_sigma0_out, W15_sigma0_out, W16_sigma0_out; 
	logic [31:0]		W17_sigma0_out, W18_sigma0_out, W19_sigma0_out, W20_sigma0_out, W21_sigma0_out, W22_sigma0_out, W23_sigma0_out, W24_sigma0_out;
	logic [31:0]		W25_sigma0_out, W26_sigma0_out, W27_sigma0_out, W28_sigma0_out, W29_sigma0_out, W30_sigma0_out, W31_sigma0_out, W32_sigma0_out;
	logic [31:0]		W33_sigma0_out, W34_sigma0_out, W35_sigma0_out, W36_sigma0_out, W37_sigma0_out, W38_sigma0_out, W39_sigma0_out, W40_sigma0_out;
	logic [31:0]		W41_sigma0_out, W42_sigma0_out, W43_sigma0_out, W44_sigma0_out, W45_sigma0_out, W46_sigma0_out, W47_sigma0_out, W48_sigma0_out;
	
	
	//define all sigma0 and sigma 1 values
	
   // Equation for W_i (top of page 7)
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

   // sigma 1 (see bottom of page 6)
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


   //all the way to 61

   // fill in other sigma1 blocks

   // sigma 0 (see bottom of page 6)
   sigma0 sig0_1 (W1, W1_sigma0_out);
   //all the way to 47
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
   // fill in other sigma0 blocks

   // Equation for W_i (top of page 7)3
   assign W16 = W14_sigma1_out + W9 + W1_sigma0_out + W0;
   assign W17 = W15_sigma1_out + W10 + W2_sigma0_out + W1;

   // fill in other W18 through W63   
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





module sigma0 (input logic [31:0] x, output logic [31:0] sig0);



      assign sig0 = ({x[6:0], x[31:7]})^({x[17:0], x[31:18]})^(x>>3);

	//ror^7 ^ ror^18 ^ (x>>3)
   

endmodule // sigma0




module sigma1 (input logic [31:0] x, output logic [31:0] sig1);

   
assign sig1 = ({x[16:0], x[31:17]})^({x[18:0], x[31:19]})^(x>>10);

	//ror^17 ^ ror^19 ^ (x>>10)

endmodule // sigma1


//control logic

module FSM (
    input logic clk,
    input logic reset,
    input logic start,
    output logic [5:0] index,
    output logic en, done, en2, en0);

   typedef enum logic [1:0] {S0, S1, S2} statetype;
   statetype state, nextstate;

   //logic [5:0] count;

   // State register
   always_ff @(posedge clk or posedge reset) begin
       if (reset) 
           state <= S0;
       else 
           state <= nextstate;
   end

   // Counter for round index
   always_ff @(posedge clk or posedge reset) begin
       if (reset) 
           index <= 6'd0;
       else if (state == S1)
           index <= index + 6'd1;
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
               en0 = 1'b1;
               en2 = 1'b0;
               if (index == 6'd63) nextstate = S2;
               else nextstate = S1;
           end
           S2: begin
               done = 1'b1;
               en2 = 1'b1;
               en =1'b0;
               en0=1'b0;
               if (!start) nextstate = S0;
           end
       endcase
   end

  // assign index = count;

   // Debugging output
  always_ff @(posedge clk) 
   begin

       $display("Time: %0t | State: %0d | index: %0d | Start: %b | Reset: %b | En: %b | Done: %b",
                $time, state, index, start, reset, en, done);

   end

endmodule
