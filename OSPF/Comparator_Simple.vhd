----------------------------------------------------------------------------------
-- Company: AC/DC
-- Engineer: Saksham Goel
-- 
-- Create Date:    20:15:21 04/26/2019 
-- Module Name:    Comparator_Simple - Dijkstra
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

entity Comparator_Simple is
	Generic
	(
		COST_SIZE : integer := 6;
		NETWORK_SIZE : integer := 6
	);
	Port
	(
		index1, index2 : in STD_LOGIC_VECTOR(COST_SIZE-1 downto 0);
		cost1, cost2 : in STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0);
		out1 : out STD_LOGIC_VECTOR(NETWORK_SIZE-1 downto 0)
	);
end Comparator_Simple;

architecture Behavioral of Comparator_Simple is

begin
SEQ : process (index1, index2, cost1, cost2)
begin
  if (cost1 < cost2) then
  	out1 <= index1;
  else
  	out1 <= index2;
  end if;
end process SEQ;
end Behavioral;

