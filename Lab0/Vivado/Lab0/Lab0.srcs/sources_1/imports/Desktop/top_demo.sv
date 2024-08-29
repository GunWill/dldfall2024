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
//  assign led[3:0] = sw;
//  assign led[7:4] = btn;
  
  fulladder dut(a, b, c, sum, cout);
    assign a=btn[0];
    assign b=btn[1];
    assign c=btn[2];
    assign sum=led[0];
    assign cout=led[1];
endmodule

