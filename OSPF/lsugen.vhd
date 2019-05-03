----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

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
    db_read : out std_logic;
    db_addr : out std_logic_vector(ADDR_SIZE-1 downto 0);
    db_din : in std_logic_vector(7 downto 0);
    db_write : out std_logic;
    db_dout : out std_logic_vector(7 downto 0);
	 db_busy_read : in std_logic;
	 db_busy_write : in std_logic;
    fl_val : out std_logic;
    fl_out : out std_logic_vector(7 downto 0);
    fl_port : out std_logic_vector(7 downto 0)
  );
end lsugen;


-- SEQUENCE of events -> 
--1. Every MinLSInterval check if some value has been updated.
--2. Write the updated packet in the RAM and simultaneously map
--	the 8 bits at a time to the output for flooding.
-- Update the packet with new values in comparison to it's current DB or my states?


architecture Behavioral of lsugen is
constant zero8: std_logic_vector(7 downto 0) := (others => '0');
constant MinLSInterval : std_logic_vector(5 downto 0) := "111111";
constant myRouterID: std_logic_vector(31 downto 0) := (others => '0'); -- Link state ID
signal newlen: std_logic_vector(15 downto 0); -- Combinational mapping
signal num: std_logic_vector(3 downto 0);
constant metric : std_logic_vector(15 downto 0) := zero8 & "00000011";
signal p_adj, in_adj, n_adj : std_logic_vector(7 downto 0) := zero8;
constant temp : std_logic_vector(7 downto 0) := "0000001";

signal p_uptimer, n_uptimer: std_logic_vector(5 downto 0) := MinLSInterval;
signal p_adstimer, n_adstimer: std_logic_vector(6 downto 0) := (others => '0');
signal p_headtimer, n_headtimer : std_logic_vector(4 downto 0) := "11000";
signal p_readtimer, n_readtimer : std_logic_vector(4 downto 0) := "11000";

signal p_seqnum, n_seqnum: STD_LOGIC_VECTOR(31 downto 0);
-- memory
constant def_loc: std_logic_vector(11 downto 0) := zero8 & "0001";
signal p_loc : std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '0');
signal n_loc : std_logic_vector(ADDR_SIZE-1 downto 0) := (others => '0');
signal cur_data: std_logic_vector(7 downto 0) := (others => '0');

signal lsdbheader: std_logic_vector(191 downto 0) := (others => '0');
type states is (INIT, WAITING, READ_HEADER, SEND_HEADER , SENDING_ADS);
signal p_state, n_state : states := INIT;
signal act_on : std_logic_vector(7 downto 0) := zero8;
signal lsacontent : std_logic_vector(95 downto 0) := zero8 & zero8 & zero8 & zero8 &
																	 zero8 & zero8 & zero8 & zero8 &
																	 "00000011" & zero8 & zero8;
signal served: std_logic_vector(7 downto 0);


--        0                   1                   2                   3
--        0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |            LS age             |     Options   |       1       |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                        Link State ID                          |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |                     Advertising Router                        |
--       +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
--       |             LS sequence number (read and update)              |
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
component numones is
	Port ( in1 : in  std_logic_vector(7 downto 0);
		    out1: out std_logic_vector(3 downto 0)
			);
end component;
signal g1: std_logic := act_on(0) and not served(0);
signal g2: std_logic := (act_on(1) and not (served(1)));
signal g3: std_logic := (act_on(2) and not (served(2)));
signal g4: std_logic := (act_on(3) and not (served(3)));
signal g5: std_logic := (act_on(4) and not (served(4)));
signal g6: std_logic := (act_on(5) and not (served(5)));
signal g7: std_logic := (act_on(6) and not (served(6)));
signal g8: std_logic := (act_on(7) and not (served(7)));

begin
NUM1: numones port map( act_on, num);
newlen <= conv_std_logic_vector(192 + (conv_integer(num) * 96), 16); 

