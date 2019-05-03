----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:23:26 05/03/2019 
-- Design Name: 
-- Module Name:    LSAFilter - Behavioral 
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

entity LSAFilter is
    Port ( clk : in  STD_LOGIC;
           wr_en : in  STD_LOGIC;
           rst : in STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (7 downto 0);
           rd_en : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (7 downto 0);
           empty : out  STD_LOGIC);
end LSAFilter;

architecture Behavioral of LSAFilter is
	COMPONENT FIFOLSU IS
	  PORT (
	    clk : IN STD_LOGIC;
	    rst : IN STD_LOGIC;
	    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	    wr_en : IN STD_LOGIC;
	    rd_en : IN STD_LOGIC;
	    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	    full : OUT STD_LOGIC;
	    empty : OUT STD_LOGIC;
	    data_count : OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	  );
	END COMPONENT;

	signal outqueue_din: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
	signal inqueue_dout : STD_LOGIC_VECTOR(7 downto 0) ;
	signal outqueue_wr_en, inqueue_rd_en : STD_LOGIC := '0';
	signal inqueue_empty : STD_LOGIC;
begin
	INPUTQUEUE : FIFOLSU PORT MAP (clk => clk,
								   rst => rst,
								   din => din,
								   wr_en => wr_en,
								   rd_en => inqueue_rd_en,
								   dout => inqueue_dout,
								   full => open,
								   empty => inqueue_empty,
								   data_count => open);
	OUTPUTQUEUE : FIFOLSU PORT MAP (clk => clk,
									rst => rst,
									din => outqueue_din,
									wr_en => outqueue_wr_en,
									rd_en => rd_en,
									dout => dout,
									full => open,
									empty => empty,
									data_count => open);
 
end Behavioral;

