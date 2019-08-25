library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library axi_rc_servo_controller;
use axi_rc_servo_controller.all;

entity axi_rc_servo_controller is
    generic
        (
        -- AXI Parameters
        C_S_AXI_ACLK_FREQ_HZ  : integer   := 100_000_000;
        C_S_AXI_DATA_WIDTH : integer := 32;
        C_S_AXI_ADDR_WIDTH : integer := 9;  
        number_inputs : integer := 256;
        number_iwidth : integer := 8
        );
    port
        (
        d3                             : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
        d4                             : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
        SEL                            : inout STD_LOGIC_VECTOR(2 DOWNTO 0);
        q                              : inout signed(17 downto 0);
        RX_DV                          : out std_logic;
        dirrecived                     : out std_logic_vector(7 downto 0);     
        S_AXI_ACLK                     : in  std_logic;
        S_AXI_ARESETN                  : in  std_logic;
        S_AXI_AWADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_AWVALID                  : in  std_logic;
        S_AXI_AWREADY                  : out std_logic;
        S_AXI_ARADDR                   : in  std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
        S_AXI_ARVALID                  : in  std_logic;
        S_AXI_ARREADY                  : out std_logic;
        S_AXI_WDATA                    : in  std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_WSTRB                    : in  std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
        S_AXI_WVALID                   : in  std_logic;
        S_AXI_WREADY                   : out std_logic;
        S_AXI_RDATA                    : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        S_AXI_RRESP                    : out std_logic_vector(1 downto 0);
        S_AXI_RVALID                   : out std_logic;
        S_AXI_RREADY                   : in  std_logic;
        S_AXI_BRESP                    : out std_logic_vector(1 downto 0);
        S_AXI_BVALID                   : out std_logic;
        S_AXI_BREADY                   : in  std_logic
      );
end entity axi_rc_servo_controller;

------------------------------------------------------------------------------
-- Architecture section
------------------------------------------------------------------------------

architecture IMP of axi_rc_servo_controller is
  
-- Type declarations
type main_fsm_type is (reset, idle, read_transaction_in_progress, write_transaction_in_progress, complete);

-- Signal declarations
signal servo_controller_clk : std_logic;
signal servo_controller_rst : std_logic;
signal local_address : integer range 0 to 2**C_S_AXI_ADDR_WIDTH;
signal local_address_valid : std_logic;
signal manual_mode_control_register : std_logic_vector(31 downto 0);
signal senddata : std_logic_vector(31 downto 0);
signal senddata2 : std_logic_vector(31 downto 0);
signal manual_mode_data_register : std_logic_vector(31 downto 0);
signal manual_mode_control_register_address_valid : std_logic;
signal manual_mode_data_register_address_valid : std_logic;
signal combined_S_AXI_AWVALID_S_AXI_ARVALID : std_logic_vector(1 downto 0);
signal Local_Reset : std_logic;
signal current_state, next_state : main_fsm_type;
signal write_enable_registers : std_logic;
signal send_read_data_to_AXI : std_logic;

begin

Local_Reset <= not S_AXI_ARESETN;
combined_S_AXI_AWVALID_S_AXI_ARVALID <= S_AXI_AWVALID & S_AXI_ARVALID;

state_machine_update : process (S_AXI_ACLK)
begin
    if S_AXI_ACLK'event and S_AXI_ACLK = '1' then
        if Local_Reset = '1' then
            current_state <= reset;
        else
            current_state <= next_state;
        end if;
    end if;
end process;

state_machine_decisions : process (	current_state, combined_S_AXI_AWVALID_S_AXI_ARVALID, S_AXI_ARVALID, S_AXI_RREADY, S_AXI_AWVALID, S_AXI_WVALID, S_AXI_BREADY, local_address, local_address_valid)
begin
    S_AXI_ARREADY <= '0';
    S_AXI_RRESP <= "--";
    S_AXI_RVALID <= '0';
    S_AXI_WREADY <= '0';
    S_AXI_BRESP <= "--";
    S_AXI_BVALID <= '0';
    S_AXI_WREADY <= '0';
    S_AXI_AWREADY <= '0';
    write_enable_registers <= '0';
    send_read_data_to_AXI <= '0';
   
	case current_state is
		when reset =>
			next_state <= idle;

		when idle =>
			next_state <= idle;
			case combined_S_AXI_AWVALID_S_AXI_ARVALID is
				when "01" => next_state <= read_transaction_in_progress;
				when "10" => next_state <= write_transaction_in_progress;
				when others => NULL;
			end case;
		
		when read_transaction_in_progress =>
            next_state <= read_transaction_in_progress;
            S_AXI_ARREADY <= S_AXI_ARVALID;
            S_AXI_RVALID <= '1';
            S_AXI_RRESP <= "00";
            send_read_data_to_AXI <= '1';
            if S_AXI_RREADY = '1' then
                next_state <= complete;
            end if;


		when write_transaction_in_progress =>
            next_state <= write_transaction_in_progress;
			write_enable_registers <= '1';
            S_AXI_AWREADY <= S_AXI_AWVALID;
            S_AXI_WREADY <= S_AXI_WVALID;
            S_AXI_BRESP <= "00";
            S_AXI_BVALID <= '1';
			if S_AXI_BREADY = '1' then
			    next_state <= complete;
            end if;

		when complete => 
			case combined_S_AXI_AWVALID_S_AXI_ARVALID is
				when "00" => next_state <= idle;
				when others => next_state <= complete;
			end case;
		
		when others =>
			next_state <= reset;
	end case;
