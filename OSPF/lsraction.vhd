----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:30:46 05/04/2019 
-- Design Name: 
-- Module Name:    lsraction - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lsraction is
    Port ( clk : in  STD_LOGIC;
           len : in  STD_LOGIC_VECTOR (7 downto 0);
           len_val : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  data_val: in STD_LOGIC;
           out1 : inout  STD_LOGIC_VECTOR (7 downto 0);
			  badreq: out STD_LOGIC;
           out_val : out  STD_LOGIC;
			 
			 -- Memory related controls
			 -- empty : in std_logic;
			 db_read : out std_logic;
			 db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
			 db_din : in std_logic_vector(7 downto 0);
			 db_write : out std_logic;
			 db_dout : out std_logic_vector(7 downto 0);
			 db_busy_read : in std_logic;
			 db_busy_write : in std_logic);
			  
			 
end lsraction;

architecture Behavioral of lsraction is

-- Constants
constant zero8: std_logic_vector(7 downto 0) := "00000000";
constant eight: std_logic_vector(7 downto 0) := "00001000";
constant ADDR_SIZE: integer :=  12;


-- Counters
type states is (IDLE, RECV, WAIT_FOR_DATA, JTER, LINSEARCH, READ_LEN, READ_ROUTER, SENDING); -- WAIT FOR LEN AT IDLE
signal p_state, n_state: states := IDLE;
signal p_len, n_len: std_logic_vector(15 downto 0) := zero8 & "00000001";
signal p_readcounter, n_readcounter : std_logic_vector(7 downto 0) := zero8;
signal p_lsacounter, n_lsacounter: std_logic_vector(2 downto 0):= "000";
signal p_lencounter, n_lencounter: std_logic_vector(0 downto 0) := "1";
signal p_advtcounter, n_advtcouner: std_logic_vector(1 downto 0) := "11";
signal p_sendcounter, n_sendcounter: std_logic_vector(15 downto 0) := (others => '0')

-- Locations
signal p_loc, n_loc: std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal adv_router_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal len_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal next_search_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";

-- Storage
signal savelen: std_logic_vector(15 downto 0):= zero8 & zero8;
signal numLSAs : std_logic_vector(2 downto 0):= (others => '0');
signal routers : std_logic_vector(95 downto 0);
signal entries : std_logic_vector(7 downto 0);


begin

