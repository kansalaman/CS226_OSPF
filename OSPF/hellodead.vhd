----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hellodead is
port (  routerdeadinterval : in STD_LOGIC_VECTOR(31 downto 0);
		val : in std_logic;
		routerid : in STD_LOGIC_VECTOR(31 downto 0);
		active : out std_logic);
end hellodead;

architecture Behavioral of hellodead is

begin


end Behavioral;

