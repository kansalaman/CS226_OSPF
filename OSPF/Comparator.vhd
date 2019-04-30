----------------------------------------------------------------------------------
-- Company: AC/DC
-- Engineer: Saksham Goel
-- 
-- Create Date:    20:15:21 04/26/2019 
-- Module Name:    Comparator - Dijkstra
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator is
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
end Comparator;

architecture Behavioral of Comparator is
component Comparator_Single is
	Generic 
	( 
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6;
		NODES_SIZE : integer := 6	--Bits
	);	  
    Port 
    (
    	costs : in STD_LOGIC_VECTOR(((2 ** NODES_SIZE)*COST_SIZE) - 1 downto 0);
    	indices : in STD_LOGIC_VECTOR(((2 ** NODES_SIZE)*NETWORK_SIZE) - 1 downto 0);
    	out_index : out STD_LOGIC_VECTOR(((2 ** (NODES_SIZE - 1))*NETWORK_SIZE) - 1 downto 0) := (others => '0');
    	out_cost : out STD_LOGIC_VECTOR((2 ** (NODES_SIZE - 1)*COST_SIZE) - 1 downto 0) := (others => '0')
    );
end component;

component Comparator_Simple is
	Generic
	(
		COST_SIZE : integer := 6;
		NETWORK_SIZE : integer := 6
	);
	Port
	(
		index1, index2 : in STD_LOGIC_VECTOR(COST_SIZE-1 downto 0);
		cost1, cost2 : in STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0);
		out_index : out STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0);
		out_cost : out STD_LOGIC_VECTOR(COST_SIZE-1 downto 0)
	);
end component;

--type MatrixInd is array(NETWORK_SIZE - 1 downto 0, (2**(NETWORK_SIZE-1)) - 1 downto 0) of STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0);
--type MatrixCost is array(NETWORK_SIZE - 1 downto 0, (2**(NETWORK_SIZE-1)) - 1 downto 0) of STD_LOGIC_VECTOR(COST_SIZE-1 downto 0);
signal tempindices : STD_LOGIC_VECTOR((63*NETWORK_SIZE - 1) downto 0);
signal tempcosts :  STD_LOGIC_VECTOR((63*COST_SIZE - 1) downto 0);

--signal tempindices : MatrixInd;
--signal tempcosts : MatrixCost;

begin
COMPSIMPLE : for J in 0 to 31 generate
	INIT : Comparator_Simple
		generic map
		(
			COST_SIZE => COST_SIZE,
			NETWORK_SIZE => NETWORK_SIZE
		)
		port map
		(
			index1 => STD_LOGIC_VECTOR(to_unsigned(2*J, NETWORK_SIZE)),
			index2 => STD_LOGIC_VECTOR(to_unsigned(2*J+1, NETWORK_SIZE)),
			cost1 => costs((2*J+1)*COST_SIZE - 1 downto 2*J*COST_SIZE),
			cost2 => costs((2*J+2)*COST_SIZE - 1 downto (2*J + 1)*COST_SIZE),
			out_index => tempindices((J+1)*NETWORK_SIZE - 1 downto J*NETWORK_SIZE),
			out_cost => tempcosts((J+1)*COST_SIZE - 1 downto J*NETWORK_SIZE)
			--out_index => tempindices(0, J),
			--out_cost => tempcosts(0, J)
		);
	end generate;
--COMPGEN : for I in 0 to NETWORK_SIZE - 2 generate
--	--INIT: if I = 0 generate
--	--	X : Comparator_Single
--	--	generic map
--	--	(
--	--		NETWORK_SIZE => NETWORK_SIZE,
--	--		COST_SIZE => COST_SIZE
--	--	)
--	--	port map
--	--	(
--	--		costs => costs,
--	--		out1 => temp2
--	--	);
--	--end generate INIT;

