----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:30:43 05/03/2019 
-- Design Name: 
-- Module Name:    LSAFetcher - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LSAFetcher is
    Port ( clk : in  STD_LOGIC;
           rd_en : in  STD_LOGIC;
           num_lsa : out  STD_LOGIC_VECTOR (1 downto 0);
           db_rd_en : in  STD_LOGIC;
           db_addr : in  STD_LOGIC_VECTOR (11 downto 0);
           db_din : in  STD_LOGIC_VECTOR (7 downto 0);
           dout : out  STD_LOGIC_VECTOR (7 downto 0));
end LSAFetcher;

architecture Behavioral of LSAFetcher is
	
begin


end Behavioral;

