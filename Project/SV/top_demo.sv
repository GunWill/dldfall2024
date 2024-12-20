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
  
  logic start;
  
  // Place TicTacToe instantiation here
  assign start = sw[4];
  
   logic [15:0] segments; 
 (*mark_debug = "true" *) logic [255:0] hashed;
  // Place TicTacToe instantiation here
  top #(120, 512) dut000(
    .clk(sysclk_125mhz),
    .reset(rst),
    .start(start),                   // Start hashing process
    .message(120'h48656c6c6f2c205348412d32353621), // "Hello, SHA-256!" message
    .hashed(hashed)                     // Done signal when hashing is complete
  );
  
  
  
multiplexer dut111 (
  .hashed(hashed),
  .ctrl(sw[3:0]),
  .segments(segments)
);

  
  //ideal sha256 output
  //256'h_d0e8_b8f1_1c98_f369_016e_b2ed_3c54_1e1f_0138_2f9d_5b31_04c9_ffd0_6b61_75a4_6271
  
  //multiplexer
 
 
 
 
 
  
  
  
  
  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
    .digit0(segments[3:0]),          // Least significant hex digit
    .digit1(segments[7:4]),          // Second hex digit
    .digit2(segments[11:8]),         // Third hex digit
    .digit3(segments[15:12]), 
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




module multiplexer (
  input logic [255:0] hashed,      // 256-bit hash input
  input logic [3:0] ctrl,          // 4-bit control for segment selection
  output logic [15:0] segments     // Selected 16-bit segment
);

  always_comb begin
    case (ctrl)
      4'b0000: segments = hashed[15:0];
      4'b0001: segments = hashed[31:16];
      4'b0010: segments = hashed[47:32];
      4'b0011: segments = hashed[63:48];
      4'b0100: segments = hashed[79:64];
      4'b0101: segments = hashed[95:80];
      4'b0110: segments = hashed[111:96];
      4'b0111: segments = hashed[127:112];
      4'b1000: segments = hashed[143:128];
      4'b1001: segments = hashed[159:144];
      4'b1010: segments = hashed[175:160];
      4'b1011: segments = hashed[191:176];
      4'b1100: segments = hashed[207:192];
      4'b1101: segments = hashed[223:208];
      4'b1110: segments = hashed[239:224];
      4'b1111: segments = hashed[255:240];
      default: segments = 16'hAAAA;
    endcase
  end

endmodule
