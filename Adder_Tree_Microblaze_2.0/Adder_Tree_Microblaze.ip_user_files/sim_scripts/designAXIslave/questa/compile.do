vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/microblaze_v10_0_7
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/mdm_v3_2_14
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/proc_sys_reset_v5_0_12
vlib questa_lib/msim/lib_pkg_v1_0_2
vlib questa_lib/msim/lib_srl_fifo_v1_0_2
vlib questa_lib/msim/axi_uartlite_v2_0_21
vlib questa_lib/msim/lmb_v10_v3_0_9
vlib questa_lib/msim/lmb_bram_if_cntlr_v4_0_15

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap microblaze_v10_0_7 questa_lib/msim/microblaze_v10_0_7
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap mdm_v3_2_14 questa_lib/msim/mdm_v3_2_14
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_12 questa_lib/msim/proc_sys_reset_v5_0_12
vmap lib_pkg_v1_0_2 questa_lib/msim/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 questa_lib/msim/lib_srl_fifo_v1_0_2
vmap axi_uartlite_v2_0_21 questa_lib/msim/axi_uartlite_v2_0_21
vmap lmb_v10_v3_0_9 questa_lib/msim/lmb_v10_v3_0_9
vmap lmb_bram_if_cntlr_v4_0_15 questa_lib/msim/lmb_bram_if_cntlr_v4_0_15

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b65a" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ec67/hdl" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b65a" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ec67/hdl" \
"/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work microblaze_v10_0_7 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b649/hdl/microblaze_v10_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_microblaze_0_0/sim/designAXIslave_microblaze_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work mdm_v3_2_14 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/5125/hdl/mdm_v3_2_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_mdm_1_0/sim/designAXIslave_mdm_1_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_clk_wiz_1_0/designAXIslave_clk_wiz_1_0_sim_netlist.vhdl" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_12 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_rst_clk_wiz_1_100M_0/sim/designAXIslave_rst_clk_wiz_1_100M_0.vhd" \

vcom -work lib_pkg_v1_0_2 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_21 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/a15e/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_axi_uartlite_0_0/sim/designAXIslave_axi_uartlite_0_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_xbar_0/designAXIslave_xbar_0_sim_netlist.vhdl" \

vcom -work lmb_v10_v3_0_9 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_dlmb_v10_0/sim/designAXIslave_dlmb_v10_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_ilmb_v10_0/sim/designAXIslave_ilmb_v10_0.vhd" \

vcom -work lmb_bram_if_cntlr_v4_0_15 -64 -93 \
"../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ip/designAXIslave_dlmb_bram_if_cntlr_0/sim/designAXIslave_dlmb_bram_if_cntlr_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_ilmb_bram_if_cntlr_0/sim/designAXIslave_ilmb_bram_if_cntlr_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_lmb_bram_0/designAXIslave_lmb_bram_0_sim_netlist.vhdl" \
"../../../bd/designAXIslave/sim/designAXIslave.vhd" \
"../../../bd/designAXIslave/ipshared/6393/hdl/AXI_Adder_Tree_v1_0_S00_AXI.vhd" \

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b65a" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ec67/hdl" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b65a" "+incdir+../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ec67/hdl" \
"../../../bd/designAXIslave/ipshared/6393/src/coprocessor.sv" \

vcom -work xil_defaultlib -64 -93 \
"../../../bd/designAXIslave/ipshared/6393/src/Device.vhd" \
"../../../bd/designAXIslave/ipshared/6393/src/bcddigit.vhd" \
"../../../bd/designAXIslave/ipshared/6393/src/binarybcd.vhd" \
"../../../bd/designAXIslave/ipshared/6393/src/commanddecoder.vhd" \
"../../../bd/designAXIslave/ipshared/6393/src/display.vhd" \
"../../../bd/designAXIslave/ipshared/6393/hdl/AXI_Adder_Tree_v1_0.vhd" \
"../../../bd/designAXIslave/ip/designAXIslave_AXI_Adder_Tree_0_1/sim/designAXIslave_AXI_Adder_Tree_0_1.vhd" \

vlog -work xil_defaultlib \
"glbl.v"
