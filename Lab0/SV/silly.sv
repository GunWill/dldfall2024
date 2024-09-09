module silly (input  logic a, b, c, output logic sum, cout);
   
  assign y = ~b & ~c | a & ~b;
   
endmodule  //silly module given to students as an example of coding for the logic design

module fulladder (input logic a, b, c, output logic sum, cout);

assign sum=a^b^c;

assign cout=a&b|a&c|b&c;

endmodule //actual module used in lab 0 to produce a full adder on the FPGA
