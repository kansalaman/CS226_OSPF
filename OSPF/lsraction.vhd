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


entity lsraction is
  Generic
  (
    ADDR_SIZE : integer := 12;
    PORTS : integer := 8
  );
    Port ( clk : in  STD_LOGIC;
           len : in  STD_LOGIC_VECTOR (15 downto 0);
           len_val : in  STD_LOGIC;
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
			  data_val: in STD_LOGIC;
           out1 : inout  STD_LOGIC_VECTOR (7 downto 0):= "00000000";
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
--constant ADDR_SIZE: integer :=  12;


-- Counters
type states is (IDLE, RECV, WAIT_FOR_DATA, JTER, LINSEARCH, READ_LEN, READ_ROUTER, CHECK, SENDING); -- WAIT FOR LEN AT IDLE
signal p_state, n_state: states := IDLE;
signal p_len, n_len: std_logic_vector(15 downto 0) := zero8 & "00000001";
signal p_readcounter, n_readcounter : std_logic_vector(7 downto 0) := zero8;
signal p_lsacounter, n_lsacounter: std_logic_vector(2 downto 0):= "000";
signal p_lencounter, n_lencounter: std_logic_vector(0 downto 0) := "1";
signal p_advcounter, n_advcounter: std_logic_vector(1 downto 0) := "11";
signal p_sendcounter, n_sendcounter: std_logic_vector(15 downto 0) := (others => '0');


-- Locations
signal p_loc, n_loc: std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal adv_router_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal len_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";
signal next_search_loc:  std_logic_vector(ADDR_SIZE -1 downto 0) := zero8 & "0001";

-- Storage
signal savelen: std_logic_vector(15 downto 0):= zero8 & zero8;
signal numLSAs : std_logic_vector(2 downto 0):= (others => '0');
signal routers : std_logic_vector(95 downto 0):= (others => '0');
signal entries : std_logic_vector(7 downto 0) := (others => '0');
signal get_entries : std_logic := '1';
signal advlen: std_logic_vector(15 downto 0) := (others => '0');
signal cur_router, cur_item : std_logic_vector(31 downto 0) := (others => '0');



begin

SEQ: process(clk)
begin
if (clk = '1' and clk'event) then
	p_state <= n_state;
	p_loc <= n_loc;
	p_len <= n_len;
	p_readcounter <= n_readcounter;
	p_sendcounter <= n_sendcounter;
	p_lsacounter <= n_lsacounter;
	p_advcounter <= n_advcounter;
	p_lencounter <= n_lencounter;
end if;
end process;

COMBSTATE:  process(p_state, len_val, data_val, p_len, p_advcounter, p_loc, 
		p_readcounter, numLSAs, len, p_lsacounter, get_entries, db_din,
		next_search_loc, advlen, adv_router_loc, len_loc, cur_item, p_lencounter, cur_router, 
		entries, p_sendcounter, routers)
variable lsanumber: integer := 0;
variable update : integer := 0;
variable iter: integer := 0;
variable increment: integer := 0;

begin	
	case (p_state) is 
		when IDLE =>
			if (len_val = '1') then
				n_state <= WAIT_FOR_DATA;
				savelen <= len - conv_std_logic_vector(24, 16);
				n_len <= len - conv_std_logic_vector(24, 16);
--				n_state <= RECV;
			else
				n_state <= p_state;
				savelen <= zero8 & zero8;
			end if;
		when WAIT_FOR_DATA =>
			if (data_val = '1') then
				n_state <= RECV;
				n_len <= p_len-1;	-- Have already streamed the 1st eight bits
				n_readcounter <= p_readcounter;
			else
				n_state <= p_state;
			end if;
		when RECV =>
		if (p_len = zero8  & "00000000") then
			n_state <= JTER;
			n_readcounter <= zero8;
			numLSAs <= conv_std_logic_vector(lsanumber+1, 3);
--			p_lsacounter <= numLSAs;
			n_lsacounter <= conv_std_logic_vector(lsanumber+1, 3);
			routers(32*(3-lsanumber)-24-1 downto 32*(3-lsanumber)-32) <= in1; 
			n_len <= zero8 & zero8;
		else
			n_state <= p_state;
			n_len <= p_len - 1;
			if (p_readcounter = "00001000") then
				routers(32*(3-lsanumber)-1 downto 32*(3-lsanumber)-8) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif (p_readcounter = "00001001") then
				routers(32*(3-lsanumber) -8 -1 downto 32*(3-lsanumber)-16) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif (p_readcounter = "00001010") then
				update := lsanumber +1;
				routers(32*(3-lsanumber)-16 -1 downto 32*(3-lsanumber)-24) <= in1; 
				n_readcounter <= p_readcounter + 1;
			elsif	(p_readcounter = "00001011") then
				routers(32*(3-lsanumber)-24-1 downto 32*(3-lsanumber)-32) <= in1; 
--				n_readcounter <= p_readcounter + 1;
--			elsif (p_readcounter = "00001011") then
				n_readcounter <= zero8;
				lsanumber := update;
			else
			n_readcounter <= p_readcounter+1;
			end if;
		end if;
		when JTER =>  		
		if (p_lsacounter = "000") then
				n_state <= IDLE;
				n_lsacounter <= "000";
				n_loc <= zero8 & "0001";
			else
				n_lsacounter <= p_lsacounter - 1;
				n_state <= LINSEARCH;
				cur_item <= routers((4- conv_integer(p_lsacounter))*32 -1 downto 
				(4- conv_integer(p_lsacounter))*32 -32); 
				db_read <= '1';
				n_loc <= zero8 & "0001";
				db_addr <= zero8 & "0000";
			end if;
		when LINSEARCH =>
			if (get_entries = '1') then
				get_entries <= '0';
				n_state <= p_state;
				entries <= db_din;
				db_read <= '1';
				n_loc <= next_search_loc;
			else	
				if (conv_std_logic_vector(iter, 8) = entries) then
					badreq <= '1';
					n_state <= IDLE;
					n_loc <= zero8 & "0001";
				else
					iter := increment;
--					n_loc <= next_search_loc;
					n_loc <= next_search_loc;
					len_loc <= p_loc + 14;
					adv_router_loc <= p_loc  + 6;
					db_addr <= p_loc + 14;
					db_read <= '1';
					n_state <= READ_LEN;
					n_lencounter <= "1";
				end if;
			end if;
		when READ_LEN => -- FINDING NEXT SEARCH LOCATION
			n_loc <= p_loc;
			if (p_lencounter = "0") then
				advlen(7 downto 0) <= db_din;
				db_addr <= adv_router_loc;
				n_state <= READ_ROUTER;
--				next_search_loc <= p_loc + conv_std_logic_vector((conv_integer(advlen) - 6), ADDR_SIZE);
				next_search_loc <= p_loc + 114;
				n_lencounter <= "1";
			else
				n_lencounter <= "0";
				advlen(15 downto 8) <= db_din;
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
				<= db_din;
				n_state <= p_state;
				db_addr <= adv_router_loc + (4-conv_integer(p_advcounter)) ;
			end if;
		when CHECK =>
		if (cur_item = cur_router) then
			db_addr <= p_loc;
			n_state <= SENDING;
			db_read <= '1';	
			n_loc <= p_loc;
			n_sendcounter <= (others => '0');
		else
			n_loc <= next_search_loc;
			n_state <= LINSEARCH;
			increment := iter +1;
		end if;
		when OTHERS => -- SENDING
			if (p_sendcounter = advlen -1) then
				db_read <= '0';
				db_addr <= p_loc;
				n_sendcounter <= (others => '0'); 
				next_search_loc <= zero8 & "0001";
				n_loc <= zero8 & "0001";
				if (p_lsacounter = "000") then
					n_state <= IDLE;
				else
					n_state <= JTER;
				end if;
			else
				out_val <='1';
				out1 <= db_din;
				n_loc <= p_loc;
				db_addr <= p_loc + conv_integer(p_sendcounter+1);
				n_sendcounter <= p_sendcounter +1;
				n_state <= p_state;
				next_search_loc <= next_search_loc;
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
