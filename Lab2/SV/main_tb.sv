`timescale 1ns / 1ps
module tb ();
 logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in;
 logic [31:0] K_in, W_in;
 logic [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out;
 logic [31:0] h_out;
   main_comp dut (32'h6a09e667, 32'hbb67ae85, 32'h3c6ef372, 32'ha54ff53a, 32'h510e527f, 32'h9b05688c,32'h1f83d9ab,32'h5be0cd19,32'h428a2f98, 32'h48656c6c,a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out);
endmodule
