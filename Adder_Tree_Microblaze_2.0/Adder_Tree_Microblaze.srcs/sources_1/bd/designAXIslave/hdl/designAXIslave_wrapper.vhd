--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
--Date        : Sun Aug 25 16:39:05 2019
--Host        : Portilla running 64-bit Ubuntu 18.04.2 LTS
--Command     : generate_target designAXIslave_wrapper.bd
--Design      : designAXIslave_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity designAXIslave_wrapper is
  port (
    display : out STD_LOGIC_VECTOR ( 6 downto 0 );
    enable : out STD_LOGIC_VECTOR ( 7 downto 0 );
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end designAXIslave_wrapper;

architecture STRUCTURE of designAXIslave_wrapper is
  component designAXIslave is
  port (
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    display : out STD_LOGIC_VECTOR ( 6 downto 0 );
    enable : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  end component designAXIslave;
begin
designAXIslave_i: component designAXIslave
     port map (
      display(6 downto 0) => display(6 downto 0),
      enable(7 downto 0) => enable(7 downto 0),
      reset => reset,
      sys_clock => sys_clock,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
