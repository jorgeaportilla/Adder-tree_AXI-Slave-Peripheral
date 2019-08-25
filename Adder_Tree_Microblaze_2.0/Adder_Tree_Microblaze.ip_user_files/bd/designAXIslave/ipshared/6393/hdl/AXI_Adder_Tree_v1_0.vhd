library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity AXI_rc_servo_controller_v1_0 is
	generic (
		-- Users to add parameters here
        C_S_AXI_ACLK_FREQ_HZ  : integer   := 100_000_000;
        -- AXI Parameters
        number_inputs : integer := 256;
        number_iwidth : integer := 8;
        -- User parameters ends
		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4);
	port (
		-- Ports of Axi Slave Bus Interface S00_AXI
		enable         : out std_logic_vector(7 downto 0);
		display        : out std_logic_vector(6 downto 0);
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end AXI_rc_servo_controller_v1_0;

architecture arch_imp of AXI_rc_servo_controller_v1_0 is

signal RX_DV      :std_logic;
signal dirrecived :std_logic_vector(7 downto 0);
signal q          :signed(17 downto 0) := "000000000010000000";
signal SEL        :STD_LOGIC_VECTOR(2 DOWNTO 0);
signal d3         :std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
signal d4         :std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');

component device
generic(
        number_inputs : integer := 1024;
        number_iwidth : integer := 8);
Port ( 
       clk        : in STD_LOGIC;
       RX_data    : in STD_LOGIC_VECTOR(7 downto 0);
       RX_DV      : in STD_LOGIC;      
       q          : inout signed(17 downto 0);
       d3         : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
       d4         : inout std_logic_vector(number_inputs*number_iwidth-1 downto 0):= (others => '0');
       SEL        : inout STD_LOGIC_VECTOR(2 DOWNTO 0);
       enable     : out std_logic_vector(7 downto 0);
       display    : out STD_LOGIC_VECTOR(6  downto 0));
end component;

component  axi_rc_servo_controller
    generic
        (
        -- AXI Parameters
        C_S_AXI_ACLK_FREQ_HZ  : integer   := 100_000_000;
        C_S_AXI_DATA_WIDTH : integer := 32;
        C_S_AXI_ADDR_WIDTH : integer := 9
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
      end component;
begin-- Instantiation of Axi Bus Interface S00_AXI
 AXI_control:  axi_rc_servo_controller
 generic map
   ( 
   C_S_AXI_ACLK_FREQ_HZ => C_S_AXI_ACLK_FREQ_HZ,
   C_S_AXI_DATA_WIDTH   => C_S00_AXI_DATA_WIDTH,
   C_S_AXI_ADDR_WIDTH   => C_S00_AXI_ADDR_WIDTH
   )
 port map(
    d3                             => d3,
    d4                             => d4,
    SEL                            => sel,
    q                              => q,
    RX_DV                          => RX_DV,
    dirrecived                     => dirrecived,
    S_AXI_ACLK                     => S00_AXI_ACLK, 
    S_AXI_ARESETN                  => S00_AXI_ARESETN,     
    S_AXI_AWADDR                   => S00_AXI_AWADDR,
    S_AXI_AWVALID                  => S00_AXI_AWVALID, 
    S_AXI_AWREADY                  => S00_AXI_AWREADY,  
    S_AXI_ARADDR                   => S00_AXI_ARADDR,
    S_AXI_ARVALID                  => S00_AXI_ARVALID,
    S_AXI_ARREADY                  => S00_AXI_ARREADY,
    S_AXI_WDATA                    => S00_AXI_WDATA,
    S_AXI_WSTRB                    => S00_AXI_WSTRB,
    S_AXI_WVALID                   => S00_AXI_WVALID,
    S_AXI_WREADY                   => S00_AXI_WREADY,
    S_AXI_RDATA                    => S00_AXI_RDATA,
    S_AXI_RRESP                    => S00_AXI_RRESP, 
    S_AXI_RVALID                   => S00_AXI_RVALID,  
    S_AXI_RREADY                   => S00_AXI_RREADY, 
    S_AXI_BRESP                    => S00_AXI_BRESP,  
    S_AXI_BVALID                   => S00_AXI_BVALID, 
    S_AXI_BREADY                   => S00_AXI_BREADY);

device_adder_tree_Latency: device
generic map (
            number_inputs => 256,
            number_iwidth => 8)
Port map    ( 
            clk         => S00_AXI_ACLK,
            RX_data     => dirrecived,
            RX_DV       => RX_DV,
            q           => q,
            d3          => d3,
            d4          => d4,
            sel         => sel,
            enable      => enable,
            display     => display);
end arch_imp;