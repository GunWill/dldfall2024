module silly (input  logic a, b, c, output logic sum, cout);
   
  assign y = ~b & ~c | a & ~b;
   
endmodule
module fulladder (input logic a, b, c, output logic sum, cout);

assign sum=a^b^c;

assign cout=a&b|a&c|b&c;

endmodule