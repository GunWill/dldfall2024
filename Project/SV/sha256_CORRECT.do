# Copyright 1991-2016 Mentor Graphics Corporation
# 
# Modification by Oklahoma State University
# Use with Testbench 
# James Stine, 2008
# Go Cowboys!!!!!!
#
# All Rights Reserved.
#
# THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION
# WHICH IS THE PROPERTY OF MENTOR GRAPHICS CORPORATION
# OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
# Use this run.do file to run this example.
# Either bring up ModelSim and type the following at the "ModelSim>" prompt:
#     do run.do
# or, to run from a shell, type the following at the shell prompt:
#     vsim -do run.do -c
# (omit the "-c" to see the GUI while running from the shell)
onbreak {resume}
# create library
if [file exists work] {
    vdel -all
}
vlib work
# compile source files
vlog sha256_stub_CORRECT.sv 
vlog sha256_tb_tv_CORRECT.sv
vlog counter.sv 
vlog mux.sv 
vlog flopenr.sv

# start and run simulation
vsim -voptargs=+acc work.stimulus
view wave

-- display input and output signals as hexidecimal values
# Diplays All Signals recursively
#add wave -hex -r /stimulus/*
add wave -noupdate -divider -height 32 "Main tb"
add wave -noupdate -expand -group tb /stimulus/hashed
add wave -noupdate -expand -group tb /stimulus/golden
add wave -noupdate -expand -group tb /stimulus/errors
add wave -noupdate -expand -group tb /stimulus/message
add wave -noupdate -expand -group tb /stimulus/reset
add wave -noupdate -expand -group tb /stimulus/start
add wave -noupdate -expand -group tb /stimulus/clk
#add wave -noupdate -expand -group tb /stimulus/done


add wave -noupdate -divider -height 32 "padded"
add wave -noupdate -expand -group padded /stimulus/dut/padder/*
add wave -noupdate -divider -height 32 "sha256 main module"
add wave -noupdate -expand -group main /stimulus/dut/main/a
add wave -noupdate -expand -group main /stimulus/dut/main/b
add wave -noupdate -expand -group main /stimulus/dut/main/c
add wave -noupdate -expand -group main /stimulus/dut/main/d
add wave -noupdate -expand -group main /stimulus/dut/main/e
add wave -noupdate -expand -group main /stimulus/dut/main/f
add wave -noupdate -expand -group main /stimulus/dut/main/g
add wave -noupdate -expand -group main /stimulus/dut/main/h

add wave -noupdate -expand -group main /stimulus/dut/main/a_out
add wave -noupdate -expand -group main /stimulus/dut/main/b_out
add wave -noupdate -expand -group main /stimulus/dut/main/c_out
add wave -noupdate -expand -group main /stimulus/dut/main/d_out
add wave -noupdate -expand -group main /stimulus/dut/main/e_out
add wave -noupdate -expand -group main /stimulus/dut/main/f_out
add wave -noupdate -expand -group main /stimulus/dut/main/g_out
add wave -noupdate -expand -group main /stimulus/dut/main/h_out

add wave -noupdate -expand -group main /stimulus/dut/main/muxAout
add wave -noupdate -expand -group main /stimulus/dut/main/muxBout
add wave -noupdate -expand -group main /stimulus/dut/main/muxCout
add wave -noupdate -expand -group main /stimulus/dut/main/muxDout
add wave -noupdate -expand -group main /stimulus/dut/main/muxEout
add wave -noupdate -expand -group main /stimulus/dut/main/muxFout
add wave -noupdate -expand -group main /stimulus/dut/main/muxGout
add wave -noupdate -expand -group main /stimulus/dut/main/muxHout



add wave -noupdate -divider -height 32 "sha256 intermediate hash"
add wave -noupdate -expand -group ih1 /stimulus/dut/main/ih1/*

add wave -noupdate -divider -height 32 "sha256 FSM"
add wave /stimulus/dut/dut2/*

add wave -noupdate -divider -height 32 "sha256 counter64"
add wave /stimulus/dut/dut/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H0/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H1/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H2/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H3/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H4/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H5/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H6/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/H7/*

add wave -noupdate -divider -height 32 "sha256 muxK"
add wave /stimulus/dut/main/muxK/*

add wave -noupdate -divider -height 32 "sha256 muxW"
add wave /stimulus/dut/main/muxW/*

add wave -noupdate -divider -height 32 "sha256 muxA"
add wave /stimulus/dut/main/muxA/*

add wave -noupdate -divider -height 32 "sha256 muxB"
add wave /stimulus/dut/main/muxB/*

add wave -noupdate -divider -height 32 "sha256 muxC"
add wave /stimulus/dut/main/muxC/*

add wave -noupdate -divider -height 32 "sha256 muxD"
add wave /stimulus/dut/main/muxD/*

add wave -noupdate -divider -height 32 "sha256 muxE"
add wave /stimulus/dut/main/muxE/*

add wave -noupdate -divider -height 32 "sha256 muxF"
add wave /stimulus/dut/main/muxF/*

add wave -noupdate -divider -height 32 "sha256 muxG"
add wave /stimulus/dut/main/muxG/*


add wave -noupdate -divider -height 32 "sha256 muxH"
add wave /stimulus/dut/main/muxH/*




add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regA/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regB/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regC/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regD/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regE/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regF/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regG/*

add wave -noupdate -divider -height 32 "sha256 flip flop"
add wave /stimulus/dut/main/regH/*






-- Set Wave Output Items 
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 350
configure wave -valuecolwidth 200
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

-- Run the Simulation 
run 700 ns
quit