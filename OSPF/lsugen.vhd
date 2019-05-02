----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity lsugen is
  Generic
  (
    ADDR_SIZE : integer := 12;
    PORTS : integer := 8
  );
  Port
  (
	 
	 -- State determinatation
    n1state : in std_logic_vector(2 downto 0);
	 n2state : in std_logic_vector(2 downto 0);
	 n3state : in std_logic_vector(2 downto 0);
	 n4state : in std_logic_vector(2 downto 0);
	 
	 n5state : in std_logic_vector(2 downto 0);
	 n6state : in std_logic_vector(2 downto 0);
	 n7state : in std_logic_vector(2 downto 0);
	 n8state : in std_logic_vector(2 downto 0);
	 
	 
	 -- Neighbour's IP 
	 neighbour1: in std_logic_vector(31 downto 0);
	 neighbour2: in std_logic_vector(31 downto 0);
	 neighbour3: in std_logic_vector(31 downto 0);
	 neighbour4: in std_logic_vector(31 downto 0);
	 
	 neighbour5: in std_logic_vector(31 downto 0);
	 neighbour6: in std_logic_vector(31 downto 0);
	 neighbour7: in std_logic_vector(31 downto 0);
	 neighbour8: in std_logic_vector(31 downto 0);
	 
	 -- Flooding related controls
	 out_val: out std_logic := '0';
	 out1: out std_logic_vector(7 downto 0):= (others => '0');
	 negIface: out std_logic_vector(7 downto 0) := (others => '0');
	 
	 -- Memory related controls
	 clk : in std_logic;
    empty : in std_logic;
    q_din : in std_logic_vector(7 downto 0);
    q_read : out std_logic;
    db_read : out std_logic;
    db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
    db_din : in std_logic_vector(7 downto 0);
    db_write : out std_logic;
    db_dout : out std_logic_vector(7 downto 0);
    fl_val : out std_logic;
    fl_out : out std_logic_vector(7 downto 0);
    fl_port : out std_logic_vector(7 downto 0)
  );
end lsugen;


-- SEQUENCE of events -> 
--1. Every MinLSInterval check if some value has been updated.
--2. Write the updated packet in the RAM and simultaneously map
--	the 8 bits at a time to the output for flooding.


architecture Behavioral of lsugen is
constant zero8: std_logic_vector(7 downto 0) := (others => '0');
constant MinLSInterval : std_logic_vector(5 downto 0) := "111111";
constant myRouterID: std_logic_vector(31 downto 0) := (others => '0'); -- Link state ID
signal len: std_logic_vector(15 downto 0); -- Combinational mapping

signal p_uptimer, n_uptimer: std_logic_vector(5 downto 0) := MinLSInterval;

-- memory
signal p_loc : std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '0');


--        0                   1                   2                   3
--        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |            LS age             |     Options   |       1       |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                        Link State ID                          |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                     Advertising Router                        |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |             LS sequence number (read and update               |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |         LS checksum           |         length (TBU)          |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |    0    |V|E|B|        0      |            # links            |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                          Link ID                              |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                         Link Data                             |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |     Type      |     # TOS     |        TOS 0 metric           |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |      TOS      |        0      |            metric             |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                              ...                              |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |      TOS      |        0      |            metric             |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                          Link ID                              |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                         Link Data                             |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                              ...                              |

begin

SEQWrite: process (clk)
	begin
		if (clk='1' and clk'event) then
			p_uptimer <= n_uptiemr;
		end if;
	end process;


COMBNEWADJ: process(n1state, n2state, n3state, n3state,
				n4state, n5state, n6state, n7state, n8state)
	begin
	end process;
--COMB: maptoseq(din
end Behavioral;

