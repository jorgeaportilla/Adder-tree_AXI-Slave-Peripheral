----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.11.2018 22:26:24
-- Design Name: 
-- Module Name: control - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control is
  Port (clk: in std_logic;
        sel :in std_logic_vector(2 downto 0);
        binary	:in STD_LOGIC_VECTOR(17 DOWNTO 0);
        enable  :out std_logic_vector(7 downto 0);
        display :out STD_LOGIC_VECTOR(6  downto 0));
end control;

architecture Behavioral of control is
signal reset: std_logic:='1';
signal busy: std_logic;
signal binary2: std_logic_vector(17 downto 0):= (others => '0');
signal bcd	:STD_LOGIC_VECTOR(23 DOWNTO 0);
signal ena: std_logic:='1';
component binary_to_bcd IS
	GENERIC(
		bits		:	INTEGER := 18;		--size of the binary input numbers in bits
		digits	:	INTEGER := 6);		--number of BCD digits to convert to
	PORT(
		clk		:	IN		STD_LOGIC;											--system clock
		reset_n	:	IN		STD_LOGIC;											--active low asynchronus reset
		ena		:	IN		STD_LOGIC;											--latches in new binary number and starts conversion
		binary	:	IN		STD_LOGIC_VECTOR(bits-1 DOWNTO 0);			--binary number to convert
		busy		:	OUT	STD_LOGIC;											--indicates conversion in progress
		bcd		:	OUT	STD_LOGIC_VECTOR(digits*4-1 DOWNTO 0));	--resulting BCD number
end component;

begin

binaybcd:  binary_to_bcd 
	GENERIC MAP(
		bits	=> 18,		    --size of the binary input numbers in bits
		digits	=> 6)	    	--number of BCD digits to convert to
	PORT MAP(
		clk		=> clk,		    --system clock
		reset_n	=> reset,		--active low asynchronus reset
		ena		=> ena,			-- atches in new binary number and starts conversion
		binary	=> binary2,		--binary number to convert
		busy    => busy,		--indicates conversion in progress
		bcd		=> bcd         	--resulting BCD number
);


process(clk,sel,binary)
    begin
    if(sel = "101")then
    binary2 <= binary;
    else
    binary2 <= (others => '0');
    end if;
end process;

process(clk)
variable x: integer:=0;
variable y: integer:=0;
     begin
      if (clk'event and clk='1') then
       x:=x+1;
       if (x > 100000) then
        x:=0;
        y := y+1;
        if(y > 5) then
        y := 0;
        end if;
        if (y = 0) then
        enable<="11111110"; 
        case bcd(3 downto 0) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" =>  display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case;  
        end if;
        if (y=1) then
        enable<="11111101"; 
        case bcd(7 downto 4) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" => display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case;  
        end if;
        if (y =2) then
        enable<="11111011"; 
        case bcd(11 downto 8) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" => display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case; 
        end if;
        if (y =3) then
        enable<="11110111"; 
        case bcd(15 downto 12) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" => display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case; 
        end if;
        if (y = 4) then
        enable<="11101111"; 
        case bcd(19 downto 16) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" => display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case; 
        end if;        
        if (y = 5) then
        enable<="11011111"; 
        case bcd(23 downto 20) is    
        when "0000" => display<="1000000"; 
        when "0001" => display<="1111001";
        when "0010" => display<="0100100"; 
        when "0011" => display<="0110000";
        when "0100" => display<="0011001";
        when "0101" => display<="0010010";
        when "0110" => display<="0000010";
        when "0111" => display<="1111000";
        when "1000" => display<="0000000";
        when "1001" => display<="0011000";
        when others =>
        end case; 
        end if;  
       end if;
       end if;
      end process;
end Behavioral;
