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
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  // output  
  output logic [7:0] led,
  output logic sseg_ca,
  output logic sseg_cb,
  output logic sseg_cc,
  output logic sseg_cd,
  output logic sseg_ce,
  output logic sseg_cf,
  output logic sseg_cg,
  output logic sseg_dp,
  output logic [3:0] sseg_an
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  // logic [7:0] ctrl;
  logic [15:0] segments; 
  logic [1:0] LR;
  logic reset;
  logic [5:0] light;
  // Place TicTacToe instantiation here
  FSM dut (clk, reset, LR, light);
  
  assign reset=sw[1];
  assign LR[1]= sw [3];
  assign LR[0]=sw[2];
  assign light[5]=led[3];
  assign light[4]=led[4];
  assign light[3]=led[5];
  
  assign light[2:0]=led[2:0];
  
  
  //Clock Divider
  module clk_div (input logic clk, input logic rst, output logic clk_en);

   logic [23:0] clk_count;

   always_ff @(posedge clk) begin
      if (rst)
	clk_count <= 24'h0;
      else
	clk_count <= clk_count + 1;
   end   
   
   assign clk_en = clk_count[23];
   
endmodule // clk_div

  

  //segment_driver driver(
  /*.clk(smol_clk),
  .rst(btn[3]),
    .digit0(segments[3:0]),
    .digit1(segments[7:4]),
    .digit2(segments[11:8]),
    .digit3(segments[15:12]),

 
 ///try synthesis w/ hardcoded digits values, to see if board can even get a signal. If synthesis doesn't work w/ these hardcoded values, then possible something is wrong with the clock, or some other error that
    //is making the file unable to synthesize. Also can try to just try 1 mux for now, then get the other mux to work. 
 
   //.digit0(4'hF),
  //.digit1(4'hf),
//.digit2(4'hb),
  //.digit3(4'hB),
  
  
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );
*/
// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
