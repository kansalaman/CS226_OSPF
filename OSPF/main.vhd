----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( in1 : in  STD_LOGIC_VECTOR (8 downto 0);
           out1 : out  STD_LOGIC_VECTOR (7 downto 0);
           in2 : in  STD_LOGIC_VECTOR (8 downto 0);
           out2 : out  STD_LOGIC_VECTOR (7 downto 0);
           in3 : in  STD_LOGIC_VECTOR (8 downto 0);
           out3 : out  STD_LOGIC_VECTOR (7 downto 0);
           in4 : in  STD_LOGIC_VECTOR (8 downto 0);
           out4 : out  STD_LOGIC_VECTOR (7 downto 0);
           in5 : in  STD_LOGIC_VECTOR (8 downto 0);
           out5 : out  STD_LOGIC_VECTOR (7 downto 0);
           in6 : in  STD_LOGIC_VECTOR (8 downto 0);
           out6 : out  STD_LOGIC_VECTOR (7 downto 0);
           in7 : in  STD_LOGIC_VECTOR (8 downto 0);
           out7 : out  STD_LOGIC_VECTOR (7 downto 0);
           in8 : in  STD_LOGIC_VECTOR (8 downto 0);
           out8 : out  STD_LOGIC_VECTOR (7 downto 0));
end main;

architecture Behavioral of main is
signal neighbor1, neighbor2, neighbor3, neighbor4, neighbor5, neighbor6, neighbor7,
		 neighbor8 : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
-- ZEROS = empty
variable OSPFheader : STD_LOGIC_VECTOR(191 downto 0) := (others => '0');
-- Assemble template
variable IPheader : STD_LOGIC_VECTOR(159 downto 0) := (others => '0');
-- Assemble template
constant nullneigh : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
begin 


end Behavioral;

