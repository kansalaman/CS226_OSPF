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
	val : in STD_LOGIC; -- The parser tells that it has read the new-packet info properly, so maintain a local copy of the neighbor's neigh and compare with that if the timer strikes and the packet is currently being read.
	myrouterid : in STD_LOGIC_VECTOR(31 downto 0);
	readneigh : in STD_LOGIC_VECTOR(31 downto 0);
	active : out std_logic);
end hellodead;

architecture Behavioral of hellodead is
signal isactive : std_logic := '0';
signal p_state, n_state: states := WAITING;
signal counter: STD_LO = routerdeadinterval

begin
-- Hello Parser keeps the value mapped to some variable permanently and changes the value if necessary.
-- Actually use some field that is always renewed to ensure that the mapped values have been updated.
-- calculate time at which the neighbour value is to be checked == routerdeadinterval
-- change the mapped value of down signal iff neighbour's hello-packet content neighvalue does not match my routerID. 
-- the down signal is always set to some value but will be considered only if the main FSM is in its two-way
end Behavioral;

