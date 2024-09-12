module fulladder (input logic a, b, c, output logic sum, cout);

assign sum=a^b^c;

assign cout=a&b|a&c|b&c;

endmodule //1-bit full adder module
