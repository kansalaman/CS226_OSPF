----------------------------------------------------------------------------------
-- Company: 		AC/DC
-- Engineer: 
-- 
-- Create Date:    08:19:38 05/04/2019 
-- Design Name: 
-- Module Name:    MainModule - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--Uncomment the following library declaration if using
--arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MainModule is
	Port
	(
		clk : in std_logic;
		--Inputs
		in1, in2, in3, in4, in5, in6, in7, in8 : in std_logic_vector(7 downto 0);
		in_val1, in_val2, in_val3, in_val4, in_val5, in_val6, in_val7, in_val8 : in std_logic_vector(7 downto 0);

		--Outputs
		out1, out2, out3, out4, out5, out6, out7, out8 : out std_logic_vector(7 downto 0);
		out_val1, out_val2, out_val3, out_val4, out_val5, out_val6, out_val7, out_val8 : std_logic;

		--Dijkstra button
		dijkstra_on : in std_logic := '0';
	);
end MainModule;

architecture Behavioral of MainModule is

begin


end Behavioral;

