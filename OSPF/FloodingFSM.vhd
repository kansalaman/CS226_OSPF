----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    07:24:26 05/04/2019 
-- Design Name: 
-- Module Name:    FloodingFSM - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FloodingFSM is
	Port
	(
		clk : in std_logic;
		val : in std_logic;
		din : in std_logic_vector(7 downto 0);
		port_in : in std_logic_vector(7 downto 0);
		out1, out2, out3, out4, out5, out6, out7, out8 : out std_logic_vector(7 downto 0);
		write1, write2, write3, write4, write5, write6, write7, write8 : out std_logic
	);
end FloodingFSM;

architecture Behavioral of FloodingFSM is
type STATES is (IDLE, FLOODING);
signal p_state, n_state : STATES := IDLE;
signal p_temp, n_temp : std_logic_vector(7 downto 0) := (others => '0');
signal write_arr : std_logic_vector(7 downto 0) := (others => '1');
type OutArrayType is array(7 downto 0) of std_logic_vector(7 downto 0);
signal out_arr : OutArrayType;
begin
write1 <= not(write_arr(0));
write2 <= not(write_arr(1));
write3 <= not(write_arr(2));
write4 <= not(write_arr(3));
write5 <= not(write_arr(4));
write6 <= not(write_arr(5));
write7 <= not(write_arr(6));
write8 <= not(write_arr(7));
out1 <= out_arr(0);
out2 <= out_arr(1);
out3 <= out_arr(2);
out4 <= out_arr(3);
out5 <= out_arr(4);
out6 <= out_arr(5);
out7 <= out_arr(6);
out8 <= out_arr(7);
SEQ : process (clk)
begin
  if (clk'event and clk = '1') then
    p_state <= n_state;
    p_temp <= n_temp;
  end if;
end process SEQ;

COMB : process(p_state, port_in, val, din, p_temp)
begin
  case(p_state) is
    when IDLE =>
	 writeIDLE : for i in 0 to 7 loop
        out_arr(i) <= (others => '0');
      end loop;
    write_arr <= (others => '1');
      if (val = '1') then
        n_temp <= din;
        n_state <= FLOODING;
      else
        n_temp <= (others => '0');
        n_state <= IDLE;
      end if;
    when others =>
	 n_temp <= din;
   write_arr <= port_in;
   writeLoop : for i in 0 to 7 loop
     if (port_in(i) = '0') then
       out_arr(i) <= p_temp;
     else
       out_arr(i) <= (others => '0');
     end if;
   end loop;
    if (val = '1') then
		  n_state <= FLOODING;
    else
      --write_arr <= (others => '1');
      --writeNULL : for i in 0 to 7 loop
      --  out_arr(i) <= (others => '0');
      --end loop;
		n_state <= IDLE;
    end if;
  end case;
end process;

end Behavioral;

