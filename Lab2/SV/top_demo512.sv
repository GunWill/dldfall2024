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
  logic [511:0] hashed;
  // Place TicTacToe instantiation here
  top #(112, 1024) dut (112'h48656c6c6f205348412d35313221, hashed);
  multiplexer dut1 (hashed[511:0], sw[4:0], segments[15:0]);
  
  
  //Ideal sha512 output for comparrison
  //d693_db77_4994_9506_6222_61a5_33ef_98e5_4ed5_f609_20f6_0ad0_3bc3_38d0_5bd9_c905_1491_9ae8_b3de_1f25_f7d9_9f87_b056_5d0a_4024_93c5_b401_66a5_eb76_65c9_e3ac_af2b
  
  //multiplexer
  
  module multiplexer(input logic [511:0] hashed,
                     input logic [4:0] ctrl,
                     output logic [15:0] segments);
always_comb
case(ctrl)
5'b00000: segments = hashed[15:0]; // 0
5'b00001: segments = hashed[31:16]; //1
5'b00010: segments = hashed[47:32]; //2
5'b00011: segments = hashed[63:48]; //3
5'b00100: segments = hashed[79:64]; //4
5'b00101: segments = hashed[95:80]; //5
5'b00110: segments = hashed[111:96]; //6
5'b00111: segments = hashed[127:112]; //7 
5'b01000: segments = hashed[143:128]; //8
5'b01001: segments = hashed[159:144]; //9
5'b01010: segments = hashed[175:160]; //10
5'b01011: segments = hashed[191:176]; //11
5'b01100: segments = hashed[207:192]; //12
5'b01101: segments = hashed[223:208]; //13
5'b01110: segments = hashed[239:224]; //14
5'b01111: segments = hashed[255:240]; //15
5'b10000: segments = hashed[271:256]; // 16
5'b10001: segments = hashed[287:272]; //17
5'b10010: segments = hashed[303:288]; //18
5'b10011: segments = hashed[319:304]; //19
5'b10100: segments = hashed[335:320]; //20
5'b10101: segments = hashed[351:336]; //21
5'b10110: segments = hashed[367:352]; //22
5'b10111: segments = hashed[383:368]; //23 
5'b11000: segments = hashed[399:384]; //24
5'b11001: segments = hashed[415:400]; //25
5'b11010: segments = hashed[431:416]; //26
5'b11011: segments = hashed[447:432]; //27
5'b11100: segments = hashed[463:448]; //28
5'b11101: segments = hashed[479:464]; //29
5'b11110: segments = hashed[495:480]; //30
5'b11111: segments = hashed[511:496]; //31
default: segments = 16'hAAA0;
endcase
 endmodule

  
  

//DEBUGGING:
//these test if the board is getting a signal for segments
  
  assign led[0] = segments[15:0];
  //assign led[1] = segments[31:16];
  assign led[2] = segments[15:12];
  assign led[3] = segments[15:0];
  assign led[4] = segments[11:8]; 
  //assign led[5] = segments[31:25];
  //assign led[6] = segments[28:3];
  //assign led[7] = segments[17:0];


  
  // 7-segment display
  
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
    .digit0(segments[3:0]),
    .digit1(segments[7:4]),
    .digit2(segments[11:8]),
    .digit3(segments[15:12]),

 //DEBUGGING:
    
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

