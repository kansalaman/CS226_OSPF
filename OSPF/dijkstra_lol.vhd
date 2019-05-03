----------------------------------------------------------------------------------
-- Company: AC/DC
-- Engineer: Saksham Goel
-- 
-- Create Date:    20:15:21 04/26/2019 
-- Module Name:    Dijkstra
-- Project Name:   OSPF
-- Description: 
--
-- Dependencies: 
--
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

-- ROUTER INDEX = "000000", i.e., it's own LSA is in the beginning
entity Dijkstra is
	Generic 
	( 
		PORTS : integer := 8;
		NS : integer := 6;
		CS : integer := 6;
		NODES_SIZE : integer := 6;
		ADDR_SIZE : integer := 12
	);	  
    Port 
    ( 
    	router_id : in STD_LOGIC_VECTOR(NS-1 downto 0);
    	db_read : in STD_LOGIC := '0';
    	db_din : in STD_LOGIC_VECTOR(7 downto 0);
    	db_addr : in STD_LOGIC_VECTOR(ADDR_SIZE - 1 downto 0);
    	rdb_write : out STD_LOGIC := '0';
    	rdb_dout : out STD_LOGIC_VECTOR(7 downto 0);
    	rdb_addr : out STD_LOGIC_VECTOR(ADDR_SIZE - 1 downto 0);
		enable : in  STD_LOGIC := '0';
		done : out STD_LOGIC := '1';
		help : out STD_LOGIC_VECTOR(PORTS-1 downto 0) := (others => '0');
		clk : in STD_LOGIC
	);
end Dijkstra;

architecture Behavioral of Dijkstra is

component Comparator is
	Generic 
	( 
		NS : integer := 6;
		CS : integer := 6;
		NODES_SIZE : integer := 6
	);	  
    Port 
    (
    	indices : in STD_LOGIC_VECTOR(((2 ** NODES_SIZE)*NS) - 1 downto 0);
    	costs : in STD_LOGIC_VECTOR(((2 ** NODES_SIZE)*CS) - 1 downto 0);
    	out_index : out STD_LOGIC_VECTOR((NS - 1) downto 0);
    	out_cost : out STD_LOGIC_VECTOR((CS - 1) downto 0)
    );
end component;

--Constants
constant MAX_NODES : integer := 2 ** NODES_SIZE;
constant MAX_COST : integer := 2 ** CS;

constant zeroN: STD_LOGIC_VECTOR(NS-1 downto 0) := (others => '0');
constant oneN: STD_LOGIC_VECTOR(NS-1 downto 0) := (others => '1');

constant zeroC: STD_LOGIC_VECTOR(CS-1 downto 0) := (others => '0');
constant oneC: STD_LOGIC_VECTOR(CS-1 downto 0) := (others => '1');

constant zeroA: STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0) := (others => '0');
constant oneA: STD_LOGIC_VECTOR(ADDR_SIZE-1 downto 0) := (others => '1');

constant zeros : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '0');
constant ones : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '1');

constant zero8: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
constant one8: STD_LOGIC_VECTOR(7 downto 0) := (others => '1');

--FSM States
type STATES is (IDLE, GETnSET, WORK, WRITE_D);
signal p_state, n_state : STATES := IDLE;

--Visited Vector
signal p_numVisited, n_numVisited : integer range 0 to 2**MAX_NODES := 0;
signal p_visited, n_visited : STD_LOGIC_VECTOR (NS*MAX_NODES-1 downto 0) := (others => '0');

--Distance vector
signal p_clen, n_clen : integer := 0;
signal p_costsI, n_costsI : STD_LOGIC_VECTOR(MAX_NODES*NS - 1 downto 0) := (others => '0');
signal p_costs, n_costs : STD_LOGIC_VECTOR((MAX_NODES*CS) - 1 downto 0) := (others => '1');

--Previous Nodes Vector
signal p_prevI, n_prevI : STD_LOGIC_VECTOR(MAX_NODES*NS - 1 downto 0) := (others => '1');
signal p_prev, n_prev : STD_LOGIC_VECTOR(MAX_NODES*NS - 1 downto 0) := (others => '1');

--Current Minimum Node
signal p_minI, n_minI : STD_LOGIC_VECTOR(NS - 1);
signal p_min, n_min : STD_LOGIC_VECTOR (CS-1 downto 0) := (others => '0');

--Counters
signal n_counter, p_counter : STD_LOGIC_VECTOR(NS-1 downto 0) := (others => '0');
signal n_gc, p_gc : integer := 0;

--DB Stuff
signal db_len : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

begin

COMP : Comparator
	port map
	(
		indices => n_costsI,
		costs => n_costs,
		out_index => n_minI,
		out_cost => n_min
	);

