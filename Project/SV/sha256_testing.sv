//
// Secure Hash Standard (SHA-256) - Complete Top Module
//

module top #(
    parameter MSG_SIZE = 120,       // Message size in bits
    parameter PADDED_SIZE = 512,   // Total padded message size
    parameter MSG_SCHEDULE_SIZE = 64 // Message schedule size
) (
    input  logic [MSG_SIZE-1:0] message, // Input message
    input  logic clk,                   // Clock signal
    input  logic reset,                 // Reset signal
    input  logic start,                 // Start signal for FSM
    output logic [255:0] hashed,        // Output hashed value
    output logic done                   // Completion signal from FSM
);

    // Internal signals
    logic [PADDED_SIZE-1:0] padded;       
    logic [31:0] W; 
    wire [31:0] M; 
    logic [31:0] sigma1_out;
    logic [31:0] sigma0_out;
                  
    logic [31:0] a, b, c, d, e, f, g, h; 
    logic [31:0] Aout, Bout, Cout, Dout, Eout, Fout, Gout, Hout; 
    logic [31:0] a0_out, b0_out, c0_out, d0_out, e0_out, f0_out, g0_out, h0_out;
    logic [5:0] count;                    
    logic en;                            
    logic [31:0] K_select;   
   // logic [31:0] muxAout, muxBout, muxCout, muxDout, muxEout, muxFout, muxGout, muxHout;             

    // Initial hash values (H)
    logic [255:0] H_init = {32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a,
                            32'h510e527f, 32'h9b05688c, 32'h1f83d9ab, 32'h5be0cd19};

    // Constants (K)
    logic [2047:0] K = {32'h428a2f98, 32'h71374491, 32'hb5c0fbcf, 32'he9b5dba5,
                        32'h3956c25b, 32'h59f111f1, 32'h923f82a4, 32'hab1c5ed5,
                        32'hd807aa98, 32'h12835b01, 32'h243185be, 32'h550c7dc3,
                        32'h72be5d74, 32'h80deb1fe, 32'h9bdc06a7, 32'hc19bf174,
                        32'he49b69c1, 32'hefbe4786, 32'h0fc19dc6, 32'h240ca1cc,
                        32'h2de92c6f, 32'h4a7484aa, 32'h5cb0a9dc, 32'h76f988da,
                        32'h983e5152, 32'ha831c66d, 32'hb00327c8, 32'hbf597fc7,
                        32'hc6e00bf3, 32'hd5a79147, 32'h06ca6351, 32'h14292967,
                        32'h27b70a85, 32'h2e1b2138, 32'h4d2c6dfc, 32'h53380d13,
                        32'h650a7354, 32'h766a0abb, 32'h81c2c92e, 32'h92722c85,
                        32'ha2bfe8a1, 32'ha81a664b, 32'hc24b8b70, 32'hc76c51a3,
                        32'hd192e819, 32'hd6990624, 32'hf40e3585, 32'h106aa070,
                        32'h19a4c116, 32'h1e376c08, 32'h2748774c, 32'h34b0bcb5,
                        32'h391c0cb3, 32'h4ed8aa4a, 32'h5b9cca4f, 32'h682e6ff3,
                        32'h748f82ee, 32'h78a5636f, 32'h84c87814, 32'h8cc70208,
                        32'h90befffa, 32'ha4506ceb, 32'hbef9a3f7, 32'hc67178f2};

    // Instantiate the SHA Padder module
    sha_padder #(
        .MSG_SIZE(MSG_SIZE), 
        .PADDED_SIZE(PADDED_SIZE)
    ) padder_inst (
        .message(message), 
        .padded(padded)
    );



    // Instantiate the Message Schedule (W) module
   // W64 #(32) w_inst (
     //   .M(M), 
    //.count(count),       
    //.W(W),           
    //.sigma0_out(sigma0_out), 
    //.sigma1_out(sigma1_out)
   // );

    // Instantiate the FSM for control
    FSM fsm_inst (
        .clk(clk),
        .reset(reset),
        .start(start),
        .index(count),
        .en(en),
        .done(done)
    );

    // Instantiate MUXes for inputs to the main computation
   // mux2 #(32) muxA (a, Aout, en, muxAout);
   // mux2 #(32) muxB (b, Bout, en, muxAout);
   // mux2 #(32) muxC (c, Cout, en, muxCout);
   // mux2 #(32) muxD (d, Dout, en, muxDout);
   // mux2 #(32) muxE (e, Eout, en, muxEout);
  //  mux2 #(32) muxF (f, Fout, en, muxFout);
  //  mux2 #(32) muxG (g, Gout, en, muxGout);
  //  mux2 #(32) muxH (h, Hout, en, muxHout);

    // MUX for selecting K constant
   mux64 #(32) muxK (
    .d0(K[2047:2016]), .d1(K[2015:1984]), .d2(K[1983:1952]), .d3(K[1951:1920]),
    .d4(K[1919:1888]), .d5(K[1887:1856]), .d6(K[1855:1824]), .d7(K[1823:1792]),
    .d8(K[1791:1760]), .d9(K[1759:1728]), .d10(K[1727:1696]), .d11(K[1695:1664]),
    .d12(K[1663:1632]), .d13(K[1631:1600]), .d14(K[1599:1568]), .d15(K[1567:1536]),
    .d16(K[1535:1504]), .d17(K[1503:1472]), .d18(K[1471:1440]), .d19(K[1439:1408]),
    .d20(K[1407:1376]), .d21(K[1375:1344]), .d22(K[1343:1312]), .d23(K[1311:1280]),
    .d24(K[1279:1248]), .d25(K[1247:1216]), .d26(K[1215:1184]), .d27(K[1183:1152]),
    .d28(K[1151:1120]), .d29(K[1119:1088]), .d30(K[1087:1056]), .d31(K[1055:1024]),
    .d32(K[1023:992]), .d33(K[991:960]), .d34(K[959:928]), .d35(K[927:896]),
    .d36(K[895:864]), .d37(K[863:832]), .d38(K[831:800]), .d39(K[799:768]),
    .d40(K[767:736]), .d41(K[735:704]), .d42(K[703:672]), .d43(K[671:640]),
    .d44(K[639:608]), .d45(K[607:576]), .d46(K[575:544]), .d47(K[543:512]),
    .d48(K[511:480]), .d49(K[479:448]), .d50(K[447:416]), .d51(K[415:384]),
    .d52(K[383:352]), .d53(K[351:320]), .d54(K[319:288]), .d55(K[287:256]),
    .d56(K[255:224]), .d57(K[223:192]), .d58(K[191:160]), .d59(K[159:128]),
    .d60(K[127:96]), .d61(K[95:64]), .d62(K[63:32]), .d63(K[31:0]), 
    .s(count),   // Select input
    .y(K_select) // Output
);

    // Registers for intermediate values
    flopenr #(32) regA (clk, reset, count, a0_out, Aout);
    flopenr #(32) regB (clk, reset, count, b0_out, Bout);
    flopenr #(32) regC (clk, reset, count, c0_out, Cout);
    flopenr #(32) regD (clk, reset, count, d0_out, Dout);
    flopenr #(32) regE (clk, reset, count, e0_out, Eout);
    flopenr #(32) regF (clk, reset, count, f0_out, Fout);
    flopenr #(32) regG (clk, reset, count, g0_out, Gout);
    flopenr #(32) regH (clk, reset, count, h0_out, Hout);

    // Main computation module
   // main_comp mc_inst (
     //   .a_in(a), .b_in(b), .c_in(c), .d_in(d),
      //  .e_in(e), .f_in(f), .g_in(g), .h_in(h),
      //  .K_in(K_select), .W_in(W[count]),
      //  .a_out(a0_out), .b_out(b0_out), .c_out(c0_out), .d_out(d0_out),
      //  .e_out(e0_out), .f_out(f0_out), .g_out(g0_out), .h_out(h0_out)
   // );

    // Intermediate hash computation module
