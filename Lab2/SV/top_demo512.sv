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
  logic [31:0] segments; 
  logic [511:0] hashed;
  // Place TicTacToe instantiation here
  top #(112, 1024) dut (112'h48656c6c6f205348412d35313221, hashed);
  multiplexer dut1 (hashed[255:0], sw[3:0], segments[15:0]);
  multiplexer2 dut2 (hashed[511:256], sw[7:4], segments[31:16]);
  
  
  //d693_db77_4994_9506_6222_61a5_33ef_98e5_4ed5_f609_20f6_0ad0_3bc3_38d0_5bd9_c905_1491_9ae8_b3de_1f25_f7d9_9f87_b056_5d0a_4024_93c5_b401_66a5_eb76_65c9_e3ac_af2b
  
  //multiplexer
  
  module multiplexer(input logic [255:0] hashed,
                     input logic [3:0] ctrl,
                     output logic [15:0] segments);
always_comb
case(ctrl)
// abc_defg
4'b0000: segments = hashed[15:0]; // 0
4'b0001: segments = hashed[31:16]; //1
4'b0010: segments = hashed[47:32]; //2
4'b00011: segments = hashed[63:48]; //3
4'b0100: segments = hashed[79:64]; //4
4'b0101: segments = hashed[95:80]; //5
4'b0110: segments = hashed[111:96]; //6
4'b0111: segments = hashed[127:112]; //7 
4'b1000: segments = hashed[143:128]; //8
4'b1001: segments = hashed[159:144]; //9
4'b1010: segments = hashed[175:160]; //10
4'b1011: segments = hashed[191:176]; //11
4'b1100: segments = hashed[207:192]; //12
4'b1101: segments = hashed[223:208]; //13
4'b1110: segments = hashed[239:224]; //14
4'b1111: segments = hashed[255:240]; //15

//4'b0000: segments = hashed[271:256]; // 16
//4'b0001: segments = hashed[287:272]; //17
//4'b0010: segments = hashed[303:288]; //18
//4'b0011: segments = hashed[319:304]; //19
//4'b0100: segments = hashed[335:320]; //20
//4'b0101: segments = hashed[351:336]; //21
//4'b0110: segments = hashed[367:352]; //22
//4'b0111: segments = hashed[383:368]; //23 
//4'b1000: segments = hashed[399:384]; //24
//4'b1001: segments = hashed[415:400]; //25
//4'b1010: segments = hashed[431:416]; //26
//4'b1011: segments = hashed[447:432]; //27
//4'b1100: segments = hashed[463:448]; //28
//4'b1101: segments = hashed[479:464]; //29
//4'b1110: segments = hashed[495:480]; //30
//4'b1111: segments = hashed[511:496]; //31

default: segments = 16'hAA00;
endcase
 endmodule
 
 
//module multiplexer2(input logic [511:256] hashed,
//input logic [7:4] ctrl,
 //output logic [31:16] segments);
//always_comb
//case(ctrl)
// abc_defg
//4'b0000: segments = hashed[271:256]; // 16
//4'b0001: segments = hashed[287:272]; //17
//4'b0010: segments = hashed[303:288]; //18
//4'b0011: segments = hashed[319:304]; //19
//4'b0100: segments = hashed[335:320]; //20
//4'b0101: segments = hashed[351:336]; //21
//4'b0110: segments = hashed[367:352]; //22
//4'b0111: segments = hashed[383:368]; //23 
//4'b1000: segments = hashed[399:384]; //24
//4'b1001: segments = hashed[415:400]; //25
//4'b1010: segments = hashed[431:416]; //26
//4'b1011: segments = hashed[447:432]; //27
//4'b1100: segments = hashed[463:448]; //28
//4'b1101: segments = hashed[479:464]; //29
//4'b1110: segments = hashed[495:480]; //30
//4'b1111: segments = hashed[511:496]; //31

//default: segments = 16'hAAAA;
//endcase
 //endmodule 
 
  
  //input random letters

  

  assign led [0] = segments[15:0];
  assign led[1] = segments[31:16];
  assign led [2] = segments[15:12];
  assign led[3] = segments[15:0];
  assign led[4] = segments[11:8]; 
  
    assign led [5] = segments[31:25];
  assign led[6] = segments[28:3];
  assign led [7] = segments[17:0];


  
  // 7-segment display
  
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
    .digit0(segments[7:0]),
    .digit1(segments[15:8]),
    .digit2(segments[23:16]),
    .digit3(segments[31:24]),
 
 
 
   //.digit0(4'hF),
  //.digit1(4'hf),
  //.digit2(4'hb),
  //.digit3(4'hB),
  
  //board display has issues w/ B, must have malfunction, or dead circuit in board
  //board displaying B as b, either due to board display error or implementation error? Most likely segment display is malfunctioning, because displays A and E as A and E
 
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
