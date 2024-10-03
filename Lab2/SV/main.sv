module main_comp (input logic [31:0] a_in, b_in, c_in, d_in, e_in, f_in, g_in, h_in,
		  input logic [31:0] K_in, W_in,
		  output logic [31:0] a_out, b_out, c_out, d_out, e_out, f_out, g_out,
		  output logic [31:0] h_out);

   // Figure 4
logic [31:0] ch, maj, Sig0, Sig1;	
choice ch1 ( e_in, f_in, g_in, ch);
majority m1(a_in, b_in, c_in, maj);
Sigma0 S0(e_in, Sig0);	
Sigma1 S1(a_in, Sig1);
logic [35:0] t1, t2;
logic [31:0] T1, T2;
assign t1=(h_in+Sig1+ch+K_in+W_in)  ;
assign t2=(Sig0+maj) ;
assign T1 = t1 % 2**32;
assign T2 = t2 % 2**32;

//% 2**32

assign h_out=g_in;
assign g_out=f_in;
assign f_out=e_in;
assign e_out=(d_in+T1) ;
assign d_out=c_in;
assign c_out=b_in;
assign b_out=a_in;
assign a_out = (T1+T2) ;


endmodule // main_comp

module majority (input logic [31:0] x, y, z, output logic [31:0] maj);

   // See Section 2.3.3, Number 4
   assign maj = (x & y) ^ (x & z) ^ (y & z);

endmodule // majority

module choice (input logic [31:0] x, y, z, output logic [31:0] ch);

   // See Section 2.3.3, Number 4

   assign ch = (x & y) ^ (~x & z); 


endmodule // choice

module Sigma0 (input logic [31:0] x, output logic [31:0] Sig0);

assign Sig0 = ({x[1:0], x[31:2]})^({x[12:0], x[31:13]})^({x[21:0], x[31:22]});

   // See Section 2.3.3, Number 4


endmodule // Sigma0

module sigma0 (input logic [31:0] x, output logic [31:0] sig0);

      // See Section 2.3.3, Number 2

      assign sig0 = ({x[6:0], x[31:7]})^({x[17:0], x[31:18]})^(x>>3);
   

endmodule // sigma0

module Sigma1 (input logic [31:0] x, output logic [31:0] Sig1);

   // See Section 2.3.3, Number 4
   assign Sig1 = ({x[5:0], x[31:6]})^({x[10:0], x[31:11]})^({x[24:0], x[31:25]});

endmodule // Sigma1

module sigma1 (input logic [31:0] x, output logic [31:0] sig1);

      // See Section 2.3.3, Number 2
   
assign sig1 = ({x[16:0], x[31:17]})^({x[18:0], x[31:19]})^(x>>10);

endmodule // sigma1