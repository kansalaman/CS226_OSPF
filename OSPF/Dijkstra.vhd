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

-- ROUTER INDEX = "000000"
entity Dijkstra is
	Generic 
	( 
		PORTS : integer := 8;
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6
	);	  
    Port 
    ( 
    	din : in  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0);
		addr_read : out  STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
		read : out STD_LOGIC;
		write : out STD_LOGIC := '0';
		addr_write : out STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
		dout : out STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
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
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6
	);	  
    Port 
    (
    	costs : in STD_LOGIC_VECTOR(((2 ** NETWORK_SIZE)*COST_SIZE) - 1 downto 0);
    	out_index : out STD_LOGIC_VECTOR((NETWORK_SIZE - 1) downto 0);
    	out_cost : out STD_LOGIC_VECTOR((COST_SIZE - 1) downto 0)
    );
end component;

constant MAX_NODES : integer := 2 ** NETWORK_SIZE;
constant MAX_COST : integer := 2 ** COST_SIZE;
constant onesN: STD_LOGIC_VECTOR((NETWORK_SIZE -1) downto 0) := (others => '1');
type STATES is (IDLE, WORK, WRITE_D);
constant zeros : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '0');
constant ones : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '1');
signal p_state, n_state : STATES := IDLE;
signal p_visited, n_visited : STD_LOGIC_VECTOR ((MAX_NODES-1) downto 0) := (others => '0');
--signal p_prevUpdated, n_prevUpdated : STD_LOGIC_VECTOR ((PORTS - 1) downto 0) := (others => '0');
signal p_costs, n_costs : STD_LOGIC_VECTOR((MAX_NODES*COST_SIZE) - 1 downto 0) := ((COST_SIZE - 1) downto 0 => '0', others => '1');
signal p_prevNode, n_prevNode : STD_LOGIC_VECTOR((MAX_NODES * NETWORK_SIZE - 1) downto 0) := (NETWORK_SIZE - 1 downto 0 => '0', others => '1');
signal p_minNode, n_minNode : STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
signal newNodes : STD_LOGIC_VECTOR ((PORTS*NETWORK_SIZE - 1)   downto 0);
signal minIndex : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0);
signal minCost : STD_LOGIC_VECTOR(COST_SIZE - 1 downto 0);
signal newCosts : STD_LOGIC_VECTOR ((PORTS*COST_SIZE - 1) downto 0);
signal n_counter, p_counter : STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
begin
newNodes <= din(PORTS*NETWORK_SIZE - 1 downto 0);
newCosts <= din(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto PORTS*NETWORK_SIZE);
COMP : Comparator
	port map
	(
		costs => n_costs,
		out_index => minIndex,
		out_cost => minCost
	);
