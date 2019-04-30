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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
		addr : out  STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0);
		enable : out  STD_LOGIC := '0';
		clk : in STD_LOGIC
	);
end Dijkstra;

architecture Behavioral of Dijkstra is

constant MAX_NODES : integer := 2 ** NETWORK_SIZE;
constant MAX_COST : integer := 2 ** COST_SIZE;


signal visited : STD_LOGIC_VECTOR ((MAX_NODES-1) downto 0) := (others => '0');
signal prevUpdated : STD_LOGIC_VECTOR ((PORTS - 1) downto 0) := (others => '0');

signal costs : STD_LOGIC_VECTOR((MAX_NODES*COST_SIZE) - 1) := ((COST_SIZE - 1) downto 0 => (others => '0'), others => '1');

signal prevNode : STD_LOGIC_VECTOR((MAX_NODES * NETWORK_SIZE - 1) downto 0) := (others => '1');
signal minNode : STD_LOGIC_VECTOR ((NETWORK_SIZE - 1) downto 0);
signal newNodes : STD_LOGIC_VECTOR ((PORTS*NETWORK_SIZE - 1) downto 0);
signal newCosts : STD_LOGIC_VECTOR ((PORTS*COST_SIZE - 1) downto 0);

begin


end Behavioral;

