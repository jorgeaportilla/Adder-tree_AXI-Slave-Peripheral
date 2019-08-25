-makelib ies_lib/xil_defaultlib -sv \
  "/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "/home/jorge/Xilinx/Vivado/2018.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/microblaze_v10_0_7 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/b649/hdl/microblaze_v10_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_microblaze_0_0/sim/designAXIslave_microblaze_0_0.vhd" \
-endlib
-makelib ies_lib/axi_lite_ipif_v3_0_4 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/cced/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/mdm_v3_2_14 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/5125/hdl/mdm_v3_2_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_mdm_1_0/sim/designAXIslave_mdm_1_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_clk_wiz_1_0/designAXIslave_clk_wiz_1_0_sim_netlist.vhdl" \
-endlib
-makelib ies_lib/lib_cdc_v1_0_2 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/proc_sys_reset_v5_0_12 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/f86a/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_rst_clk_wiz_1_100M_0/sim/designAXIslave_rst_clk_wiz_1_100M_0.vhd" \
-endlib
-makelib ies_lib/lib_pkg_v1_0_2 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/lib_srl_fifo_v1_0_2 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib ies_lib/axi_uartlite_v2_0_21 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/a15e/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_axi_uartlite_0_0/sim/designAXIslave_axi_uartlite_0_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_xbar_0/designAXIslave_xbar_0_sim_netlist.vhdl" \
-endlib
-makelib ies_lib/lmb_v10_v3_0_9 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/78eb/hdl/lmb_v10_v3_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_dlmb_v10_0/sim/designAXIslave_dlmb_v10_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_ilmb_v10_0/sim/designAXIslave_ilmb_v10_0.vhd" \
-endlib
-makelib ies_lib/lmb_bram_if_cntlr_v4_0_15 \
  "../../../../Adder_Tree_Microblaze.srcs/sources_1/bd/designAXIslave/ipshared/92fd/hdl/lmb_bram_if_cntlr_v4_0_vh_rfs.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ip/designAXIslave_dlmb_bram_if_cntlr_0/sim/designAXIslave_dlmb_bram_if_cntlr_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_ilmb_bram_if_cntlr_0/sim/designAXIslave_ilmb_bram_if_cntlr_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_lmb_bram_0/designAXIslave_lmb_bram_0_sim_netlist.vhdl" \
  "../../../bd/designAXIslave/sim/designAXIslave.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/hdl/AXI_Adder_Tree_v1_0_S00_AXI.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib -sv \
  "../../../bd/designAXIslave/ipshared/6393/src/coprocessor.sv" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../bd/designAXIslave/ipshared/6393/src/Device.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/src/bcddigit.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/src/binarybcd.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/src/commanddecoder.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/src/display.vhd" \
  "../../../bd/designAXIslave/ipshared/6393/hdl/AXI_Adder_Tree_v1_0.vhd" \
  "../../../bd/designAXIslave/ip/designAXIslave_AXI_Adder_Tree_0_1/sim/designAXIslave_AXI_Adder_Tree_0_1.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

