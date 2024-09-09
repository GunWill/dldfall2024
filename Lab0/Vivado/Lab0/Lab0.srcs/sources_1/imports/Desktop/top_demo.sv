`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  input  logic [3:0] sw,
  input  logic [3:0] btn,
  output logic [7:0] led
);
logic a,b,c,sum, cout;
  //Instantiation for fulladder from the SV file

  
  fulladder dut(a, b, c, sum, cout);
    assign a=btn[0];
  //Assigns a to 0th button
    assign b=btn[1];
  //Assigns b to 1st button
    assign c=btn[2];
  //Assigns c to 2nd button
    assign sum=led[0];
  //Assigns "Sum" output to 0th LED
    assign cout=led[1];
  //Assigns "cout" output to first LED
endmodule

