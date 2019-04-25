----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:12:57 04/25/2019 
-- Design Name: 
-- Module Name:    helloActParse - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity helloActParse is
    Port ( clk : in  STD_LOGIC;
    	   self : in STD_LOGIC_VECTOR(31 downto 0);
           networkmask : in  STD_LOGIC_VECTOR (31 downto 0);
           ospftemplate : in  STD_LOGIC_VECTOR (191 downto 0);
           neighbor : in  STD_LOGIC_VECTOR (31 downto 0);
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           hellogenin : in  STD_LOGIC;
           helloactivein : in STD_LOGIC;
           stateout : out STD_LOGIC_VECTOR(1 downto 0);
           inval : in  STD_LOGIC);
end helloActParse;

architecture Behavioral of helloActParse is
	type FSM is (ONE_WAY, DOWN, INIT, TWO_WAY);
	signal p_state, n_state : FSM := DOWN;
	signal active_neighbour : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	

begin

SEQ1 : process(clk)
begin
	if (clk = '1' and clk'event) then
		p_state <= n_state;
	end if ;
end process;

COMB1 : process(inval, p_state, hellogenin, helloactivein, active_neighbour, in1, self)
	variable ID_part : STD_LOGIC_VECTOR(1 downto 0) := "00";
	variable in_index : integer := 31;
	variable msb : integer;
	variable lsb : integer;
begin
	if(inval = '0') then
		case( p_state ) is
			when DOWN =>
				if (hellogenin = '1' and helloactivein = '0') then
					n_state <= INIT;
				else
					n_state <= p_state;
				end if ;
			when others =>
				if (helloactivein = '1') then
					n_state <= DOWN;
				else
					n_state <= p_state;
				end if ;
				n_state <= p_state;
		end case;
	else
		msb := in_index;
		lsb := in_index - 7;
		case( ID_part ) is
			
			when "00" =>
				active_neighbour(msb downto lsb) <= in1;
				in_index := in_index - 8;
				ID_part := "01";
				case( p_state ) is
					when TWO_WAY =>
						n_state <= p_state;
					when others =>
						n_state <= ONE_WAY;
				end case ;
			when "01" =>
				active_neighbour(msb downto lsb) <= in1;
				in_index := in_index - 8;
				ID_part := "10";
				case( p_state ) is
					when TWO_WAY =>
						n_state <= p_state;
					when others =>
						n_state <= ONE_WAY;
				end case ;
			when "10" =>
				active_neighbour(msb downto lsb) <= in1;
				in_index := in_index - 8;
				ID_part := "11";
				case( p_state ) is
					when TWO_WAY =>
						n_state <= p_state;
					when others =>
						n_state <= ONE_WAY;
				end case ;
			when others =>
				active_neighbour(msb downto lsb) <= in1;
				ID_part := "00";
				in_index := 31;
				if(active_neighbour = self or p_state = TWO_WAY) then
					n_state <= TWO_WAY;
				else
					n_state <= ONE_WAY;
				end if;
		end case;
	end if;

end process;


end Behavioral;
