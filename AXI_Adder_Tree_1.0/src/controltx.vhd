
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity CONTROLTX is
    generic(number_inputs : integer := 256;
            number_iwidth : integer := 8;
            number_owidth : integer := 18);
    Port ( clk : in STD_LOGIC;
           TX_DV : inout STD_LOGIC;
           d1 : in std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           d2 : in std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           d3 : in std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           d4 : in std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           SEL: in std_logic_vector(2 downto 0);
           TX_Byte: inout std_logic_vector(7 downto 0);
           q    : in signed(17 downto 0);
           TX_Done : in STD_LOGIC;
           ITX_DV : out STD_LOGIC);
end CONTROLTX;

architecture Behavioral of CONTROLTX is
signal control : std_logic:='0';
signal control2 :std_logic:='0';
begin

process(clk, TX_DV, TX_DONE)
variable x:integer:=0;
variable z:integer:=0;
variable y:integer:=0;
variable aux : std_logic_vector(7 downto 0);
  impure function dina(i : integer) return std_logic_Vector is
  begin
      return std_logic_vector(d1((i+1)*8-1 downto i*8));
  end function;
  impure function dina2(i : integer) return std_logic_Vector is
  begin
      return std_logic_vector(d2((i+1)*8-1 downto i*8));
  end function;
  impure function dina3(i : integer) return std_logic_Vector is
  begin
      return std_logic_vector(d3((i+1)*8-1 downto i*8));
  end function;
  impure function dina4(i : integer) return std_logic_Vector is
  begin
      return std_logic_vector(d4((i+1)*8-1 downto i*8));
  end function;
begin
    if (clk'event and clk='1') then
        if(TX_DV= '0')THEN
        control <= '0';
        y := 0;
        END IF;
        if(TX_DV = '1' and control<='0')THEN
         x:= x+1;
         z:= z+1;
         IF(TX_DONE = '1')THEN
            ITX_DV <= '1';
         ELSIF(y= 0)THEN
            ITX_DV <= '1';
         END IF;
       
         IF(x > 871)THEN
         x:=0;
         y:=y+1;    
         END IF;
         if(y = 1026)then
         y:=0;
         control2 <= '0';
         end if;
         --TX_BYTE <= dina(y);
           case SEL is
           when  "001" => TX_BYTE <= dina(y);
           when  "010" => TX_BYTE <= dina2(y);
           when  "011" => TX_BYTE <= dina3(y);
           when  "100" => TX_BYTE <= dina4(y);                       
           when others => null;
           end case;
           if (SEL="101")then
                case y is
                when  0 => TX_BYTE <=std_logic_vector(q(7  downto 0));
                when  1 => TX_BYTE <=std_logic_vector(q(15 downto 8));
                when  2 => aux(1 downto 0):= std_logic_vector(q(17 downto 16));
                           TX_BYTE <= aux;
                           aux:= (others => '0');                                  
                when others => null;
                end case;
           end if;
               if(z > 894000)then
               z:= 0; 
               control <= '1';
               ITX_DV  <= '0';
               end if;
         end if;
      end if; 
    end process;
end Behavioral;