end process;


send_data_to_AXI_RDATA : process (send_read_data_to_AXI, local_address, manual_mode_control_register, manual_mode_data_register, d3, d4)
variable dd   : std_logic_vector(31 downto 0) := (others => '0');
variable dd2   : std_logic_vector(31 downto 0);
variable index1, index2 : integer :=0;
begin
    S_AXI_RDATA <= (others => '-');
    if (local_address_valid = '1' and send_read_data_to_AXI = '1') then   
    
        index1 := ((local_address-19)*8)-1;
        case (local_address) is
            when 0 =>                S_AXI_RDATA <= senddata;
            when 4 =>                S_AXI_RDATA <= manual_mode_data_register;     
            when 5 =>                S_AXI_RDATA <= "00000000000000000000000000000011";
            when 6 =>                S_AXI_RDATA <= "00000000000000000000000000000100";
            when 7 =>                S_AXI_RDATA <= "00000000000000000000000000000101";   
            when 8 =>                S_AXI_RDATA <= "00000000000000000000000000000110";   
            when 9 =>                dd(7 downto 0) := d3(63 downto 56);
                                     S_AXI_RDATA <= dd;   
            when 10 =>               dd(7 downto 0) := d3(7 downto 0);
                                     S_AXI_RDATA <= dd;
            when 11 =>               dd(7 downto 0) := d3(15 downto 8);
                                     S_AXI_RDATA <= dd;
            when 12 =>               dd(7 downto 0) := d3(23 downto 16);
                                     S_AXI_RDATA <= dd;
--          when 20 =>               index1 := ((local_address-19)*8)-1;     
--                                   dd(7 downto 0) := d3(index1 downto index1-7);
--                                   S_AXI_RDATA <= dd;   
            when 20 to 24 =>         S_AXI_RDATA <= senddata2;
            when 25     =>           S_AXI_RDATA <= d3 (((25-19)*8)-1 downto ((25-19)*8)-8)       ;              
            when others =>           NULL;
        end case;
        
--    if(local_address = 9)then
                 
--     end if;
       
--       if(local_address < 26 and local_address > 19) then
--       for i in 20 to 25 loop
--            if(local_address = i)then
--            dd(7 downto 0) := d3(((local_address-19)*8)-1 downto ((local_address-19)*8)-8);       
--            end if;    
--       end loop;   
--       S_AXI_RDATA <= dd;
--       end if;
--       for j in 300 to 556 loop
--            if(j = local_address)then
--                dd2 := (others => '0');
--                dd2(7 downto 0) := d4(((j-299)*8)-1 downto ((j-299)*8)-8);
--                S_AXI_RDATA <= dd2;       
--            end if;    
--       end loop;   
    end if;
end process;

local_address_capture_register : process (S_AXI_ACLK)
begin

   if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
        if Local_Reset = '1' then
            local_address <= 0;
        else
            if local_address_valid = '1' then
                case (combined_S_AXI_AWVALID_S_AXI_ARVALID) is
                    when "10" => local_address <= to_integer(unsigned(S_AXI_AWADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
                    when "01" => local_address <= to_integer(unsigned(S_AXI_ARADDR(C_S_AXI_ADDR_WIDTH-1 downto 0)));
                    when others => local_address <= local_address;
                end case;
            end if;
        end if;
   end if;
end process;


manual_mode_control_register_process : process (S_AXI_ACLK, sel,local_address)
variable dd   : std_logic_vector(31 downto 0);
begin
if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
    if Local_Reset = '1' then
        manual_mode_control_register <= (others => '0');
    else
        RX_DV <= '0';
        if (manual_mode_control_register_address_valid = '1') then
            manual_mode_control_register <=  S_AXI_WDATA;
            senddata <= std_logic_vector(to_signed(to_integer(q),32));
            if (sel = "101")then
               senddata <= std_logic_vector(to_signed(to_integer(q),32));
--            else if(sel=  "011") then
--                dd := (others => '0');
--                dd(7 downto 0) := d3(7 downto 0);
--                senddata <= dd;
--            else if(sel=  "100") then
--                dd := (others => '0');
--                dd(7 downto 0) := d4(7 downto 0);
--                senddata <= dd;
            end if;
--            end if;            
--            end if;
            dirrecived  <= manual_mode_control_register(7 downto 0);
            RX_DV <= '1';
                      
            ----$$ pruebaq
            if(local_address > 19)then
                senddata2 <= d3(((local_address-19)*8)-1 downto ((local_address-19)*8)-8); 
            end if;
        end if;
    end if;
end if;
end process;

manual_mode_data_register_process : process (S_AXI_ACLK)
begin
   if (S_AXI_ACLK'event and S_AXI_ACLK = '1') then
		if Local_Reset = '1' then
			manual_mode_data_register <= (others => '0');
		else
			if (manual_mode_data_register_address_valid = '1') then
				manual_mode_data_register <= std_logic_vector(to_signed(to_integer(q),32));
			end if;
		end if;
   end if;
end process;

address_range_analysis : process (local_address, write_enable_registers)
begin
	manual_mode_control_register_address_valid <= '0';
	manual_mode_data_register_address_valid <= '0';
    local_address_valid <= '1';
    
    if write_enable_registers = '1' then
        case (local_address) is
            when 0 => manual_mode_control_register_address_valid <= '1';
            when 4 => manual_mode_data_register_address_valid <= '1';
            when others => local_address_valid <= '0';
        end case;
    end if;
end process;

end IMP;