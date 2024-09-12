module fulladder (input logic a, b, c, output logic sum, cout);

assign sum=a^b^c;

assign cout=a&b|a&c|b&c;

endmodule //1-bit full adder module


module ripple_carry_adder(input logic [3:0] a, [3:0] b, c, output logic [3:0] sum, cout);
logic c0,c1,c2;

  fulladder FA0 (a[0], b[0], c, sum[0], c0);
  fulladder FA1 (a[1], b[1], c0, sum[1], c1);
  fulladder FA2 (a[2], b[2], c1, sum[2], c2);
  fulladder FA3 (a[3], b[3], c2, sum[3], cout);
  

endmodule //ripple carry adder