SEQ: process(clk)
begin
if (clk = '1' and clk'event) then
	p_state <= n_state;
	p_loc <= n_loc;
	p_len <= n_len;
	p_readcounter <= n_readcounter;
	p_
end if;
end process;

COMBSTATE:  process(p_state, len_val)
variable lsanumber: integer := 0;
variable iter: integer := 0;
variable increment: integer := 0;

begin
	case (p_state) is 
		when IDLE =>
			if (len_val = '1') then
				n_state <= WAIT_FOR_DATA;
				savelen <= len - conv_std_logic_vector(24, 16);
				p_len <= len - conv_std_logic_vector(24, 16);
				n_len <= len - conv_std_logic_vector(24, 16);
--				n_state <= RECV;
			else
				n_state <= p_state;
				savelen <= zero8 & zero8;
			end if;
		when WAIT_FOR_DATA =>
			if (data_val = '1') then
				n_state <= RECV;
				n_len <= p_len - eight;	-- Have already streamed the 1st eight bits
			else
				n_state <= p_state;
			end if;
		when RECV =>
		if (p_len = zero8 & eight) then
			n_state <= JTER;
			n_readcounter <= zero8;
			numLSAs <= conv_integer(lsanumber);
			p_lsacounter <= numLSAs;
			n_lsacounter <= numLSAs;
		else
			n_state <= p_state;
			n_len <= p_len - eight;
			if (p_readcounter = "00000100") then
				routers(32*(3-lsanumber)-1 downto 32*(3-lsanumber)-8) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif (p_readcounter = "00000101") then
				routers(32*(3-lsanumber) -8 -1 downto 32*(3-lsanumber)-16) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif (p_readcounter = "00000110") then
				routers(32*(3-lsanumber)-16 -1 downto 32*(3-lsanumber)-24) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif	(p_readcounter = "00000111") then
				routers(32*(3-lsanumber)-24-1 downto 32*(3-lsanumber)-32) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif (p_readcounter = "00001011") then
				n_readcounter <= zero8;
				lsanumber := lsanumber +1;
			else
			n_readcounter <= p_readcounter +1;
			end if;
		end if;
		when JTER =>  		
		if (p_lsacounter = "000") then
				n_state <= IDLE;
				n_lsacounter <= "000";
			else
				n_lsacounter <= p_lsacounter - 1;
				n_state <= LINSEARCH;
				cur_item <= routers(conv_integer(p_lsacounter)*32 -1 downto conv_integer(p_lsacounter)*32 -32); 
				db_read <= '1';
				n_loc <= zero8 & "0000";
				db_addr <= zero8 & "0000";
			end if;
		when LINSEARCH =>
			if (get_entries = '1') then
				get_entries <= '0';
				n_state <= p_state;
				entries <= db_din;
				db_read <= '0';
				n_loc <= next_search_loc;
			else	
				if (conv_std_logic_vector(iter, 8) = entries) then
					badreq <= '1';
					n_state <= IDLE;
				else
					iter := increment;
--					n_loc <= next_search_loc;
					n_loc <= p_loc;
					len_loc <= p_loc + 14;
					adv_router_loc <= p_loc  + 10;
					db_addr <= p_loc + 14;
					db_read <= '1';
					n_state <= READ_LEN;
					n_lencounter <= "1";
				end if;
			end if;
		when READLEN => -- FINDING NEXT SEARCH LOCATION
			n_loc <= p_loc;
			if (p_lencounter = "0") then
				advlen(15 downto 8) <= db_din;
				db_addr <= adv_router_loc;
				n_state <= READ_ROUTER;
				next_search_loc <= p_loc + conv_std_logic_vector((conv_integer(advlen) - 6), ADDR_SIZE);
				n_lencounter <= "1";
			else
				n_lencounter <= "0";
				advlen(7 downto 0) <= db_din;
				n_state <= p_state;
				db_addr <= p_loc + 15;
			end if;
		when READ_ROUTER => --
			n_loc <= p_loc;
			if (p_advcounter = "00") then
				cur_router(conv_integer(p_advcounter)*8 + 7 downto  conv_integer(p_advcounter)*8)
				<= db_din;
--				db_addr <= ;
				db_read <= '0';
				n_state <= CHECK;
				n_advcounter <= "11";
			else
				n_advcounter <= p_advcounter -1;
				cur_router(conv_integer(p_advcounter)*8 + 7 downto conv_integer(p_advcounter)*8)
				n_state <= p_state;
				db_addr <= adv_router_loc + (4-conv_integer(p_advcounter)) ;
			end if;
		when CHECK =>
		if (cur_item = cur_router) then
			db_addr <= p_loc;
			n_state <= SENDING;
			db_read <= '1';
			n_loc <= zero8 & "0001";
			n_sendcounter <= (others => '0');
		else
			n_loc <= p_loc + next_search_loc;
			n_state <= LINSEARCH;
			increment := iter +1;
		end if;
		when OTHERS => -- SENDING
			if (p_sendcounter = advlen -1) then
				n_sendcounter <= (others => '0'); 
				if (p_lsacounter = "000")
					n_state <= IDLE;
				else
					n_state <= JTER;
				end if;
			else
				out_val <='1';
				out1 <= db_din;
				n_sendcounter <= p_sendcounter +1;
			end if;
				
	end case;
end process;
--        0                   1                   2                   3
--        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |   Version #   |       3       |         Packet length         |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                          Router ID                            |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                           Area ID                             |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |           Checksum            |             AuType            |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                       Authentication                          |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                       Authentication                          |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                          LS type                              |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                       Link State ID                           |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                     Advertising Router                        |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                              ...                              |


end Behavioral;

