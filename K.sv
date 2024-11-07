module top ( 

input logic clk, reset, start,
input logic [2047:0] K,
input logic [5:0] count,
output logic [31:0] Kout);

counter64 dut(clk, reset, start, count);
decrementK dut1(count, K, Kout);
   
endmodule // top

module decrementK(input logic [5:0] count, input logic [2047:0] K, output logic [31:0] Kout);



//if counter <= 6'b111110
   //K-=32;
   //get value
//else
   //get value 
   //end loop

assign Kout = (K>>2016 - 32*count) ;


endmodule //decrementK