SEQ: process(clk)
begin
	if (clk'event and clk = '1') then
		p_state <= n_state;
	 	if (n_visited = ones) then
	 		done <= '1';
	 		p_visited <= (others => '0');
	 	else
	 		done <= '0';
	 		p_visited <= n_visited;
	 	end if;
	 	--p_prevUpdated <= n_prevUpdated;
	 	p_costs <= n_costs;
	 	p_prevNode <= n_prevNode;
	 	p_minNode <= minIndex;
	 	--newNodes <= n_newNodes;

	 	if (n_state <= WRITE_D) then
	 		p_counter <= n_counter;
	 	else
	 		p_counter <= (others => '0');
	 	end if;
	end if;
end process;
	 	
COMB: process(p_minNode, minIndex, p_state, enable, p_visited, p_counter, p_prevNode, newNodes, newCosts)
variable indextemp : integer := 0;
variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
begin
	case p_state is
		when IDLE =>
			n_visited <= (others => '0');
			n_costs <= ((COST_SIZE - 1) downto 0 => '0', others => '1');
			n_prevNode <= (NETWORK_SIZE - 1 downto 0 => '0', others => '1');
			if (enable = '1') then
				n_state <= WORK;
				--n_minNode <= minIndex;
			--	--n_newNodes
				read <= '1';
				addr_read <= minIndex;
			else
				n_state <= IDLE;
				read <= '0';
			--	n_minNode <= (others => '0');
			end if;

		when WORK =>
			if (p_visited(MAX_NODES-1) = '1') then
				n_state <= WRITE_D;
			else
				n_state <= WORK;
			WORK_LOOPS : for i in 0 to PORTS-1 loop
			if (newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i) < onesN) then
				minNodeIndex := to_integer(unsigned(p_minNode));
				newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
				newNodeIndex := to_integer(unsigned(newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i)));
				newNodeCI := newNodeIndex*COST_SIZE;
				minNodeCI := minNodeIndex*COST_SIZE;
				newNodeNI := newNodeIndex*NETWORK_SIZE;
				minNodeNI := minNodeIndex*NETWORK_SIZE;
				if (p_visited(newNodeIndex) = '0') then
					if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
						--if (newNodeCI = 0) then
						--	help(i) <= '1';
						--else
						--	help(i) <= '0';
						--end if;
						n_costs(((newNodeCI + COST_SIZE) - 1) downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
						if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
							n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
						else	
							n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
						end if;
					end if;
				end if;
			end if;
			end loop;
		end if;
		n_costs((to_integer(unsigned(p_minNode)) + 1)*COST_SIZE - 1 downto to_integer(unsigned(p_minNode))*COST_SIZE) <= (others => '1');
		n_visited(to_integer(unsigned(p_minNode))) <= '1';
		addr_read <= minIndex;
--			indextemp := to_integer(unsigned(p_minNode));
--			n_costs((to_integer(unsigned(p_minNode)) + 1)*COST_SIZE - 1 downto to_integer(unsigned(p_minNode))*COST_SIZE) <= (others => '1');
--			n_costs(5 downto 0) <= (others => '1');
--			n_costs((indextemp + 1)*COST_SIZE - 1 downto indextemp*COST_SIZE) <= (others => '1');
--			if (to_integer(unsigned(p_minNode)) = 0) then
--			help(4) <= '1';
--			help(2) <= '0';
--			else
--			help(2) <= '1';
--			help(4) <= '0';
--			end if;
--			n_visited(to_integer(unsigned(p_minNode))) <= '1';

		when others =>
--			n_costs <= ((COST_SIZE - 1) downto 0 => '0', others => '1');
			if (p_counter = onesN) then
				n_state <= IDLE;
				n_counter <= (others => '0');
				write <= '0';
			else
				n_state <= WRITE_D;
				n_counter <= p_counter + "1";
				write <= '1';
				addr_write <= p_counter;
				dout <= p_prevNode(NETWORK_SIZE*(to_integer(unsigned(p_counter)) + 1) - 1 downto NETWORK_SIZE*to_integer(unsigned(p_counter)));
			end if;
	end case;
end process;
--	X: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	begin
--	if (p_state = WORK) then
--		end if;
--	end process;

--X0: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 0;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X1: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 1;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X2: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 2;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X3: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 3;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X4: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 4;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X5: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 5;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X6: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 6;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
--X7: process(p_minNode, p_costs, newCosts, p_prevNode, newNodes, p_visited, p_state)
--	variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := "000000";
--	variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI : integer := 0;
--	constant i : integer := 7;
--	begin
--		if (p_state = WORK) then
--			minNodeIndex := to_integer(unsigned(p_minNode));
--			newNodeLogic := newNodes(NETWORK_SIZE*(i+1) - 1 downto NETWORK_SIZE*i);
--			newNodeIndex := to_integer(unsigned(newNodeLogic));
--			newNodeCI := newNodeIndex*COST_SIZE;
--			minNodeCI := minNodeIndex*COST_SIZE;
--			newNodeNI := newNodeIndex*NETWORK_SIZE;
--			minNodeNI := minNodeIndex*NETWORK_SIZE;
--			if (p_visited(newNodeIndex) = '0') then
--				if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
--					if (p_minNode = "000000") then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
--					else
--						n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
--					end if;
--				else
--					n_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) <= p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI);
--				end if;
--			end if;
--		end if;
--	end process;
end Behavioral;