--	X : Comparator_Single
--	generic map
--	(
--		NETWORK_SIZE => NETWORK_SIZE,
--		COST_SIZE => COST_SIZE,
--		NODES_SIZE => NETWORK_SIZE - I - 1
--	)
--	port map
--	(
--		costs => tempcosts(())
--		--costs => tempcosts(((2**NETWORK_SIZE) - 1)*COST_SIZE - (2**(I-1))*COST_SIZE downto ((2**NETWORK_SIZE) - 1)*COST_SIZE - (2**I)*COST_SIZE),
--		--indices => tempindices(((2**NETWORK_SIZE) - 1)*NETWORK_SIZE - (2**(I-1))*NETWORK_SIZE downto ((2**NETWORK_SIZE) - 1)*NETWORK_SIZE - (2**I)*NETWORK_SIZE),
--	)

--	--EVEN
--	--X : Comparator_Single
--	--generic map
--	--(
--	--	NETWORK_SIZE => NETWORK_SIZE,
--	--	COST_SIZE => COST_SIZE
--	--)
--	--port map
--	--(
--	--	costs => costs,
--	--	out1 => temp2
--	--);
--end generate;

MODULE1 : Comparator_Single
	generic map
	(
		NETWORK_SIZE => NETWORK_SIZE,
		COST_SIZE => COST_SIZE,
		NODES_SIZE => 5
	)
	port map
	(
		costs => tempcosts(32*COST_SIZE - 1 downto 0),
		indices => tempindices (32*NETWORK_SIZE - 1 downto 0),
		out_cost => tempcosts (48*COST_SIZE - 1 downto 32*COST_SIZE),
		out_index => tempindices (48*NETWORK_SIZE - 1 downto 32*NETWORK_SIZE)
	);
MODULE2 : Comparator_Single
	generic map
	(
		NETWORK_SIZE => NETWORK_SIZE,
		COST_SIZE => COST_SIZE,
		NODES_SIZE => 4
	)
	port map
	(
		costs => tempcosts(48*COST_SIZE - 1 downto 32*COST_SIZE),
		indices => tempindices (48*NETWORK_SIZE - 1 downto 32*NETWORK_SIZE),
		out_cost => tempcosts (56*COST_SIZE - 1 downto 48*COST_SIZE),
		out_index => tempindices (56*NETWORK_SIZE - 1 downto 48*NETWORK_SIZE)
	);
MODULE3 : Comparator_Single
	generic map
	(
		NETWORK_SIZE => NETWORK_SIZE,
		COST_SIZE => COST_SIZE,
		NODES_SIZE => 3
	)
	port map
	(
		costs => tempcosts(56*COST_SIZE - 1 downto 48*COST_SIZE),
		indices => tempindices (56*NETWORK_SIZE - 1 downto 48*NETWORK_SIZE),
		out_cost => tempcosts (60*COST_SIZE - 1 downto 56*COST_SIZE),
		out_index => tempindices (60*NETWORK_SIZE - 1 downto 56*NETWORK_SIZE)
	);
MODULE4 : Comparator_Single
	generic map
	(
		NETWORK_SIZE => NETWORK_SIZE,
		COST_SIZE => COST_SIZE,
		NODES_SIZE => 2
	)
	port map
	(
		costs => tempcosts(60*COST_SIZE - 1 downto 56*COST_SIZE),
		indices => tempindices (60*NETWORK_SIZE - 1 downto 56*NETWORK_SIZE),
		out_cost => tempcosts (62*COST_SIZE - 1 downto 60*COST_SIZE),
		out_index => tempindices (62*NETWORK_SIZE - 1 downto 60*NETWORK_SIZE)
	);
MODULE5 : Comparator_Single
	generic map
	(
		NETWORK_SIZE => NETWORK_SIZE,
		COST_SIZE => COST_SIZE,
		NODES_SIZE => 1
	)
	port map
	(
		costs => tempcosts(62*COST_SIZE - 1 downto 60*COST_SIZE),
		indices => tempindices (62*NETWORK_SIZE - 1 downto 60*NETWORK_SIZE),
		out_cost => tempcosts (63*COST_SIZE - 1 downto 62*COST_SIZE),
		out_index => tempindices (63*NETWORK_SIZE - 1 downto 62*NETWORK_SIZE)
	);
out_index <= tempindices(63*NETWORK_SIZE - 1 downto 62*NETWORK_SIZE);
out_cost <= tempcosts(63*COST_SIZE - 1 downto 62*COST_SIZE);

end Behavioral;

