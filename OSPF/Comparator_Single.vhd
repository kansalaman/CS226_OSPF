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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator_Single is
	Generic 
	( 
		NETWORK_SIZE : integer := 6;
		COST_SIZE : integer := 6
	);	  
    Port 
    (
    	costs : in STD_LOGIC_VECTOR(((2 ** NETWORK_SIZE)*COST_SIZE) - 1);
    	out1 : out STD_LOGIC_VECTOR((NETWORK_SIZE - 1) downto 0) := (others => '0')
    );
end Comparator_Single;

architecture Behavioral of Comparator_Single is
component Comparator_Simple is
	Generic
	(
		SIZE : integer := 6
	);
	Port
	(
		in1, in2 : in STD_LOGIC_VECTOR(SIZE-1 downto 0);
		out1 : out STD_LOGIC_VECTOR(SIZE-1 downto 0)
	);
end component;
begin
  	COMPGEN : for i in 0 to (2 ** (NETWORK_SIZE - 1) - 1) generate
  		X : Comparator_Simple
  		generic map
  		(
  			SIZE => COST_SIZE
  		)
  		port map
  		(
  			in1 => costs(((2*i + 1)*COST_SIZE - 1) downto (2*i*COST_SIZE)),
  			in2 => costs(((2*i + 2)*COST_SIZE - 1) downto ((2*i + 1)*COST_SIZE)),
  			out1 => out1((i+1)*COST_SIZE-1 downto i*COST_SIZE)
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