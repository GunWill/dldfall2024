module fulladder (input logic a, b, cin, output logic sum, cout);

assign sum=a^b^cin;

assign cout=a&b|a&cin|b&cin;

endmodule //1-bit full adder module

//always effecient - less area, less power, less energy, more performance for less area and energy 
//get PPA from Vivado after implementation 
//256 total possabilities 

module ripple_carry_adder(input logic [3:0] a, b, input logic cin, output logic [3:0] sum, output logic cout);
  logic c0,c1,c2; //can also do [2:0] cout and then cout[0], cout[1], cout[2] in the input down below instead of c0, c1, c2

  //RCA1 (a[0], b[0], cin, sum[0], cout[0])
  //RCA2 (a[1], b[1], cout[0], sum[1], cout[1])
  //RCA3 (a[2], b[2], cout[1], sum[2], cout[2])
  //RCA4 (a[3], b[3], cout[2], sum[3], sum[4])

  fulladder FA0 (a[0], b[0], cin, sum[0], c0);
  fulladder FA1 (a[1], b[1], c0, sum[1], c1);
  fulladder FA2 (a[2], b[2], c1, sum[2], c2);
  fulladder FA3 (a[3], b[3], c2, sum[3], cout);
  

endmodule //ripple carry adder