intermediate_hash ih_inst (
    .a_in(Aout), .b_in(Bout), .c_in(Cout), .d_in(Dout),
    .e_in(Eout), .f_in(Fout), .g_in(Gout), .h_in(Hout),
    .h0_in(H_init[255:224]), .h1_in(H_init[223:192]), 
    .h2_in(H_init[191:160]), .h3_in(H_init[159:128]),
    .h4_in(H_init[127:96]), .h5_in(H_init[95:64]), 
    .h6_in(H_init[63:32]), .h7_in(H_init[31:0]),
    .h0_out(hashed[255:224]), .h1_out(hashed[223:192]), 
    .h2_out(hashed[191:160]), .h3_out(hashed[159:128]),
    .h4_out(hashed[127:96]), .h5_out(hashed[95:64]), 
    .h6_out(hashed[63:32]), .h7_out(hashed[31:0])
);

endmodule // top



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
   logic [31:0]	 muxAout, muxBout, muxCout, muxDout, 
		muxEout, muxFout, muxGout, muxHout, 
	    Aout, Bout, Cout, Dout, 
		Eout, Fout, Gout, Hout; 
   logic [31:0]   h0, h1, h2, h3, h4, h5, h6, h7;   
   logic [31:0] W_selected , K_selected , sigma0_out, sigma1_out;
   logic [5:0] count, index;

   logic [31:0] M ={padded[511:480], padded[479:448], padded[447:416],
	       padded[415:384], padded[383:352], padded[351:320],
	       padded[319:288], padded[287:256], padded[255:224],
	       padded[223:192], padded[191:160], padded[159:128],
	       padded[127:96], padded[95:64], padded[63:32],
	       padded[31:0] };

   assign a = H[255:224];
   assign b = H[223:192];
   assign c = H[191:160];
   assign d = H[159:128];
   assign e = H[127:96];
   assign f = H[95:64];
   assign g = H[63:32];
   assign h = H[31:0];

   counter64 dut(clk, rst, start, count);
   W64 dut1( clk,   rst,  start, M , count,    W_selected);
 FSM dut2( clk, reset, start,index,  en,  done   );

