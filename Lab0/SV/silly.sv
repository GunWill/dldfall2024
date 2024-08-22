module silly (input  logic [2:0] a, b, c, output logic [1:0] y);
   
  assign y = ~b & ~c | a & ~b;
   
endmodule
