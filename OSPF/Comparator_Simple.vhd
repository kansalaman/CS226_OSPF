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
		SIZE : integer := 6
	);
	Port
	(
		in1, in2 : in STD_LOGIC_VECTOR(SIZE-1 downto 0);
		out1 : out STD_LOGIC_VECTOR(SIZE-1 downto 0)
	);
end Comparator_Simple;

architecture Behavioral of Comparator_Simple is

begin
SEQ : process (in1, in2)
begin
  if (in1 < in2) then
  	out1 <= in1;
  else
  	out1 <= in2;
  end if;
end process SEQ;
end Behavioral;