SEQ: process(clk)
	begin
		if (clk = '1' and clk'event) then
			p_adj <= in_adj;
			p_seqnum <= n_seqnum;
			p_readtimer <= n_readtimer;
			p_loc <= n_loc;
			p_adj <= n_adj;
			p_sendtimer <= n_sendtimer;
			p_uptimer <= n_uptimer;
		end if;
	end process;

COMBSTATE: process(p_state)
variable msb, lsb: integer;
begin
case p_state is
	when INIT =>
			db_read <= '1';
			db_addr <= p_loc;
			n_loc <= p_loc + 1;
			n_state <= READ_HEADER;

	when READ_HEADER =>
	if (p_readtimer = "00000") then
		n_state <= WAITING;
		n_seqnum <= lsdbheader(95 downto 64);
		n_readtimer <= "10100";
		db_read <= '0';
		db_addr <= p_loc;
		n_loc <= "000000000001";
	else
		n_state <= p_state;
		msb := conv_integer(p_readtimer)*8 - 1;
		lsb := msb - 7;
		db_addr <= p_loc;
		n_loc <= p_loc + 1;
		lsdbheader(msb downto lsb) <= db_din;
	end if;

	when WAITING =>
		
		if (p_uptimer = "00000") then
			if (p_adj = in_adj) then
				n_state <= p_state;
				n_uptimer <= MinLSInterval;
			else
				if (db_busy_write = '1') then
					n_state <= p_state;
				else
					n_adj <= in_adj;
					act_on <= in_adj;
					n_state <= SEND_HEADER;
					n_uptimer <= MinLSInterval;
					n_seqnum <= p_seqnum +1;
				end if;
			end if;
		else 
			n_adj <= p_adj;
			n_state <= p_state;
			n_uptimer <= p_uptimer -1;
		end if;
	when SEND_HEADER => -- SENDING_HEADER
		msb:= conv_integer(p_headtimer) * 8 -1;
		lsb:= msb-7;
		if (p_headtimer = "00000000") then
			n_state <= SENDING_ADS;
			n_headtimer <= "11000";
			out_val <= '1';
			out1 <= "00000000";
		else
			out_val <= '1';
			if (p_headtimer = "01100") then
				out1 <= p_seqnum(31 downto 24);
			elsif (p_headtimer = "01011") then 
				out1 <= p_seqnum (23 downto 16);
			elsif (p_headtimer = "01010") then
				out1 <= p_seqnum (15 downto 8);
			elsif (p_headtimer = "01001") then
				out1 <= p_seqnum(7 downto 0);
			elsif (p_seqnum = "00110") then
				out1	<= newlen(15 downto 8);
			elsif (p_seqnum = "00110") then
				out1 <= newlen(7 downto 0);
			elsif (p_seqnum = "00010") then
				out1 <= "00000000";
			elsif (p_seqnum = "00001") then
				out1 <= "0000" & num;
			else
				out1 <= lsdbheader(msb downto lsb);
			end if;
		end if;
	when others => -- SENDING LINKSTATE CONTENT
		if (conv_integer(p_adstimer)*8 = conv_integer(newlen)) then
			n_state <= WAITING;
			n_adstimer <= "0000000";
			out_val <= '0';
		else
			out1_val <='1';
			if (p_adstimer = "0000001") then
				if (g1 = '1') then
					out1<= neigh1(31 downto 24);
				elsif (g2 = '1') then
					out1<=neigh2 (31 downto 24);
		  elsif (g3 = '1') then
				out1<=neigh3 (31 downto 24);
		  elsif (g4 = '1') then
				out1<=neigh4 (31 downto 24);
		  elsif (g5 = '1') then
				out1<=neigh5 (31 downto 24);
		  elsif (g6 = '1') then
				out1<=neigh6 (31 downto 24);
		  elsif (g7 = '1') then
				out1<=neigh7 (31 downto 24);	
			elsif (g8 = '1') then
				out1 <= neigh8(31 downto 24);
				end if;
			elsif (p_adstimer = "0000010") then
				if (g1 = '1') then
					out1<= neigh1(23 downto 16);
				elsif (g2 = '1') then
					out1<=neigh2(23 downto 16);
		  elsif (g3 = '1') then
				out1<=neigh3(23 downto 16);
		  elsif (g4 = '1') then
				out1<=neigh4(23 downto 16);
		  elsif (g5 = '1') then
				out1<=neigh5(23 downto 16);
		  elsif (g6 = '1') then
				out1<=neigh6(23 downto 16);
		  elsif (g7 = '1') then
				out1<=neigh7(23 downto 16);	
		  elsif (g8 = '1') then
				out1 <= neigh8(23 downto 16);
		end if;	
	elsif (p_adstimer = "0000011") then
		  if (g1 = '1') then
					out1<= neigh1(15 downto 8);
		  elsif (g2 = '1') then
					out1<=neigh2(15 downto 8);
		  elsif (g3 = '1') then
				out1<=neigh3(15 downto 8);
		  elsif (g4 = '1') then
				out1<=neigh4(15 downto 8);
		  elsif (g5 = '1') then
				out1<=neigh5(15 downto 8);
		  elsif (g6 = '1') then
				out1<=neigh6(15 downto 8);
		  elsif (g7 = '1') then
				out1<=neigh7(15 downto 8);	
		  elsif (g8 = '1') then
				out1 <= neigh8(15 downto 8);
		  end if;
	  elsif (p_adstimer = "0000100") then
		  if (g1 = '1') then
				out1<= neigh1(7 downto 0);
		  elsif (g2 = '1') then
				out1<=neigh2(7 downto 0);
		  elsif (g3 = '1') then
				out1<=neigh3(7 downto 0);
		  elsif (g4 = '1') then
				out1<=neigh4(7 downto 0);
		  elsif (g5 = '1') then
				out1<=neigh5(7 downto 0);
		  elsif (g6 = '1') then
				out1<=neigh6(7 downto 0);
		  elsif (g7 = '1') then
				out1<=neigh7(7 downto 0);	
		  elsif (g8 = '1') then
				out1 <= neigh8(7 downto 0);
		  end if;
	elsif (p_sendtimer
	else
	out1 <= 
	end if;
	end case;
					
end process;

SEQWrite: process (clk)
	begin
		if (clk='1' and clk'event) then
			p_uptimer <= n_uptimer;
		end if;
	end process;
COMBNEWADJ1: process(n1state)
	begin
	if (n1state = "111") then
		in_adj(0) <= '1';
	else
		in_adj(0) <= '0';
	end if;
	end process;

COMBNEWADJ2: process(n2state)
	begin
	if (n2state = "111") then
		in_adj(1) <= '1';
	else
		in_adj(1) <= '0';
	end if;
	end process;

COMBNEWADJ3: process(n3state)
	begin
	if (n3state = "111") then
		in_adj(2) <= '1';
	else
		in_adj(2) <= '0';
	end if;
	end process;

COMBNEWADJ4: process(n4state)
	begin
	if (n4state = "111") then
		in_adj(3) <= '1';
	else
		in_adj(3) <= '0';
	end if;
	end process;
	
COMBNEWADJ5: process(n5state)
	begin
	if (n5state = "111") then
		in_adj(4) <= '1';
	else
		in_adj(4) <= '0';
	end if;
	end process;
	
COMBNEWADJ6: process(n6state)
	begin
	if (n6state = "111") then
		in_adj(5) <= '1';
	else
		in_adj(5) <= '0';
	end if;
	end process;
	
COMBNEWADJ7: process(n7state)
	begin
	if (n7state = "111") then
		in_adj(6) <= '1';
	else
		in_adj(6) <= '0';
	end if;
	end process;
	
COMBNEWADJ8: process(n8state)
	begin
	if (n8state = "111") then
		in_adj(7) <= '1';
	else
		in_adj(7) <= '0';
	end if;
	end process;

end Behavioral;
