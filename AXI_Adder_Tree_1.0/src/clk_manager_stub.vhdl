-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
-- Date        : Thu Mar  7 11:02:18 2019
-- Host        : Portilla running 64-bit Ubuntu 18.04.1 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/jorge/IPD432-Coprocesador-especializado/DeviceSVLatency/project_ila.srcs/sources_1/ip/clk_manager/clk_manager_stub.vhdl
-- Design      : clk_manager
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_manager is
  Port ( 
    clk_uart : out STD_LOGIC;
    clk_100 : out STD_LOGIC;
    clk_pc : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_manager;

architecture stub of clk_manager is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_uart,clk_100,clk_pc,clk_in1";
begin
end;
