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

-- ROUTER INDEX = "000000"
entity Dijkstra is
	Generic 
	( 
		PORTS : integer := 8;
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6;
		DB_ADDR_SIZE : integer := 32;
		ROUTER_INDEX : integer := 0
	);	  
  Port 
  ( 
  	din : in  STD_LOGIC_VECTOR ((PORTS*(NETWORK_SIZE+COST_SIZE) - 1) downto 0);
  	ip_in : in STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0);
  	addr_read : out  STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
  	read : out STD_LOGIC;
  	write : out STD_LOGIC := '0';
  	addr_write : out STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
  	--dout : out STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
    dout :  out STD_LOGIC_VECTOR(2*DB_ADDR_SIZE-1 downto 0) := (others => '0');
  	enable : in  STD_LOGIC := '0';
  	done : out STD_LOGIC := '1';
  	help : out STD_LOGIC_VECTOR(PORTS-1 downto 0) := (others => '0');
  	router_ip : in STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0) := (others => '0');
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
type STATES is (IDLE, INIT, WORK, WRITE_D);
constant zeros : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '0');
constant oneN : STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '1');
constant ones : STD_LOGIC_VECTOR((MAX_NODES-1) downto 0) := (others => '1');
signal p_state, n_state : STATES := IDLE;
signal p_visited, n_visited : STD_LOGIC_VECTOR ((MAX_NODES-1) downto 0) := (others => '0');
--signal p_prevUpdated, n_prevUpdated : STD_LOGIC_VECTOR ((PORTS - 1) downto 0) := (others => '0');
signal p_costs, n_costs : STD_LOGIC_VECTOR((MAX_NODES*COST_SIZE) - 1 downto 0) := (others => '1');
signal p_prevNode, n_prevNode : STD_LOGIC_VECTOR((MAX_NODES * NETWORK_SIZE - 1) downto 0) := (others => '1');
signal p_prevIP, n_prevIP : STD_LOGIC_VECTOR(MAX_NODES*DB_ADDR_SIZE - 1 downto 0) := (others => '1');
signal p_minNode, n_minNode : STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0) := (others => '0');
signal newNodes : STD_LOGIC_VECTOR ((PORTS*NETWORK_SIZE - 1)   downto 0);
signal newNodesIP : STD_LOGIC_VECTOR (PORTS*DB_ADDR_SIZE-1 downto 0);
signal minIndex : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0);
signal minCost : STD_LOGIC_VECTOR(COST_SIZE - 1 downto 0);
signal newCosts : STD_LOGIC_VECTOR ((PORTS*COST_SIZE - 1) downto 0) := (others => '0');
signal n_counter, p_counter : STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0) := (others => '0');
signal n_initc, p_initc : integer range 0 to 8 := 0;

signal n_rootEdges, p_rootEdges : STD_LOGIC_VECTOR ((PORTS*NETWORK_SIZE - 1) downto 0) := (others => '1');
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
	 	p_prevIP <= n_prevIP;
	 	p_minNode <= minIndex;
    p_rootEdges <= n_rootEdges;
	 	--newNodes <= n_newNodes;
	 	--newNodes <= din(PORTS*NETWORK_SIZE - 1 downto 0);
	 	--newCosts <= din(PORTS*(NETWORK_SIZE + COST_SIZE) - 1 downto PORTS*NETWORK_SIZE);
	 	p_initc <= n_initc;
	 	if (n_state <= WRITE_D) then
	 		p_counter <= n_counter;
	 	else
	 		p_counter <= (others => '0');
	 	end if;
	end if;
end process;
	 	
COMB: process(p_minNode, minIndex, p_state, enable, p_visited, p_counter, p_prevNode, newNodes, newCosts,
              router_ip, p_initc, din, ip_in, p_rootEdges, p_costs, p_prevIP)
