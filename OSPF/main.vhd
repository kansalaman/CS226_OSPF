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

-- Configuration of the router: 
-- (Not sure)
-- Router ID: 192.168.0.1
-- Interface IPs : 192.168.i.1 (ensure different subnets for each interface?)
-- Subnet mask: 255.255.255.0 for every one?

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
signal ospfhelloheader : STD_LOGIC_VECTOR(191 downto 0);

begin 
ospfhelloheader(183 downto 176) <= "00000001"; -- type

-- parser(...) all the output signals have been mapped.

-- GEN1: helloalive(out1, '1', networkmask, ospfhelloheader, IPheader1, neighbor1, clk, val1, reply_signal1);
-- GEN2: helloalive(out2, '1', networkmask, ospfhelloheader, IPheader2, neighbor2, clk, val2, reply_signal2);
-- GEN3: helloalive(out3, '1', networkmask, ospfhelloheader, IPheader3, neighbor3, clk, val3, reply_signal3);
-- GEN4: helloalive(out4, '1', networkmask, ospfhelloheader, IPheader4, neighbor4, clk, val4, reply_signal4);
-- GEN5: helloalive(out5, '1', networkmask, ospfhelloheader, IPheader5, neighbor5, clk, val5, reply_signal5);
-- GEN6: helloalive(out6, '1', networkmask, ospfhelloheader, IPheader6, neighbor6, clk, val6, reply_signal6);
-- GEN7: helloalive(out7, '1', networkmask, ospfhelloheader, IPheader7, neighbor7, clk, val7, reply_signal7);
-- GEN8: helloalive(out8, '1', networkmask, ospfhelloheader, IPheader8, neighbor8, clk, val8, reply_signal8);

end Behavioral;