//Muxes
   //s=select -> chooses either first input or outputs to continue with computation
   //A-Hout -> Output of computation
   //MuxA-Hout -> whichever choice is made with s, (a-h or A-Hout), Whichever path is gone down
   //a-h -> input a, defined before muxes

mux2 #(32) muxA ( a, Aout, count, muxAout);
mux2 #(32) muxB ( b, Bout, count, muxBout);
mux2 #(32) muxC ( c, Cout, count, muxCout);
mux2 #(32) muxD ( d, Dout, count, muxDout);
mux2 #(32) muxE ( e, Eout, count, muxEout);
mux2 #(32) muxF ( f, Fout, count, muxFout);
mux2 #(32) muxG ( g, Gout, count, muxGout);
mux2 #(32) muxH ( h, Hout, count, muxHout);

//needs each K value as an input, counter as s, and output y

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
    K[127:96],   K[95:64],    K[63:32],      K[31:0],   32'b00000,  
    count,      // Select signal for the mux
    K_selected        // Output of the mux
);



main_comp mc01 (muxAout, muxBout, muxCout, muxDout, 
		muxEout, muxFout, muxGout, muxHout, 
		K_selected, W_selected,
	    Aout, Bout, Cout, Dout, 
		Eout, Fout, Gout, Hout);



//registers
flopenr #(32) instanceA(clk, reset, count, a0_out, Aout);
flopenr #(32) instanceB(clk, reset, count, b0_out, Bout);
flopenr #(32) instanceC(clk, reset, count, c0_out, Cout);
flopenr #(32) instanceD(clk, reset, count, d0_out, Dout);
flopenr #(32) instanceE(clk, reset, count, e0_out, Eout);
flopenr #(32) instanceF(clk, reset, count, f0_out, Fout);
flopenr #(32) instanceG(clk, reset, count, g0_out, Gout);
flopenr #(32) instanceH(clk, reset, count, h0_out, Hout);




                                 
   intermediate_hash ih1 (Aout, Bout, Cout, Dout,
			  Eout, Fout, Gout, Hout,
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
      logic [31:0]	 muxAout, muxBout, muxCout, muxDout, 
		muxEout, muxFout, muxGout, muxHout, 
	    Aout, Bout, Cout, Dout, 
		Eout, Fout, Gout, Hout; 

   always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        Aout <= 32'b0;
        Bout <= 32'b0;
        Cout <= 32'b0;
        Dout <= 32'b0;
        Eout <= 32'b0;
        Fout <= 32'b0;
        Gout <= 32'b0;
        Hout <= 32'b0;
    end else if (en) begin
        Aout <= muxAout;
        Bout <= muxBout;
        Cout <= muxCout;
        Dout <= muxDout;
        Eout <= muxEout;
        Fout <= muxFout;
        Gout <= muxGout;
        Hout <= muxHout;
    end
end



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


     
   

module W64 (
    input  logic clk,          
    input  logic rst,             
    input  logic start,         
    input  logic [31:0] M , 
    input  logic [5:0] count,   
    output logic [31:0] W_selected);

    // Internal registers for W values
    logic [31:0] W_reg [0:63];
    logic [31:0] sigma0_out, sigma1_out;

    // Instantiate sigma0 and sigma1 modules
    sigma0 sig0_inst (.x(W_reg[count - 15]), .sig0(sigma0_out));
    sigma1 sig1_inst (.x(W_reg[count - 2]), .sig1(sigma1_out));

    // Combinational logic to compute W
    always_comb begin
        if (count < 16) begin
            W_selected = M[count]; // Use the initial message words
        end else begin
            W_selected = sigma1_out + W_reg[count - 7] + sigma0_out + W_reg[count - 16];
        end
    end

    // Sequential logic to update W_reg
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset W registers
            for (int i = 0; i < 64; i++) begin
                W_reg[i] <= 32'b0;
            end
        end else if (start) begin
            // Update the W registers on start
            if (count < 16) begin
                W_reg[count] <= M[count];
            end else begin
                W_reg[count] <= W_selected; // Store the computed W value
            end
        end
    end

endmodule