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
vlog ../../verilog-ethernet/rtl/*.v
vlog ../../verilog-ethernet/lib/axis/rtl/*.v
vlog tb.sv


# start and run simulation
vsim -voptargs=+acc work.stimulus

view list
view wave

-- display input and output signals as hexidecimal values
# Diplays All Signals recursively
#add wave -hex -r /stimulus/*
add wave -noupdate -divider -height 32 "Inputs"
add wave -hex /stimulus/rx_clk
add wave -hex /stimulus/rx_rst
add wave -hex /stimulus/tx_clk
add wave -hex /stimulus/tx_rst
add wave -hex /stimulus/tx_axis_tdata
add wave -hex /stimulus/tx_axis_tvalid 
add wave -hex /stimulus/tx_axis_tlast 
add wave -hex /stimulus/tx_axis_tuser 
add wave -hex /stimulus/gmii_rxd 
add wave -hex /stimulus/gmii_rx_dv 
add wave -hex /stimulus/gmii_rx_er 
add wave -hex /stimulus/tx_ptp_ts 
add wave -hex /stimulus/rx_ptp_ts 
add wave -hex /stimulus/rx_clk_enable 
add wave -hex /stimulus/tx_clk_enable 
add wave -hex /stimulus/rx_mii_select 
add wave -hex /stimulus/tx_mii_select 
add wave -hex /stimulus/ifg_delay 
add wave -noupdate -divider -height 32 "Outputs"
add wave -hex /stimulus/tx_axis_tready
add wave -hex /stimulus/rx_axis_tdata
add wave -hex /stimulus/rx_axis_tvalid
add wave -hex /stimulus/rx_axis_tlast
add wave -hex /stimulus/rx_axis_tuser
add wave -hex /stimulus/gmii_txd
add wave -hex /stimulus/gmii_tx_en
add wave -hex /stimulus/gmii_tx_er
add wave -hex /stimulus/tx_axis_ptp_ts
add wave -hex /stimulus/tx_axis_ptp_ts_tag
add wave -hex /stimulus/tx_axis_ptp_ts_valid
add wave -hex /stimulus/tx_start_packet
add wave -hex /stimulus/tx_error_underflow
add wave -hex /stimulus/rx_start_packet
add wave -hex /stimulus/rx_error_bad_frame
add wave -hex /stimulus/rx_error_bad_fcs
add wave -noupdate -divider -height 32 "Status"
add wave -hex /stimulus/stat_tx_mcf
add wave -hex /stimulus/stat_rx_mcf
add wave -hex /stimulus/stat_tx_lfc_pkt
add wave -hex /stimulus/stat_tx_lfc_xon
add wave -hex /stimulus/stat_tx_lfc_xoff
add wave -hex /stimulus/stat_tx_lfc_paused
add wave -hex /stimulus/stat_tx_pfc_pkt
add wave -hex /stimulus/stat_tx_pfc_xon
add wave -hex /stimulus/stat_tx_pfc_xoff
add wave -hex /stimulus/stat_tx_pfc_paused
add wave -hex /stimulus/stat_rx_lfc_pkt
add wave -hex /stimulus/stat_rx_lfc_xon
add wave -hex /stimulus/stat_rx_lfc_xoff
add wave -hex /stimulus/stat_rx_lfc_paused
add wave -hex /stimulus/stat_rx_pfc_pkt
add wave -hex /stimulus/stat_rx_pfc_xon
add wave -hex /stimulus/stat_rx_pfc_xoff
add wave -hex /stimulus/stat_rx_pfc_paused   
add wave -noupdate -divider -height 32 "Configuration"
add wave -hex /stimulus/cfg_ifg
add wave -hex /stimulus/cfg_tx_enable
add wave -hex /stimulus/cfg_rx_enable
add wave -hex /stimulus/cfg_mcf_rx_eth_dst_mcast
add wave -hex /stimulus/cfg_mcf_rx_check_eth_dst_mcast
add wave -hex /stimulus/cfg_mcf_rx_eth_dst_ucast
add wave -hex /stimulus/cfg_mcf_rx_check_eth_dst_ucast
add wave -hex /stimulus/cfg_mcf_rx_eth_src
add wave -hex /stimulus/cfg_mcf_rx_check_eth_src
add wave -hex /stimulus/cfg_mcf_rx_eth_type
add wave -hex /stimulus/cfg_mcf_rx_opcode_lfc
add wave -hex /stimulus/cfg_mcf_rx_check_opcode_lfc
add wave -hex /stimulus/cfg_mcf_rx_opcode_pfc
add wave -hex /stimulus/cfg_mcf_rx_check_opcode_pfc
add wave -hex /stimulus/cfg_mcf_rx_forward
add wave -hex /stimulus/cfg_mcf_rx_enable
add wave -hex /stimulus/cfg_tx_lfc_eth_dst
add wave -hex /stimulus/cfg_tx_lfc_eth_src
add wave -hex /stimulus/cfg_tx_lfc_eth_type
add wave -hex /stimulus/cfg_tx_lfc_opcode
add wave -hex /stimulus/cfg_tx_lfc_en
add wave -hex /stimulus/cfg_tx_lfc_quanta
add wave -hex /stimulus/cfg_tx_lfc_refresh
add wave -hex /stimulus/cfg_tx_pfc_eth_dst
add wave -hex /stimulus/cfg_tx_pfc_eth_src
add wave -hex /stimulus/cfg_tx_pfc_eth_type
add wave -hex /stimulus/cfg_tx_pfc_opcode
add wave -hex /stimulus/cfg_tx_pfc_en
add wave -hex /stimulus/cfg_tx_pfc_quanta
add wave -hex /stimulus/cfg_tx_pfc_refresh
add wave -hex /stimulus/cfg_rx_lfc_opcode
add wave -hex /stimulus/cfg_rx_lfc_en
add wave -hex /stimulus/cfg_rx_pfc_opcode
add wave -hex /stimulus/cfg_rx_pfc_enq
add wave -noupdate -divider -height 32 "Priority Flow Control (PFC) (IEEE 802.3 annex 31D PFC"
add wave -hex /stimulus/tx_pfc_req   
add wave -hex /stimulus/tx_pfc_resend   
add wave -hex /stimulus/rx_pfc_en   
add wave -hex /stimulus/rx_pfc_req   
add wave -hex /stimulus/rx_pfc_ack   

#add list -hex /stimulus/-r /tb/*
#add log -r /*

-- Set Wave Output Items 
TreeUpdate [SetDefaultTree]
WaveRestoreZoom {0 ps} {75 ns}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2

-- Run the Simulation
run 100ns


