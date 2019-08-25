library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity commanddecoder is
    generic(number_inputs : integer := 256;
            number_iwidth : integer := 8;
            number_owidth : integer := 18);
    Port ( clk   : in STD_LOGIC;
           RX_DV : IN STD_LOGIC;
           TX_DV : inout std_logic;
           RXByte: in STD_LOGIC_VECTOR(7 downto 0);
           d1    : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           d2    : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0);
           SEL   : inout STD_LOGIC_VECTOR(2 downto 0));
end commanddecoder;

architecture Behavioral of commanddecoder is
begin

process (clk, RX_DV,RXByte)
variable x: integer := 0;
variable y: integer := 0;
variable z: integer := 0;
variable dd  : std_logic_vector(number_inputs*number_iwidth-1 downto 0); 
variable A:  std_logic_vector(1 downto 0):="00";

  
begin
if (clk'event and clk='1' and RX_DV='1')THEN
--Selección de la Operación a ejecutar dada por el Host
IF(x = 0 and RXByte ="11111111")THEN --BRAM1
--vector
A := "01";
TX_DV<= '0';
ELSIF(x = 0 and RXByte ="11111110")THEN --BRAM2
--decodor vector
A := "10";
TX_DV<= '0';
ELSIF(x = 0) THEN
A := "00";
END IF;

IF(x>0 and X<258)THEN
   y:=x-1;
   IF(A = "10")THEN
   d2((y+1)*8-1 downto y*8) <= RXByte;
   ELSE
   d1((y+1)*8-1 downto y*8) <= RXByte;
   END IF;   
 END IF;
 x:=x+1;
 IF (x = 257) THEN
   x:=0;
   y:=0;
 END IF;

    IF(X = 1 and RXByte ="11111100")THEN --BRAM1 252
    SEL<="001";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X = 1  and RXByte ="11111101")THEN --BRAM2 253
    SEL<="010";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X = 1 and RXByte ="11111000")THEN --BRAM1+BRAM2  248
    SEL<="011";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X = 1 and RXByte ="11111001")THEN --BRAM1+BRAM2/2  249
    SEL<="100";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X= 1 and RXByte ="11111010")THEN --DM 250
    SEL<="101";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X= 1 and RXByte ="11111011")THEN --EM 251
    SEL<="110";
    TX_DV<= '1';
    x:= 0;
    y:= 0;
    ELSIF(X = 1 and RXByte ="00000001")THEN --ERRASE
    TX_DV<= '0';
    x:= 0;
    y:= 0;
END IF;
END IF;
end process;
end Behavioral;
