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
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity helloActParse is
    Port ( clk : in  STD_LOGIC;
    	   self : in STD_LOGIC_VECTOR(31 downto 0);
		   routerid_val : in STD_LOGIC;
           --ospftemplate : in  STD_LOGIC_VECTOR (191 downto 0);
           --neighbor : in  STD_LOGIC_VECTOR (31 downto 0);
           in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           hellogenin : in  STD_LOGIC;
           stateout : out STD_LOGIC_VECTOR(1 downto 0);
           router_id : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
           in_val : in  STD_LOGIC);
end helloActParse;

architecture Behavioral of helloActParse is
	type FSM is (ONE_WAY, DOWN, INIT, TWO_WAY);
	signal p_state, n_state : FSM := DOWN;
	signal neighbor_id : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal old_neighbor : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal active_neighbor : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
	signal ID_part : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal in_index : STD_LOGIC_VECTOR(1 downto 0) := (others => '1');
	signal curr_time, next_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	constant zero_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
	constant max_time : STD_LOGIC_VECTOR(9 downto 0) := (others => '1');

begin

SEQ1 : process(clk)
begin
	if (clk = '1' and clk'event) then
		p_state <= n_state;
		curr_time <= next_time;
		if (ID_part = "00" and in_val = '1') then
			old_neighbor <= active_neighbor;
		end if;
		if (ID_part = "00" and routerid_val = '1') then
			router_id <= neighbor_id;
		end if ;
	end if;
end process;

COMBSTATE : process(p_state, ID_part, old_neighbor, routerid_val, curr_time, hellogenin, self)
begin
	case( p_state ) is
	
		when DOWN =>
			if (hellogenin = '1') then
				n_state <= INIT;
				next_time <= max_time;
			elsif (routerid_val = '1') then
				n_state <= ONE_WAY;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= zero_time;
			end if ;
		when INIT =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (routerid_val = '1') then
				n_state <= ONE_WAY;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if;
		when ONE_WAY =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			elsif (old_neighbor = self) then
				n_state <= TWO_WAY;
				next_time <= max_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if ;
		when others =>
			if (curr_time = zero_time) then
				n_state <= DOWN;
				next_time <= zero_time;
			else
				n_state <= p_state;
				next_time <= curr_time - 1;
			end if;
	end case ;
end process;


SEQUPDATE : process(clk)
	variable msb : integer;
	variable lsb : integer;
begin
	if (clk = '1' and clk'event) then
		if(in_val = '1') then
			msb := conv_integer(in_index)*8 + 7;
			lsb := conv_integer(in_index)*8;
			case( ID_part ) is
				when "00" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "01";
				when "01" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "10";
				when "10" =>
					active_neighbor(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "11";
				when others =>
					active_neighbor(msb downto lsb) <= in1;
					ID_part <= "00";
					in_index <= (others => '1');
			end case;
		elsif (routerid_val = '1') then
			msb := conv_integer(in_index)*8 + 7;
			lsb := conv_integer(in_index)*8;
			case( ID_part ) is
				when "00" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "01";
				when "01" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "10";
				when "10" =>
					neighbor_id(msb downto lsb) <= in1;
					in_index <= in_index - 1;
					ID_part <= "11";
				when others =>
					neighbor_id(msb downto lsb) <= in1;
					ID_part <= "00";
					in_index <= (others => '1');
			end case;
		else
			in_index <= (others => '1');
			ID_part <= (others => '0');
		end if;
	end if ;		
end process;

stateout <= "00" when p_state = DOWN else
				"01" when p_state = INIT else
				"10" when p_state = ONE_WAY else
				"11";

end Behavioral;