SEQ: process(clk)
begin
	if (clk'event and clk = '1') then
		p_state <= n_state;

		p_numVisited <= n_numVisited;
		p_visited <= n_visited;

		p_costsI <= n_costsI;
		p_costs <= n_costs;

		p_prevI <= n_prevI;
		p_prev <= n_prev;

		p_minI <= n_minI;
		p_min <= n_min;

    p_gc <= n_gc;
	end if;
end process;
	 	
COMB: process(p_state, p_numVisited, p_visited, p_costsI, p_costs, p_prevI, p_prev, p_minI, p_min)
begin
	case(p_state) is
		when IDLE =>
      n_costsI(NS-1 downto 0) <= router_id;
      n_costs(CS-1 downto 0) <= zeroC;
			if (enable = '1') then
				n_state <= DBLEN;
        db_read <= '1';
        db_addr <= zeroA;
			else
				n_state <= IDLE;
			end if;

    when DBLEN =>
      db_len <= db_din;
      n_state <= GETnSET;
      db_read <= '1';
      db_addr <= 
		when FIND =>
      n_gnsc <= p_gnsc + 1;

      if (p_gnsc = db_len) then
      else

      end if;
		when others =>
			null;
	end case;
--variable indextemp : integer := 0;
--variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--begin
--	case p_state is
--		when IDLE =>
--			n_visited <= (others => '0');
--			n_costs <= ((CS - 1) downto 0 => '0', others => '1');
--			n_prevNode <= (NS - 1 downto 0 => '0', others => '1');
--			if (enable = '1') then
--				n_state <= WORK;
--				--n_minNode <= minIndex;
--			--	--n_newNodes
--				read <= '1';
--				addr_read <= minIndex;
--			else
--				n_state <= IDLE;
--				read <= '0';
--			--	n_minNode <= (others => '0');
--			end if;

--		when WORK =>
--			if (p_visited(MAX_NODES-1) = '1') then
--				n_state <= WRITE_D;
--			else
--				n_state <= WORK;
--			WORK_LOOPS : for i in 0 to PORTS-1 loop
--			if (newNodes(NS*(i+1) - 1 downto NS*i) < onesN) then
--				minNodeIndex := to_integer(unsigned(p_minNode));
--				newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--				newNodeIndex := to_integer(unsigned(newNodes(NS*(i+1) - 1 downto NS*i)));
--				newNodeCI := newNodeIndex*CS;
--				minNodeCI := minNodeIndex*CS;
--				newNodeNI := newNodeIndex*NS;
--				minNodeNI := minNodeIndex*NS;
--				if (p_visited(newNodeIndex) = '0') then
--					if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--						--if (newNodeCI = 0) then
--						--	help(i) <= '1';
--						--else
--						--	help(i) <= '0';
--						--end if;
--						n_costs(((newNodeCI + CS) - 1) downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--						if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--							n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--						else	
--							n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--						end if;
--					end if;
--				end if;
--			end if;
--			end loop;
--		end if;
--		n_costs((to_integer(unsigned(p_minNode)) + 1)*CS - 1 downto to_integer(unsigned(p_minNode))*CS) <= (others => '1');
--		n_visited(to_integer(unsigned(p_minNode))) <= '1';
--		addr_read <= minIndex;
----			indextemp := to_integer(unsigned(p_minNode));
----			n_costs((to_integer(unsigned(p_minNode)) + 1)*CS - 1 downto to_integer(unsigned(p_minNode))*CS) <= (others => '1');
----			n_costs(5 downto 0) <= (others => '1');
----			n_costs((indextemp + 1)*CS - 1 downto indextemp*CS) <= (others => '1');
----			if (to_integer(unsigned(p_minNode)) = 0) then
----			help(4) <= '1';
----			help(2) <= '0';
----			else
----			help(2) <= '1';
----			help(4) <= '0';
----			end if;
----			n_visited(to_integer(unsigned(p_minNode))) <= '1';

--		when others =>
----			n_costs <= ((CS - 1) downto 0 => '0', others => '1');
--			if (p_counter = onesN) then
--				n_state <= IDLE;
--				n_counter <= (others => '0');
--				write <= '0';
--			else
--				n_state <= WRITE_D;
--				n_counter <= p_counter + "1";
--				write <= '1';
--				addr_write <= p_counter;
--				dout <= p_prevNode(NS*(to_integer(unsigned(p_counter)) + 1) - 1 downto NS*to_integer(unsigned(p_counter)));
--			end if;
--	end case;
end process;
--	X: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	begin
--	if (p_state = WORK) then
--		end if;
--	end process;

--X0: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 0;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X1: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 1;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X2: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 2;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X3: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 3;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X4: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 4;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X5: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 5;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X6: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 6;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X7: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NS - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 7;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NS*(i+1) - 1 downto NS*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*CS;
--			minNodeCI := minNodeIndex*CS;
--			newNodeNI := newNodeIndex*NS;
--			minNodeNI := minNodeIndex*NS;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + CS - 1 downto newNodeCI) > p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i)) then
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(minNodeCI + CS -1 downto minNodeCI) + newCosts(CS*(i+1)-1 downto CS*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NS - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NS - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + CS - 1 downto newNodeCI) <= p_costs(newNodeCI + CS - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
end Behavioral;
