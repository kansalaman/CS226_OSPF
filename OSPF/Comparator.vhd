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
    	clk : in STD_LOGIC;
    	costs : in STD_LOGIC_VECTOR(((2 ** NETWORK_SIZE)*COST_SIZE) - 1);
    	out1 : out STD_LOGIC_VECTOR((NETWORK_SIZE - 1) downto 0)
    );
end Comparator;

architecture Behavioral of Comparator is
component Comparator_Single is
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
end component;
signal temp1, temp2 : STD_LOGIC_VECTOR(((2 ** NETWORK_SIZE)*COST_SIZE) - 1);

begin
COMPGEN : for I in 0 to NETWORK_SIZE-1 generate
	INIT :if I = 0 generate
		X : Comparator_Single
		generic map
		(
			NETWORK_SIZE => NETWORK_SIZE,
			COST_SIZE => COST_SIZE
		)
		port map
		(
			costs => costs,
			out1 => temp2
		);
	end generate INIT;
	--X : Comparator_Single
	--generic map
	--(
	--	NETWORK_SIZE => NETWORK_SIZE,
	--	COST_SIZE => COST_SIZE
	--)
	--port map
	--(
	--	costs => costs,
	--	out1 => temp2
	--);
end generate;

end Behavioral;

