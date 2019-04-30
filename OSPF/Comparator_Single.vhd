----------------------------------------------------------------------------------
-- Company: AC/DC
-- Engineer: Saksham Goel
-- 
-- Create Date:    20:15:21 04/26/2019 
-- Module Name:    Comparator_Single - Dijkstra
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

entity Comparator_Single is
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
    	out1 : out STD_LOGIC_VECTOR(((2 ** (NODES_SIZE - 1))*NETWORK_SIZE) - 1 downto 0) := (others => '0')
    );
end Comparator_Single;


architecture Behavioral of Comparator_Single is
component Comparator_Simple is
	Generic
	(
		COST_SIZE : integer := 6;
		NETWORK_SIZE : integer := 6
	);
	Port
	(
		index1, index2 : in STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0);
		cost1, cost2 : in STD_LOGIC_VECTOR(COST_SIZE-1 downto 0);
		out1 : out STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0)
	);
end component;
begin
  	COMPGEN : for i in 0 to (2 ** (COST_SIZE - 1) - 1) generate
  		X : Comparator_Simple
  		generic map
  		(
  			COST_SIZE => COST_SIZE,
  			NETWORK_SIZE => NETWORK_SIZE
  		)
  		port map
  		(
  			index1 => indices((2*I + 1)*NETWORK_SIZE - 1 downto 2*NETWORK_SIZE),
  			index2 => indices((2*I + 2)*NETWORK_SIZE - 1 downto (2*I + 1)*NETWORK_SIZE),
  			cost1 => costs((2*I + 1)*NETWORK_SIZE - 1 downto 2*NETWORK_SIZE),
  			cost2 => costs((2*I + 2)*NETWORK_SIZE - 1 downto (2*I + 1)*NETWORK_SIZE),
  			out1 => out1((I+1)*NETWORK_SIZE - 1 downto I*NETWORK_SIZE)
  		);
  --		SEQ: process(costs)
  --		begin
		--	if (costs(((2*i + 1)*COST_SIZE - 1) downto (2*i*COST_SIZE)) < costs(((2*i + 2)*COST_SIZE - 1) downto ((2*i + 1)*COST_SIZE))) generate
		--		out1(i) <= costs(((2*i + 1)*COST_SIZE - 1) downto (2*i*COST_SIZE));
		--	else
		--		out1(i) <= costs(((2*i + 2)*COST_SIZE - 1) downto ((2*i + 1)*COST_SIZE));
		--	end if;
		--end process SEQ;
  	end generate;
end Behavioral;