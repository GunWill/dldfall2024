///////////////////////////////////////////
// mux.sv
//
// Written: David_Harris@hmc.edu 9 January 2021
// Modified: 
//
// Purpose: Various flavors of multiplexers
// 
// A component of the CORE-V-WALLY configurable RISC-V project.
// 
// Copyright (C) 2021-23 Harvey Mudd College & Oklahoma State University
//
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.1
//
// Licensed under the Solderpad Hardware License v 2.1 (the “License”); you may not use this file 
// except in compliance with the License, or, at your option, the Apache License version 2.0. You 
// may obtain a copy of the License at
//
// https://solderpad.org/licenses/SHL-2.1/
//
// Unless required by applicable law or agreed to in writing, any work distributed under the 
// License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
// either express or implied. See the License for the specific language governing permissions 
// and limitations under the License.
////////////////////////////////////////////////////////////////////////////////////////////////

/* verilator lint_off DECLFILENAME */

module mux2 #(parameter WIDTH = 32) (
  input  logic [WIDTH-1:0] d0, d1, 
  input  logic             s, 
  output logic [WIDTH-1:0] y);

  assign y = s ? d1 : d0; 
endmodule

module mux3 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2,
  input  logic [1:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[1] ? d2 : (s[0] ? d1 : d0); // exclusion-tag: mux3
endmodule

module mux4 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2, d3,
  input  logic [1:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0); 
endmodule

module mux5 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2, d3, d4,
  input  logic [2:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[2] ? d4 : (s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)); 
endmodule

module mux6 #(parameter WIDTH = 8) (
  input  logic [WIDTH-1:0] d0, d1, d2, d3, d4, d5,
  input  logic [2:0]       s, 
  output logic [WIDTH-1:0] y);

  assign y = s[2] ? (s[0] ? d5 : d4) : (s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)); 
endmodule

module mux16 #(parameter WIDTH = 8)
   (input logic [WIDTH-1:0] d0, d1, d2, d3, d4, input [3:0] s,
    output logic [WIDTH-1:0] y);

   always_comb
     case(s)
       4'b0001: y = d0;
       4'b0010: y = d1;
       4'b0100: y = d2;
       4'b1000: y = d3;
       default: y = d4;
     endcase // case (s)
endmodule // mux16

module mux64 #(parameter WIDTH = 32)
   (input logic [31:0] d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10,
    d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24,
    d25, d26, d27, d28, d29, d30, d31, d32, d33, d34, d35, d36, d37, d38, 
    d39, d40, d41, d42, d43, d44, d45, d46, d47, d48, d49, d50, d51, d52,
    d53, d54, d55, d56, d57, d58, d59, d60, d61, d62, d63, d64, input [5:0] count,
    output logic [31:0] y);

   always_comb
     case(count)
       6'b000000: y = d0;
       6'b000001: y = d1;
       6'b000010: y = d2;
       6'b000011: y = d3;
       6'b000100: y = d4;
       6'b000101: y = d5;
       6'b000110: y = d6;
       6'b000111: y = d7;
       6'b001000: y = d8;
       6'b001001: y = d9;
       6'b001010: y = d10;
       6'b001011: y = d11;
       6'b001100: y = d12;
       6'b001101: y = d13;
       6'b001110: y = d14;
       6'b001111: y = d15;
       6'b010000: y = d16;
       6'b010001: y = d17;
       6'b010010: y = d18;
       6'b010011: y = d19;
       6'b010100: y = d20;
       6'b010101: y = d21;
       6'b010110: y = d22;
       6'b010111: y = d23;
       6'b011000: y = d24;
       6'b011001: y = d25;
       6'b011010: y = d26;
       6'b011011: y = d27;
       6'b011100: y = d28;
       6'b011101: y = d29;
       6'b011110: y = d30;
       6'b011111: y = d31;
       6'b100000: y = d32;
       6'b100001: y = d33;
       6'b100010: y = d34;
       6'b100011: y = d35;
       6'b100100: y = d36;
       6'b100101: y = d37;
       6'b100110: y = d38;
       6'b100111: y = d39;
       6'b101000: y = d40;
       6'b101001: y = d41;
       6'b101010: y = d42;
       6'b101011: y = d43;
       6'b101100: y = d44;
       6'b101101: y = d45;
       6'b101110: y = d46;
       6'b101111: y = d47;
       6'b110000: y = d48;
       6'b110001: y = d49;
       6'b110010: y = d50;
       6'b110011: y = d51;
       6'b110100: y = d52;
       6'b110101: y = d53;
       6'b110110: y = d54;
       6'b110111: y = d55;
       6'b111000: y = d56;
       6'b111001: y = d57;
       6'b111010: y = d58;
       6'b111011: y = d59;
       6'b111100: y = d60;
       6'b111101: y = d61;
       6'b111110: y = d62;
       6'b111111: y = d63;
       default: y = d64;
     endcase // case (s)
endmodule // mux16
