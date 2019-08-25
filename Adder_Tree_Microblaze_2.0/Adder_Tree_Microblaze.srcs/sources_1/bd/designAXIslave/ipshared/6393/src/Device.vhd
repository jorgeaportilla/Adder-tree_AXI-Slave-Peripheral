----------------------------------------------------------------------------------
-- Company: UTFSM
-- Engineer: Jorge Portilla & Jesus Ortiz
-- Create Date: 18.10.2018 18:29:08
-- Project Name: Co-proccesor_ MicroBlaze
-- Target Devices: Nexys 4 DDR
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity device is
generic(number_inputs : integer := 256;
        number_iwidth : integer := 8);
Port ( clk        : in    STD_LOGIC;
       RX_data    : in    std_logic_vector(7 downto 0);
       RX_DV      : in    std_logic;
       q          : inout signed(17 downto 0);
       SEL        : inout STD_LOGIC_VECTOR(2 DOWNTO 0);
       enable     : out   std_logic_vector(7 downto 0);
       d3         : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
       d4         : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
       display    : out   STD_LOGIC_VECTOR(6  downto 0));
end device;

architecture UARTTXRX of device is
signal sample : integer := 1024;
signal clk_uart, clk_100, clk_pc : std_logic;
signal rstN : std_logic := '1';
signal TX_Byte: std_logic_vector(7 downto 0);
signal RXByte: std_logic_vector(7 downto 0);
signal TX_Done :  STD_LOGIC;
signal TX_Active : STD_LOGIC;

signal ITX_DV :STD_LOGIC;
signal TX_DV :STD_LOGIC;
signal d1 : std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
signal d2 : std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
signal q2  : signed(17 downto 0):= (others => '0');

component commanddecoder is
Port(clk   : in STD_LOGIC;
     RX_DV : IN STD_LOGIC;
     TX_DV : inout std_logic;
     RXByte: in STD_LOGIC_VECTOR(7 downto 0);
     d1    : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0);
     d2    : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0);
     SEL   : inout STD_LOGIC_VECTOR(2 downto 0));
end component;  

component control is
Port (clk: in std_logic;
      sel :in std_logic_vector(2 downto 0);
      binary  : in STD_LOGIC_VECTOR(17 DOWNTO 0);
      enable  : out std_logic_vector(7 downto 0);
      display : out STD_LOGIC_VECTOR(6  downto 0));
end component;

component coprocessor 
  Port ( d1     :in  std_logic_vector(number_inputs*number_iwidth-1 downto 0);
         d2     :in  std_logic_vector(number_inputs*number_iwidth-1 downto 0);
         d3     :out std_logic_vector(number_inputs*number_iwidth-1 downto 0);
         d4     :out std_logic_vector(number_inputs*number_iwidth-1 downto 0); 
         sum    :out signed(17 downto 0));
end component;

begin

Command: commanddecoder
port map( clk   => clk, RX_DV  => RX_DV, TX_DV  => TX_DV,
          RXByte => RX_data, d1 => d1, d2 => d2, SEL => SEL);
    
Processing_Core: coprocessor
    port map (d1 => d1, d2 => d2,
             d3 => d3, d4 => d4, sum  => q);
               
Displays: control 
Port map (clk => clk,binary => std_logic_vector(q),sel => SEL,
         enable => enable, display=> display);
               
end UARTTXRX;