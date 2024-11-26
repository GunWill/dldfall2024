`timescale 1ns / 1ps

module top_demo
(
  // Input signals
  input  logic [7:0] sw,             // Switches for segment selection
  input  logic [3:0] btn,            // Buttons for control
  input  logic       sysclk_125mhz,  // 125 MHz system clock
  input  logic       rst,            // Reset signal

  // Output signals
  output logic [7:0] led,            // Debugging LEDs
  output logic sseg_ca,              // 7-segment cathode (a)
  output logic sseg_cb,              // 7-segment cathode (b)
  output logic sseg_cc,              // 7-segment cathode (c)
  output logic sseg_cd,              // 7-segment cathode (d)
  output logic sseg_ce,              // 7-segment cathode (e)
  output logic sseg_cf,              // 7-segment cathode (f)
  output logic sseg_cg,              // 7-segment cathode (g)
  output logic sseg_dp,              // 7-segment decimal point
  output logic [3:0] sseg_an         // 7-segment anodes
);

  // Internal signals
  logic [255:0] hashed;              // 256-bit hashed output from SHA-256 core
  logic [15:0] segments;             // Selected 16-bit hash segment for 7-segment display
  logic done;                        // SHA-256 hashing done signal
  logic start;                       // Start signal derived from `btn[0]`
  logic [16:0] CURRENT_COUNT;        // Clock divider counter
  logic [16:0] NEXT_COUNT;           // Next clock divider counter value
  logic smol_clk;                    // Slower clock for 7-segment display

  // Sequential SHA-256 Core (FSM & counter are inside)
  sequential_sha256 sha256_inst (
    .clk(sysclk_125mhz),
    .reset(rst),
    .start(start),                   // Start hashing process
    .message(120'h48656c6c6f2c205348412d32353621), // "Hello, SHA-256!" message
    .hashed(hashed),                 // Output hashed value
    .done(done)                      // Done signal when hashing is complete
  );

  // Multiplexer for selecting 16-bit hash segment
  multiplexer mux_inst (
    .hashed(hashed),
    .ctrl(sw[3:0]),                  // Lower 4 switches select the hash segment
    .segments(segments)              // Selected 16-bit segment
  );

  // Start signal is triggered by `btn[0]`
  assign start = btn[0];

  // Debugging outputs on LEDs
  assign led[7:0] = hashed[7:0];     // Display least significant byte on LEDs

  // 7-Segment Display Driver
  segment_driver driver_inst (
    .clk(smol_clk),
    .rst(btn[3]),                    // Reset signal for 7-segment display
    .digit0(segments[3:0]),          // Least significant hex digit
    .digit1(segments[7:4]),          // Second hex digit
    .digit2(segments[11:8]),         // Third hex digit
    .digit3(segments[15:12]),        // Most significant hex digit
    .decimals(4'b0000),              // Decimal points control (all off)
    .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
    .digit_anodes(sseg_an)
  );

  // Register logic for clock divider
  always @(posedge sysclk_125mhz or posedge rst) begin
    if (rst) begin
      CURRENT_COUNT <= 17'h00000;
    end else begin
      CURRENT_COUNT <= NEXT_COUNT;
    end
  end

  // Increment logic for clock divider
  assign NEXT_COUNT = (CURRENT_COUNT == 17'd100000) ? 17'h00000 : CURRENT_COUNT + 1;

  // Create slower clock signal
  assign smol_clk = (CURRENT_COUNT == 17'd100000) ? 1'b1 : 1'b0;

endmodule