variable indextemp : integer := 0;
variable newNodeLogic : STD_LOGIC_VECTOR(NETWORK_SIZE - 1 downto 0) := (others => '0');
variable nNodeIPLogic : STD_LOGIC_VECTOR(DB_ADDR_SIZE-1 downto 0) := (others => '0');
variable tempindex : integer := 0;
variable newNodeIndex, minNodeIndex, newNodeCI, minNodeCI, newNodeNI, minNodeNI, newNodeIPI, minNodeIPI : integer range 0 to 2**NETWORK_SIZE-1 := 0;
begin
	case p_state is
		when IDLE =>
			n_visited <= (others => '0');
			n_costs <= ((ROUTER_INDEX + 1)*COST_SIZE - 1 downto ROUTER_INDEX*COST_SIZE => '0', others => '1');
			n_prevNode((ROUTER_INDEX + 1)*NETWORK_SIZE - 1 downto ROUTER_INDEX*NETWORK_SIZE) <= STD_LOGIC_VECTOR(to_unsigned(ROUTER_INDEX, NETWORK_SIZE));
			n_prevIP((ROUTER_INDEX + 1)*DB_ADDR_SIZE - 1 downto ROUTER_INDEX*DB_ADDR_SIZE) <= router_ip;
			n_initc <= 0;
      n_counter <= (others => '0');
      if (enable = '1') then
        n_state <= INIT;
        read <= '1';
        addr_read <= std_logic_vector(to_unsigned(ROUTER_INDEX, NETWORK_SIZE));
      else
        n_state <= IDLE;
        read <= '0';
      end if;

		when INIT =>
      if (p_initc = 0) then
        n_rootEdges <= din(PORTS*NETWORK_SIZE-1 downto 0);
        addr_read <= din(NETWORK_SIZE-1 downto 0);
        n_initc <= p_initc + 1;
        read <= '1';
        n_prevIP((ROUTER_INDEX+1)*DB_ADDR_SIZE-1 downto ROUTER_INDEX*DB_ADDR_SIZE) <= ip_in;
      elsif (p_initc < 8) then
        n_rootEdges <= p_rootEdges;
        addr_read <= p_rootEdges((p_initc+1)*NETWORK_SIZE-1 downto p_initc*NETWORK_SIZE);
        if (not(p_rootEdges(p_initc*NETWORK_SIZE-1 downto (p_initc-1)*NETWORK_SIZE) = oneN)) then
          tempindex := to_integer(unsigned(p_rootEdges(p_initc*NETWORK_SIZE-1 downto (p_initc-1)*NETWORK_SIZE)));
          n_prevIP((tempindex + 1)*DB_ADDR_SIZE-1 downto tempindex*DB_ADDR_SIZE) <= ip_in;
          n_state <= INIT;
          n_initc <= p_initc + 1;
          read <= '1';
        else
          n_rootEdges <= p_rootEdges;
          read <= '1';
          addr_read <= minIndex;
          n_state <= WORK;
          n_initc <= 0;
        end if;
      else
        n_rootEdges <= p_rootEdges;
        read <= '1';
        addr_read <= minIndex;
        n_state <= WORK;
        n_initc <= 0;
      end if;

		when WORK =>
			if (p_visited(MAX_NODES-1) = '1') then
        addr_read <= p_counter;
				n_state <= WRITE_D;
        n_counter <= p_counter + 1;
        read <= '1';
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
  				newNodeIPI := newNodeIndex*DB_ADDR_SIZE;
  				minNodeNI := minNodeIndex*NETWORK_SIZE;
  				minNodeIPI := minNodeIndex*DB_ADDR_SIZE;
  				if (p_visited(newNodeIndex) = '0') then
  					if (p_costs(newNodeCI + COST_SIZE - 1 downto newNodeCI) > p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i)) then
  						n_costs(((newNodeCI + COST_SIZE) - 1) downto newNodeCI) <= p_costs(minNodeCI + COST_SIZE -1 downto minNodeCI) + newCosts(COST_SIZE*(i+1)-1 downto COST_SIZE*i);
  						if (p_minNode = STD_LOGIC_VECTOR(to_unsigned(ROUTER_INDEX, NETWORK_SIZE))) then -- CHECK IF MINIMUM NODE IS THE ROUTER ITSELF; DIRECT PATH
  							n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= newNodeLogic;
                n_prevIP(newNodeIPI + DB_ADDR_SIZE - 1 downto newNodeIPI) <= p_prevIP(newNodeIPI + DB_ADDR_SIZE - 1 downto newNodeIPI);
  						else	
  							n_prevNode(newNodeNI + NETWORK_SIZE - 1 downto newNodeNI) <= p_prevNode(minNodeNI + NETWORK_SIZE - 1 downto minNodeNI);
                n_prevIP(newNodeIPI + DB_ADDR_SIZE - 1 downto newNodeIPI) <= p_prevIP(minNodeIPI + DB_ADDR_SIZE - 1 downto minNodeIPI);
  						end if;
  					end if;
  				end if;
  			end if;
			end loop;
      addr_read <= minIndex;
		end if;
		n_costs((to_integer(unsigned(p_minNode)) + 1)*COST_SIZE - 1 downto to_integer(unsigned(p_minNode))*COST_SIZE) <= (others => '1');
		n_visited(to_integer(unsigned(p_minNode))) <= '1';

		
		when others =>
			if (p_counter = onesN) then
				n_state <= IDLE;
				n_counter <= (others => '0');
				write <= '0';
			else
				n_state <= WRITE_D;
				n_counter <= p_counter + "1";
				write <= '1';
				addr_write <= p_counter;
        addr_read <= p_counter;
        read <= '1';
				dout <= ip_in & p_prevIP(DB_ADDR_SIZE*(to_integer(unsigned(p_counter))) - 1 downto DB_ADDR_SIZE*to_integer(unsigned(p_counter-1)));
			end if;
	end case;

end process;
end Behavioral;
